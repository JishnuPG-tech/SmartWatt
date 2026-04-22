import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'household_info_screen.dart';

class ModeSelectionScreen extends StatelessWidget {
  const ModeSelectionScreen({Key? key}) : super(key: key);

  Widget _buildModeCard({
    required BuildContext context,
    required String title,
    required String desc,
    required IconData icon,
    required Color color,
    required Color bgColor,
    required String time,
    required String accuracy,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xCC1E293B),
          border: Border.all(color: const Color(0x80334155)),
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 4))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(16), border: Border.all(color: color.withOpacity(0.2))),
                  child: Icon(icon, color: color, size: 28),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(color: Color(0xFF0F172A), shape: BoxShape.circle),
                  child: const Icon(LucideIcons.chevronRight, color: Color(0xFF94A3B8), size: 16),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 8),
            Text(desc, style: const TextStyle(fontSize: 14, color: Color(0xFF94A3B8), height: 1.5)),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildChip(icon: LucideIcons.clock, text: time, color: color, bgColor: color.withOpacity(0.1)),
                const SizedBox(width: 12),
                _buildChip(icon: LucideIcons.shieldCheck, text: accuracy, color: const Color(0xFF34D399), bgColor: const Color(0x33065F46)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildChip({required IconData icon, required String text, required Color color, required Color bgColor}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(12), border: Border.all(color: color.withOpacity(0.3))),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(text, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: const Color(0x333B82F6), shape: BoxShape.circle, border: Border.all(color: const Color(0x4D3B82F6))),
              child: const Icon(LucideIcons.zap, color: Color(0xFF60A5FA), size: 16),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('SmartWatt', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                Text('ENERGY ESTIMATOR', style: TextStyle(fontSize: 10, color: Color(0xFF60A5FA), fontWeight: FontWeight.w500, letterSpacing: 1.2)),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Text('Select Mode', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: -0.5)),
            const SizedBox(height: 8),
            const Text('Choose how you want to estimate your home\'s power consumption.', style: TextStyle(fontSize: 14, color: Color(0xFF94A3B8), height: 1.5)),
            const SizedBox(height: 32),
            _buildModeCard(
              context: context,
              title: 'Quick Estimate',
              desc: 'Fast setup with basic inputs for instant predictive results.',
              icon: LucideIcons.clock,
              color: const Color(0xFF60A5FA),
              bgColor: const Color(0x1A3B82F6),
              time: '1-2 min',
              accuracy: '85% Acc',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HouseholdInfoScreen())),
            ),
            _buildModeCard(
              context: context,
              title: 'Detailed Estimate',
              desc: 'Granular usage tracking for precise, appliance-specific insights.',
              icon: LucideIcons.shieldCheck,
              color: const Color(0xFFA78BFA),
              bgColor: const Color(0x1A8B5CF6),
              time: '3-5 min',
              accuracy: '95% Acc',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HouseholdInfoScreen())),
            ),
            const SizedBox(height: 24),
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(color: const Color(0x4D1E293B), borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0x80334155))),
                child: const Text('NOT SURE? START WITH QUICK ESTIMATE.', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF64748B), letterSpacing: 1.2)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
