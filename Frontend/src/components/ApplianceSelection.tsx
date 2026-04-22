import { useEffect } from "react";
import { saveTraining } from "@/lib/api";
import { Check, ArrowLeft, ArrowRight, Calculator } from "lucide-react";
import { APPLIANCE_CATEGORIES } from "@/config/appliances";

interface Props {
  selected: string[];
  details: Record<string, unknown>;
  onUpdate: (selected: string[]) => void;
  onDetailsUpdate: (details: Record<string, unknown>) => void;
  onNext: () => void;
  onBack: () => void;
  mode: "quick" | "detailed";
  trainingId: string;
}

export default function ApplianceSelection({
  selected,
  details,
  onUpdate,
  onDetailsUpdate,
  onNext,
  onBack,
  mode,
  trainingId,
}: Props) {
  // Defaults logic
  useEffect(() => {
    if (details.num_fans === undefined)
      onDetailsUpdate({ ...details, num_fans: 5 });
    if (details.num_led === undefined)
      onDetailsUpdate({ ...details, num_led: 15 });
    if (details.num_cfl === undefined)
      onDetailsUpdate({ ...details, num_cfl: 5 });
    if (details.num_tube === undefined)
      onDetailsUpdate({ ...details, num_tube: 5 });
  }, [details, onDetailsUpdate]);

  const handleUpdate = (newSelected: string[]) => {
    onUpdate(newSelected);
    saveTraining(trainingId, { selected_appliances: newSelected });
  };

  const handleDetailsUpdate = (newDetails: any) => {
    onDetailsUpdate(newDetails);
    saveTraining(trainingId, { appliance_usage: newDetails });
  };

  const toggleAppliance = (id: string) => {
    if (selected.includes(id)) {
      handleUpdate(selected.filter((item) => item !== id));
    } else {
      handleUpdate([...selected, id]);
    }
  };

  const updateDetail = (key: string, value: any) => {
    handleDetailsUpdate({ ...details, [key]: value });
  };

  return (
    <div className="w-full flex flex-col min-h-screen bg-[#0a0e27] animate-in fade-in duration-500 pb-[120px]">
      {/* Sticky Mobile App Header */}
      <div className="sticky top-0 z-40 bg-[#0a0e27]/90 backdrop-blur-md border-b border-slate-800 px-4 py-4 flex items-center justify-between">
        <div className="flex items-center gap-3">
          <div className="w-8 h-8 rounded-full bg-blue-600/20 flex items-center justify-center">
            <span className="text-blue-400 font-bold text-xs">2</span>
          </div>
          <div>
            <h1 className="text-lg font-bold text-white leading-tight">Appliances</h1>
            <p className="text-xs text-blue-400 font-medium">Select what you use</p>
          </div>
        </div>
        <div className="text-xs font-bold text-slate-400 bg-slate-800/50 px-3 py-1.5 rounded-full border border-slate-700/50 shadow-inner">
          <span className={selected.length > 0 ? "text-blue-400" : ""}>{selected.length}</span> Selected
        </div>
      </div>

      <div className="px-4 pt-6 flex-1 max-w-lg mx-auto w-full">
        {/* Config Driven Display */}
        <div className="space-y-6">
          {APPLIANCE_CATEGORIES.map((cat) => (
            <div key={cat.title} className="bg-slate-800/40 border border-slate-700/50 p-5 rounded-3xl shadow-sm">
              <h3 className="text-sm font-bold text-slate-300 uppercase tracking-wider mb-4 flex items-center gap-2">
                <div className="w-1.5 h-4 bg-blue-500 rounded-full"></div>
                {cat.title}
              </h3>
              <div className="grid grid-cols-2 gap-3">
                {cat.items.map((item: any) => (
                  <button
                    key={item.id}
                    className={`flex flex-col items-center justify-center p-4 rounded-2xl border-2 transition-all active:scale-[0.98] ${
                      selected.includes(item.id) 
                        ? "bg-blue-600/20 border-blue-500 shadow-[0_0_15px_rgba(59,130,246,0.15)]" 
                        : "bg-slate-900/50 border-slate-700/50 hover:bg-slate-800"
                    }`}
                    onClick={() => toggleAppliance(item.id)}
                  >
                    <div className="relative mb-3">
                      <div className={`w-12 h-12 rounded-2xl flex items-center justify-center transition-colors ${
                        selected.includes(item.id) ? "bg-blue-500 text-white shadow-lg shadow-blue-500/40" : "bg-slate-800 text-slate-400"
                      }`}>
                        <item.icon className="w-6 h-6" />
                      </div>
                      {selected.includes(item.id) && (
                        <div className="absolute -top-2 -right-2 w-6 h-6 bg-emerald-500 rounded-full flex items-center justify-center border-2 border-[#0a0e27] animate-in zoom-in duration-200">
                          <Check className="w-3 h-3 text-white stroke-[3]" />
                        </div>
                      )}
                    </div>
                    <span className={`text-xs font-bold text-center leading-tight ${selected.includes(item.id) ? "text-white" : "text-slate-400"}`}>
                      {item.label}
                    </span>
                    
                    {/* Quantity Slider - Inline inside button */}
                    {selected.includes(item.id) && item.quantityConfig && (
                      <div className="w-full mt-3 pt-3 border-t border-slate-700/50" onClick={(e) => e.stopPropagation()}>
                        <div className="flex justify-between items-center mb-1.5">
                          <span className="text-[10px] text-blue-300 font-bold uppercase">{item.quantityConfig.label}</span>
                          <span className="text-[10px] bg-blue-500 text-white px-1.5 py-0.5 rounded-md font-black shadow-sm">
                            {details[item.quantityConfig.key] ?? item.quantityConfig.defaultValue}
                          </span>
                        </div>
                        <input
                          type="range"
                          min={item.quantityConfig.min}
                          max={item.quantityConfig.max}
                          value={details[item.quantityConfig.key] ?? item.quantityConfig.defaultValue}
                          onChange={(e) => updateDetail(item.quantityConfig.key!, parseInt(e.target.value))}
                          className="w-full h-1.5 bg-slate-900 rounded-lg appearance-none cursor-pointer accent-blue-400"
                        />
                      </div>
                    )}
                  </button>
                ))}
              </div>
            </div>
          ))}
        </div>
      </div>

      {/* Sticky Bottom Navigation Bar */}
      <div className="fixed bottom-0 left-0 right-0 p-4 bg-slate-900/95 backdrop-blur-xl border-t border-slate-800 z-50 shadow-2xl safe-area-pb">
        <div className="max-w-lg mx-auto flex gap-3">
          <button
            onClick={onBack}
            className="flex-1 flex items-center justify-center gap-2 py-4 rounded-2xl bg-slate-800 text-slate-300 font-semibold active:scale-95 transition-all border border-slate-700"
          >
            <ArrowLeft className="w-5 h-5" />
            Back
          </button>
          <button
            onClick={onNext}
            disabled={selected.length === 0}
            className={`flex-[2] flex items-center justify-center gap-2 py-4 rounded-2xl font-bold active:scale-95 transition-all shadow-lg ${
              selected.length > 0 
                ? "bg-blue-600 text-white shadow-blue-600/30" 
                : "bg-slate-700 text-slate-500 cursor-not-allowed"
            }`}
          >
            {mode === "quick" ? "Calculate Results" : "Usage Details"}
            {mode === "quick" ? <Calculator className="w-5 h-5" /> : <ArrowRight className="w-5 h-5" />}
          </button>
        </div>
      </div>
    </div>
  );
}
