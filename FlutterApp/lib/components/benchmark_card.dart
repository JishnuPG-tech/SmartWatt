import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'dart:math';

class BenchmarkCard extends StatelessWidget {
  final double householdKwh;
  final String numPeople;

  const BenchmarkCard({
    Key? key, 
    required this.householdKwh, 
    required this.numPeople
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int peopleCount = int.tryParse(numPeople) ?? 4;
    double baseline = max(200.0, (peopleCount * 90).toDouble());
    double efficiency = ((baseline - householdKwh) / baseline) * 100;
    bool isEfficient = householdKwh <= baseline;
    double barWidthPercentage = min(1.0, householdKwh / (baseline * 1.5));

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1E293B), Color(0xFF0F172A)],
        ),
        border: Border.all(color: const Color(0xFF334155)),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Color(0x1A1E3A8A), blurRadius: 20, spreadRadius: 2)],
      ),
      child: Column(
        children: [
          // Header Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: const BoxDecoration(
              color: Color(0x801E293B),
              border: Border(bottom: BorderSide(color: Color(0xFF334155))),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Icon(LucideIcons.users, color: Color(0xFF60A5FA), size: 20),
                    SizedBox(width: 8),
                    Text('COMMUNITY BENCHMARK', style: TextStyle(color: Color(0xFF94A3B8), fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                  ],
                ),
                const Text('Peer Comparison', style: TextStyle(color: Color(0xFF64748B), fontSize: 12)),
              ],
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('VS. AVERAGE KERALA HOME (${baseline.toInt()} KWH)', style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      isEfficient ? '${efficiency.round()}% Better' : '${efficiency.abs().round()}% Higher',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: isEfficient ? const Color(0xFF4ADE80) : const Color(0xFFFB923C),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text('than neighbors', style: TextStyle(color: Color(0xFF64748B), fontSize: 14, fontWeight: FontWeight.w500)),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isEfficient ? const Color(0x1A22C55E) : const Color(0x1AF97316),
                    border: Border.all(color: isEfficient ? const Color(0x3322C55E) : const Color(0x33F97316)),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(isEfficient ? LucideIcons.leaf : LucideIcons.alertTriangle, color: isEfficient ? const Color(0xFF86EFAC) : const Color(0xFFFDBA74), size: 14),
                      const SizedBox(width: 8),
                      Text(
                        isEfficient ? 'Excellent Efficiency Standards!' : 'High Consumption Detected - Check AC/Geyser',
                        style: TextStyle(color: isEfficient ? const Color(0xFF86EFAC) : const Color(0xFFFDBA74), fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),
                // Visual Bar
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: const Color(0x801A202C),
                    border: Border.all(color: const Color(0x80334155)),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 16,
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(color: const Color(0xFF1E293B), borderRadius: BorderRadius.circular(8)),
                            ),
                            FractionallySizedBox(
                              widthFactor: barWidthPercentage,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: isEfficient 
                                      ? [const Color(0xFF16A34A), const Color(0xFF4ADE80)]
                                      : [const Color(0xFFEA580C), const Color(0xFFEF4444)],
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            // Baseline Marker
                            Positioned(
                              left: MediaQuery.of(context).size.width * 0.6, // Approximate position for marker based on math
                              top: 0,
                              bottom: 0,
                              child: Container(width: 2, color: Colors.white70),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('0 kWh', style: TextStyle(color: Color(0xFF64748B), fontSize: 10, fontFamily: 'monospace')),
                          Text('Avg: ${baseline.toInt()}', style: const TextStyle(color: Color(0xFFCBD5E1), fontSize: 10, fontWeight: FontWeight.bold, fontFamily: 'monospace')),
                          const Text('Max', style: TextStyle(color: Color(0xFF64748B), fontSize: 10, fontFamily: 'monospace')),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
