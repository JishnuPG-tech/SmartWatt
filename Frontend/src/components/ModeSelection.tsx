import SystemActiveHeader from "./SystemActiveHeader";
import { Zap, Clock, ShieldCheck, ChevronRight } from "lucide-react";

interface Props {
  onSelect: (mode: "quick" | "detailed") => void;
}

export default function ModeSelection({ onSelect }: Props) {
  return (
    <div className="w-full flex flex-col min-h-screen bg-[#0a0e27] animate-in fade-in duration-500 pb-12">
      
      {/* Mobile App Header */}
      <div className="bg-[#0a0e27]/90 backdrop-blur-md px-4 py-4 flex items-center justify-between sticky top-0 z-50 border-b border-slate-800/50">
        <div className="flex items-center gap-3">
          <div className="w-10 h-10 rounded-full bg-blue-600/20 flex items-center justify-center border border-blue-500/30">
            <Zap className="w-5 h-5 text-blue-400" />
          </div>
          <div>
            <h1 className="text-xl font-bold text-white leading-tight">SmartWatt</h1>
            <p className="text-[10px] text-blue-400 font-medium tracking-wider uppercase">Energy Estimator</p>
          </div>
        </div>
        <div className="scale-75 origin-right">
          <SystemActiveHeader />
        </div>
      </div>

      <div className="px-5 pt-8 flex-1 max-w-lg mx-auto w-full flex flex-col">
        <h2 className="text-2xl font-black text-white mb-2 tracking-tight">Select Mode</h2>
        <p className="text-slate-400 text-sm mb-8 leading-relaxed">
          Choose how you want to estimate your home's power consumption.
        </p>

        <div className="space-y-4 flex-1">
          {/* Quick Estimate Card */}
          <button
            onClick={() => onSelect("quick")}
            className="w-full text-left bg-gradient-to-br from-slate-800/80 to-slate-900/80 border border-slate-700 hover:border-blue-500 rounded-3xl p-6 transition-all active:scale-[0.98] shadow-xl shadow-black/20 group backdrop-blur-sm"
          >
            <div className="flex justify-between items-start mb-5">
              <div className="w-14 h-14 rounded-2xl bg-blue-500/10 flex items-center justify-center border border-blue-500/20 group-active:bg-blue-500 group-active:border-blue-400 transition-colors shadow-inner">
                <Clock className="w-7 h-7 text-blue-400 group-active:text-white transition-colors" />
              </div>
              <div className="w-8 h-8 rounded-full bg-slate-800 flex items-center justify-center group-active:bg-blue-500/20 transition-colors border border-slate-700">
                <ChevronRight className="w-4 h-4 text-slate-400 group-active:text-blue-400 transition-colors" />
              </div>
            </div>
            <h3 className="text-xl font-bold text-white mb-2">Quick Estimate</h3>
            <p className="text-sm text-slate-400 mb-5 leading-relaxed pr-4">Fast setup with basic inputs for instant predictive results.</p>
            
            <div className="flex items-center gap-3 text-xs font-semibold">
              <div className="flex items-center gap-1.5 text-blue-300 bg-blue-900/40 border border-blue-800/50 px-3 py-1.5 rounded-xl">
                <Clock className="w-3.5 h-3.5" /> 1-2 min
              </div>
              <div className="flex items-center gap-1.5 text-emerald-400 bg-emerald-900/40 border border-emerald-800/50 px-3 py-1.5 rounded-xl">
                <ShieldCheck className="w-3.5 h-3.5" /> 85% Acc
              </div>
            </div>
          </button>

          {/* Detailed Estimate Card */}
          <button
            onClick={() => onSelect("detailed")}
            className="w-full text-left bg-gradient-to-br from-slate-800/80 to-slate-900/80 border border-slate-700 hover:border-purple-500 rounded-3xl p-6 transition-all active:scale-[0.98] shadow-xl shadow-black/20 group backdrop-blur-sm"
          >
            <div className="flex justify-between items-start mb-5">
              <div className="w-14 h-14 rounded-2xl bg-purple-500/10 flex items-center justify-center border border-purple-500/20 group-active:bg-purple-500 group-active:border-purple-400 transition-colors shadow-inner">
                <ShieldCheck className="w-7 h-7 text-purple-400 group-active:text-white transition-colors" />
              </div>
              <div className="w-8 h-8 rounded-full bg-slate-800 flex items-center justify-center group-active:bg-purple-500/20 transition-colors border border-slate-700">
                <ChevronRight className="w-4 h-4 text-slate-400 group-active:text-purple-400 transition-colors" />
              </div>
            </div>
            <h3 className="text-xl font-bold text-white mb-2">Detailed Estimate</h3>
            <p className="text-sm text-slate-400 mb-5 leading-relaxed pr-4">Granular usage tracking for precise, appliance-specific insights.</p>
            
            <div className="flex items-center gap-3 text-xs font-semibold">
              <div className="flex items-center gap-1.5 text-purple-300 bg-purple-900/40 border border-purple-800/50 px-3 py-1.5 rounded-xl">
                <Clock className="w-3.5 h-3.5" /> 3-5 min
              </div>
              <div className="flex items-center gap-1.5 text-emerald-400 bg-emerald-900/40 border border-emerald-800/50 px-3 py-1.5 rounded-xl">
                <ShieldCheck className="w-3.5 h-3.5" /> 95% Acc
              </div>
            </div>
          </button>
        </div>

        <div className="mt-8 text-center text-[11px] font-medium tracking-wide uppercase text-slate-500 bg-slate-800/30 py-4 rounded-2xl border border-slate-700/50">
          Not sure? Start with Quick Estimate.
        </div>
      </div>
    </div>
  );
}
