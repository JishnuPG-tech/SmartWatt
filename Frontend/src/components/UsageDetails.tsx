import { useState } from "react";
import { saveTraining } from "@/lib/api";
import { normalizePattern } from "@/lib/normalizePattern";
import { APPLIANCE_CATEGORIES } from "@/config/appliances";
import { USAGE_FORMS } from "@/config/usageForms";
import { ApplianceDetailCard } from "./usage/ApplianceDetailCard";
import { EventApplianceCard } from "./usage/EventApplianceCard";
import { RoomBasedCard } from "./usage/RoomBasedCard";
import { PumpDetailCard } from "./usage/PumpDetailCard";
import { getUsageAlert } from "@/lib/usageAlerts";
import { Check, ArrowLeft, ArrowRight, Calculator, Settings2 } from "lucide-react";

interface Props {
  selected: string[];
  details: any;
  onUpdate: (details: any) => void;
  onNext: () => void;
  onBack: () => void;
  mode: "quick" | "detailed";
  trainingId: string;
  subStep: number;
  setSubStep: (step: number) => void;
}

export default function UsageDetails({
  selected,
  details,
  onUpdate,
  onNext,
  onBack,
  mode,
  trainingId,
  subStep,
  setSubStep,
}: Props) {
  // Helper to categorize appliances based on config
  const getCategories = () => {
    const cats: any = { major: [], kitchen: [], lighting: [], other: [] };

    const allItems = APPLIANCE_CATEGORIES.flatMap((c) => c.items);

    selected.forEach((id) => {
      if (["air_conditioner", "refrigerator", "washing_machine", "geyser"].includes(id))
        cats.major.push(id);
      else if (["mixer", "microwave", "kettle", "induction", "rice_cooker", "toaster", "food_processor"].includes(id))
        cats.kitchen.push(id);
      else if (["fans", "led_lights", "cfl_lights", "tube_lights"].includes(id))
        cats.lighting.push(id);
      else cats.other.push(id);
    });
    return cats;
  };

  const categories = getCategories();

  // Determine active pages
  const pages = [
    ...(categories.major.length ? [{ id: "major", title: "Major Appliances", subtitle: "High-impact appliances - typically 60-80% of your bill", items: categories.major }] : []),
    ...(categories.kitchen.length ? [{ id: "kitchen", title: "Kitchen Appliances", subtitle: "Cooking and preparation", items: categories.kitchen }] : []),
    ...(categories.lighting.length ? [{ id: "lighting", title: "Lighting & Fans", subtitle: "Lighting and ventilation systems", items: categories.lighting }] : []),
    ...(categories.other.length ? [{ id: "other", title: "Other Appliances", subtitle: "Electronics and other devices", items: categories.other }] : []),
  ];

  const totalPages = pages.length;

  if (totalPages === 0) {
    return (
      <div className="w-full flex flex-col min-h-screen bg-[#0a0e27] animate-in fade-in duration-500 pb-[120px] items-center justify-center p-6 text-center">
        <h1 className="text-3xl font-black text-white mb-2">SmartWatt</h1>
        <div className="bg-slate-800/50 border border-slate-700 rounded-3xl p-6 mb-8 w-full max-w-sm">
          <p className="text-slate-300">No appliances selected for detailed analysis.</p>
        </div>
        <button onClick={onNext} className="w-full max-w-sm flex items-center justify-center gap-2 py-4 rounded-2xl bg-blue-600 text-white font-bold active:scale-95 transition-all shadow-lg shadow-blue-600/30">
          Calculate Results <ArrowRight className="w-5 h-5" />
        </button>
      </div>
    );
  }

  const currentPage = pages[subStep - 1];
  const progress = (subStep / (totalPages + 1)) * 100;

  const handleUpdate = (newDetails: Record<string, any>) => {
    onUpdate(newDetails);
    saveTraining(trainingId, { appliance_usage: newDetails });
  };

  const updateDetails = (updates: Record<string, any>) => {
    handleUpdate({ ...details, ...updates });
  };

  const updateDetail = (key: string, value: any) => {
    handleUpdate({ ...details, [key]: value });
  };

  const handlePatternChange = (keyPrefix: string, val: string, patterns: Array<{ value: string; label: string }>) => {
    const selectedPattern = patterns.find((p) => p.value === val);
    const label = selectedPattern ? selectedPattern.label : "";
    const normalized = normalizePattern(label);

    updateDetails({
      [`${keyPrefix}_pattern`]: val,
      [`${keyPrefix}_hours`]: normalized.avg_hours,
      [`${keyPrefix}_min_hours`]: normalized.min_hours,
      [`${keyPrefix}_max_hours`]: normalized.max_hours,
      [`${keyPrefix}_avg_hours`]: normalized.avg_hours,
      [`${keyPrefix}_category`]: normalized.category,
    });
  };

  const renderAppliance = (id: string) => {
    const allItems = APPLIANCE_CATEGORIES.flatMap((c) => c.items);
    const displayInfo = allItems.find((item) => item.id === id);
    const formConfig = USAGE_FORMS[id];

    if (!displayInfo || !formConfig) return null;

    const dataKey = formConfig.id;

    if (formConfig.pumpBased) {
      return (
        <PumpDetailCard key={id} id={dataKey} icon={<displayInfo.icon className={`w-5 h-5 ${displayInfo.color || "text-blue-400"}`} />} title={displayInfo.label} values={details} onFieldChange={updateDetail} onBatchChange={(updates) => handleUpdate({ ...details, ...updates })} alert={getUsageAlert(dataKey, details[`${dataKey}_hours`])} />
      );
    }

    if (formConfig.roomBased) {
      let count = 1;
      if ("quantityConfig" in displayInfo && displayInfo.quantityConfig) {
        const quantityConfig = displayInfo.quantityConfig as { key: string; defaultValue?: number };
        count = parseInt((details as Record<string, any>)[quantityConfig.key] || quantityConfig.defaultValue?.toString() || "1");
      } else if (formConfig.fields) {
        const countField = formConfig.fields.find((f) => f.key.includes("num_"));
        if (countField) count = parseInt(details[countField.key] || "1");
      }

      return (
        <RoomBasedCard key={id} id={dataKey} icon={<displayInfo.icon className={`w-5 h-5 ${displayInfo.color || "text-blue-400"}`} />} title={displayInfo.label} values={details} onFieldChange={updateDetail} onBatchChange={(updates) => handleUpdate({ ...details, ...updates })} alert={getUsageAlert(dataKey, details[`${dataKey}_hours`])} count={count} presets={formConfig.roomBased.presets} quantityConfig={"quantityConfig" in displayInfo ? (displayInfo.quantityConfig as any) : undefined} fields={formConfig.fields} />
      );
    }

    if (formConfig.eventBased) {
      const durationOptions = formConfig.eventBased.q2.options.map((opt) => ({ val: opt.value, label: opt.label, minutes: opt.hours * 60 }));
      return (
        <EventApplianceCard key={id} id={dataKey} icon={<displayInfo.icon className={`w-5 h-5 ${displayInfo.color || "text-blue-400"}`} />} title={displayInfo.label} values={details} onFieldChange={updateDetail} onBatchChange={(updates) => handleUpdate({ ...details, ...updates })} alert={getUsageAlert(dataKey, details[`${dataKey}_hours`])} durationOptions={durationOptions} q1Label={formConfig.eventBased.q1.question} q2Label={formConfig.eventBased.q2.question} />
      );
    }

    const isWashingMachine = dataKey === "wm";
    return (
      <ApplianceDetailCard key={id} icon={<displayInfo.icon className={`w-5 h-5 ${displayInfo.color || "text-blue-400"}`} />} title={displayInfo.label} fields={formConfig.fields} usagePatterns={formConfig.patterns || []} selectedPattern={details[`${dataKey}_pattern`] || formConfig.defaultPattern || ""} onPatternChange={(val) => handlePatternChange(dataKey, val, formConfig.patterns || [])} onFieldChange={updateDetail} values={details} alert={getUsageAlert(dataKey, details[`${dataKey}_hours`])} exactHoursKey={`${dataKey}_hours`} onExactHoursChange={(val) => updateDetail(`${dataKey}_hours`, val)} exactHoursValue={details[`${dataKey}_hours`]} hideHoursInput={isWashingMachine} />
    );
  };

  return (
    <div className="w-full flex flex-col min-h-screen bg-[#0a0e27] animate-in fade-in duration-500 pb-[120px]">
      
      {/* Sticky Mobile App Header */}
      <div className="sticky top-0 z-40 bg-[#0a0e27]/90 backdrop-blur-md border-b border-slate-800 px-4 py-4 flex items-center justify-between">
        <div className="flex items-center gap-3">
          <div className="w-8 h-8 rounded-full bg-blue-600/20 flex items-center justify-center">
            <span className="text-blue-400 font-bold text-xs">{subStep + 2}</span>
          </div>
          <div className="flex-1 min-w-0">
            <h1 className="text-lg font-bold text-white leading-tight">Usage Details</h1>
            <p className="text-xs text-blue-400 font-medium tracking-wide truncate w-32 sm:w-48">{currentPage?.title}</p>
          </div>
        </div>
        
        {/* Progress Bar Mini */}
        <div className="flex flex-col items-end shrink-0 ml-2">
          <span className="text-[10px] font-bold text-slate-400 uppercase mb-1">{Math.round(progress)}% Done</span>
          <div className="w-16 h-1.5 bg-slate-800 rounded-full overflow-hidden">
            <div className="h-full bg-blue-500 rounded-full transition-all duration-500" style={{ width: `${progress}%` }}></div>
          </div>
        </div>
      </div>

      <div className="px-4 pt-6 flex-1 max-w-lg mx-auto w-full">
        {/* Page Header */}
        <div className="mb-6 flex items-start gap-3 bg-slate-800/40 border border-slate-700/50 p-4 rounded-3xl shadow-sm">
          <div className="p-2 bg-blue-500/10 rounded-xl border border-blue-500/20 mt-0.5">
            <Settings2 className="w-5 h-5 text-blue-400" />
          </div>
          <div>
            <h2 className="text-sm font-bold text-white mb-1 uppercase tracking-wider">{currentPage?.title}</h2>
            <p className="text-[11px] text-slate-400 leading-relaxed pr-2">{currentPage?.subtitle}</p>
          </div>
        </div>

        {/* Appliance List Container */}
        <div className="space-y-4">
          {currentPage?.items.map(renderAppliance)}
        </div>
      </div>

      {/* Sticky Bottom Navigation Bar */}
      <div className="fixed bottom-0 left-0 right-0 p-4 bg-slate-900/95 backdrop-blur-xl border-t border-slate-800 z-50 shadow-2xl safe-area-pb">
        <div className="max-w-lg mx-auto flex gap-3">
          <button
            onClick={() => {
              if (subStep > 1) setSubStep(subStep - 1);
              else onBack();
            }}
            className="flex-1 flex items-center justify-center gap-2 py-4 rounded-2xl bg-slate-800 text-slate-300 font-semibold active:scale-95 transition-all border border-slate-700"
          >
            <ArrowLeft className="w-5 h-5" />
            Back
          </button>
          <button
            onClick={() => {
              if (subStep < totalPages) setSubStep(subStep + 1);
              else onNext();
            }}
            className="flex-[2] flex items-center justify-center gap-2 py-4 rounded-2xl bg-blue-600 text-white font-bold active:scale-95 transition-all shadow-lg shadow-blue-600/30"
          >
            {subStep < totalPages ? "Next Category" : "Calculate"}
            {subStep < totalPages ? <ArrowRight className="w-5 h-5" /> : <Calculator className="w-5 h-5" />}
          </button>
        </div>
      </div>
    </div>
  );
}
