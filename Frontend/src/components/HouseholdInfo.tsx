import { useEffect, useRef } from "react";
import { saveTraining } from "@/lib/api";
import {
  Home,
  Castle,
  Building2,
  Sun,
  CloudRain,
  Snowflake,
  MapPin,
  ArrowRight,
  ArrowLeft,
  Zap
} from "lucide-react";
import { calculateBill } from "@/lib/tariffUtils";

interface HouseholdData {
  num_people: number;
  season: string;
  house_type: string;
  location_type: string;
  kwh: number;
  estimated_bill: number;
}

interface Props {
  data: HouseholdData;
  details: Record<string, unknown>;
  onUpdate: (data: HouseholdData) => void;
  onNext: () => void;
  onBack: () => void;
  mode: "quick" | "detailed";
  trainingId: string | null;
}

export default function HouseholdInfo({
  data,
  details,
  onUpdate,
  onNext,
  onBack,
  mode,
  trainingId,
}: Props) {
  const saveTimerRef = useRef<NodeJS.Timeout | null>(null);

  const handleUpdate = (newData: HouseholdData) => {
    const newBill = calculateBill(newData.kwh || 0);
    const updatedData = { ...newData, estimated_bill: newBill };

    onUpdate(updatedData);

    if (saveTimerRef.current) clearTimeout(saveTimerRef.current);

    saveTimerRef.current = setTimeout(() => {
      if (!trainingId) return;
      saveTraining(trainingId, {
        num_people: updatedData.num_people,
        season: updatedData.season,
        house_type: updatedData.house_type,
        location_type: updatedData.location_type,
        bi_monthly_kwh: updatedData.kwh,
        estimated_bill: updatedData.estimated_bill,
        appliance_usage: details as any,
      });
      saveTimerRef.current = null;
    }, 500);
  };

  useEffect(() => {
    return () => {
      if (saveTimerRef.current) clearTimeout(saveTimerRef.current);
    };
  }, []);

  const biMonthlyCost = calculateBill(data.kwh);
  const monthlyUnits = data.kwh / 2;

  const getStatus = (mUnits: number) => {
    if (mUnits < 120) return { label: "LOW", color: "#10b981", text: "Good efficiency!" };
    if (mUnits < 150) return { label: "AVERAGE", color: "#f59e0b", text: "Standard usage" };
    if (mUnits < 200) return { label: "HIGH", color: "#f97316", text: "Room for savings" };
    return { label: "VERY HIGH", color: "#ef4444", text: "High consumption" };
  };

  const status = getStatus(monthlyUnits);

  const quickSetupOptions = [
    {
      id: "small",
      icon: <Home className="w-6 h-6 text-blue-400" />,
      label: "Small",
      people: 3,
      units: 200,
    },
    {
      id: "medium",
      icon: <Building2 className="w-6 h-6 text-blue-500" />,
      label: "Medium",
      people: 4,
      units: 375,
    },
    {
      id: "large",
      icon: <Castle className="w-6 h-6 text-blue-600" />,
      label: "Large",
      people: 6,
      units: 550,
    },
  ];

  return (
    <div className="w-full flex flex-col min-h-screen bg-[#0a0e27] animate-in fade-in duration-500 pb-[100px]">
      
      {/* Sticky Mobile App Header */}
      <div className="sticky top-0 z-40 bg-[#0a0e27]/90 backdrop-blur-md border-b border-slate-800 px-4 py-4 flex items-center justify-between">
        <div className="flex items-center gap-3">
          <div className="w-8 h-8 rounded-full bg-blue-600/20 flex items-center justify-center">
            <Zap className="w-4 h-4 text-blue-400" />
          </div>
          <div>
            <h1 className="text-lg font-bold text-white leading-tight">SmartWatt</h1>
            <p className="text-xs text-blue-400 font-medium">Household Info</p>
          </div>
        </div>
      </div>

      <div className="px-4 pt-6 space-y-8 flex-1 max-w-lg mx-auto w-full">
        
        {/* Quick Setup - Horizontal Scroll for Mobile */}
        <div>
          <h2 className="text-sm font-semibold text-slate-400 uppercase tracking-wider mb-3">Quick Presets</h2>
          <div className="flex overflow-x-auto pb-4 gap-3 snap-x hide-scrollbar" style={{ scrollbarWidth: 'none', msOverflowStyle: 'none' }}>
            {quickSetupOptions.map((option) => (
              <button
                key={option.id}
                onClick={() => handleUpdate({ ...data, num_people: option.people, kwh: option.units })}
                className="flex-none w-[120px] snap-start bg-slate-800/50 hover:bg-slate-700 active:scale-95 border border-slate-700 rounded-2xl p-4 transition-all flex flex-col items-center justify-center gap-2"
              >
                <div className="p-2 bg-slate-900/50 rounded-full">{option.icon}</div>
                <div className="font-semibold text-sm text-slate-200">{option.label}</div>
              </button>
            ))}
          </div>
        </div>

        {/* Total Units Input - Prominent Native-like Field */}
        <div className="bg-slate-800/40 border border-slate-700/50 p-5 rounded-3xl">
          <label className="text-sm font-semibold text-slate-300 block mb-1">
            Bi-Monthly Units (KSEB Bill)
          </label>
          <p className="text-xs text-slate-500 mb-4">Total units consumed over 2 months</p>
          <div className="relative">
            <input
              type="number"
              min="0"
              inputMode="numeric"
              value={data.kwh || ""}
              onChange={(e) => {
                const val = parseFloat(e.target.value);
                handleUpdate({ ...data, kwh: isNaN(val) ? 0 : Math.max(0, val) });
              }}
              className="w-full bg-slate-900/80 border-2 border-slate-700 rounded-2xl py-4 px-5 text-2xl font-bold text-white focus:border-blue-500 focus:ring-0 transition-all outline-none"
              placeholder="e.g. 250"
            />
            <div className="absolute right-4 top-1/2 -translate-y-1/2 text-slate-500 font-medium">kWh</div>
          </div>
        </div>

        {/* Analysis Card - Compact Mobile Widget */}
        {data.kwh > 0 && (
          <div className="bg-slate-800/60 border border-slate-700 rounded-3xl p-5 relative overflow-hidden">
            <div className="absolute top-0 left-0 w-2 h-full" style={{ background: status.color }}></div>
            <div className="flex justify-between items-start pl-2">
              <div>
                <h4 className="text-xs font-bold text-slate-400 uppercase tracking-wider mb-1">Est. Bill</h4>
                <div className="text-3xl font-black text-white">₹{biMonthlyCost}</div>
              </div>
              <div className="text-right">
                <span className="text-xs font-bold px-2 py-1 rounded-full" style={{ backgroundColor: `${status.color}20`, color: status.color }}>
                  {status.label}
                </span>
                <div className="text-xs text-slate-400 mt-2">{monthlyUnits} units/mo</div>
              </div>
            </div>
          </div>
        )}

        {/* People Slider */}
        <div className="bg-slate-800/40 border border-slate-700/50 p-5 rounded-3xl">
          <label className="text-sm font-semibold text-slate-300 block mb-4">
            Household Size
          </label>
          <div className="flex items-center gap-4">
            <input
              type="range"
              min="1"
              max="15"
              value={data.num_people}
              onChange={(e) => handleUpdate({ ...data, num_people: parseInt(e.target.value) })}
              className="flex-1 h-3 bg-slate-900 rounded-full appearance-none cursor-pointer accent-blue-500"
            />
            <div className="w-12 h-12 bg-blue-600/20 text-blue-400 font-bold text-xl rounded-full flex items-center justify-center shrink-0">
              {data.num_people}
            </div>
          </div>
        </div>

        {/* Touch-Friendly Radio Buttons for House Type */}
        <div>
          <label className="text-sm font-semibold text-slate-300 block mb-3 pl-1">House Type</label>
          <div className="grid grid-cols-1 gap-3">
            {[
              { id: "apartment", label: "Apartment" },
              { id: "independent", label: "Independent House" },
              { id: "villa", label: "Villa" },
            ].map((opt) => (
              <button
                key={opt.id}
                onClick={() => handleUpdate({ ...data, house_type: opt.id })}
                className={`w-full flex items-center justify-between p-4 rounded-2xl border-2 transition-all active:scale-[0.98] ${
                  data.house_type === opt.id 
                    ? "bg-blue-600/20 border-blue-500 text-white" 
                    : "bg-slate-800/40 border-slate-700/50 text-slate-400 hover:bg-slate-800"
                }`}
              >
                <span className="font-medium text-base">{opt.label}</span>
                <div className={`w-5 h-5 rounded-full border-2 flex items-center justify-center ${data.house_type === opt.id ? "border-blue-400" : "border-slate-500"}`}>
                  {data.house_type === opt.id && <div className="w-2.5 h-2.5 bg-blue-400 rounded-full" />}
                </div>
              </button>
            ))}
          </div>
        </div>

        {/* Season selector */}
        <div>
          <label className="text-sm font-semibold text-slate-300 block mb-3 pl-1">Current Season</label>
          <div className="grid grid-cols-1 gap-3">
            {[
              { id: "summer", label: "Summer", sub: "Mar-May", icon: <Sun className="w-5 h-5 text-orange-400" /> },
              { id: "monsoon", label: "Monsoon", sub: "Jun-Sep", icon: <CloudRain className="w-5 h-5 text-blue-400" /> },
              { id: "winter", label: "Winter", sub: "Oct-Feb", icon: <Snowflake className="w-5 h-5 text-cyan-300" /> },
            ].map((opt) => (
              <button
                key={opt.id}
                onClick={() => handleUpdate({ ...data, season: opt.id })}
                className={`w-full flex items-center p-4 rounded-2xl border-2 transition-all active:scale-[0.98] ${
                  data.season === opt.id 
                    ? "bg-blue-600/20 border-blue-500" 
                    : "bg-slate-800/40 border-slate-700/50 hover:bg-slate-800"
                }`}
              >
                <div className="flex-shrink-0 mr-4 p-2 bg-slate-900/50 rounded-full">{opt.icon}</div>
                <div className="flex-1 text-left">
                  <div className={`font-medium text-base ${data.season === opt.id ? "text-white" : "text-slate-300"}`}>{opt.label}</div>
                  <div className="text-xs text-slate-500">{opt.sub}</div>
                </div>
                <div className={`w-5 h-5 rounded-full border-2 flex items-center justify-center ${data.season === opt.id ? "border-blue-400" : "border-slate-500"}`}>
                  {data.season === opt.id && <div className="w-2.5 h-2.5 bg-blue-400 rounded-full" />}
                </div>
              </button>
            ))}
          </div>
        </div>

        {/* Location Type */}
        <div>
          <label className="text-sm font-semibold text-slate-300 block mb-3 pl-1">Location Type</label>
          <div className="grid grid-cols-2 gap-3">
            {[
              { id: "urban", label: "Urban", icon: <Building2 className="w-6 h-6 text-purple-400 mb-2" /> },
              { id: "rural", label: "Rural", icon: <MapPin className="w-6 h-6 text-green-400 mb-2" /> },
            ].map((opt) => (
              <button
                key={opt.id}
                onClick={() => handleUpdate({ ...data, location_type: opt.id })}
                className={`flex flex-col items-center justify-center p-5 rounded-2xl border-2 transition-all active:scale-[0.98] ${
                  data.location_type === opt.id 
                    ? "bg-blue-600/20 border-blue-500 text-white" 
                    : "bg-slate-800/40 border-slate-700/50 text-slate-400 hover:bg-slate-800"
                }`}
              >
                {opt.icon}
                <span className="font-semibold text-sm">{opt.label}</span>
              </button>
            ))}
          </div>
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
            className="flex-[2] flex items-center justify-center gap-2 py-4 rounded-2xl bg-blue-600 text-white font-bold active:scale-95 transition-all shadow-lg shadow-blue-600/30"
          >
            Select Appliances
            <ArrowRight className="w-5 h-5" />
          </button>
        </div>
      </div>

      <style jsx global>{`
        .hide-scrollbar::-webkit-scrollbar {
          display: none;
        }
        .safe-area-pb {
          padding-bottom: calc(1rem + env(safe-area-inset-bottom));
        }
      `}</style>
    </div>
  );
}
