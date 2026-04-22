import 'package:flutter/material.dart';

class TariffVisualizer extends StatelessWidget {
  final double householdKwh;

  const TariffVisualizer({Key? key, required this.householdKwh}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Telescope steps
    final steps = [50, 50, 50, 50, 50, 1000];
    final monthly = householdKwh / 2;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Your Tariff Slab Position (Telescopic Pricing)',
            style: TextStyle(color: Color(0xFF94A3B8), fontSize: 12),
          ),
          const SizedBox(height: 8),
          Container(
            height: 16,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF1E293B), // slate-800
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFF334155)), // slate-700
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Row(
                children: List.generate(steps.length, (idx) {
                  final prevLimit = idx * 50;
                  final limit = prevLimit + steps[idx];
                  
                  Color color = const Color(0xFF334155); // bg-slate-700 default
                  if (monthly > prevLimit) {
                    if (monthly >= limit && idx < 5) {
                      color = const Color(0xFF3B82F6); // bg-blue-500
                    } else {
                      color = const Color(0xFFFACC15); // bg-yellow-400 (current block)
                    }
                  }

                  return Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: color,
                        border: const Border(
                          right: BorderSide(color: Color(0xFF0F172A), width: 1), // border-slate-900
                        ),
                      ),
                      // Normally we'd add Tooltip here for group-hover, but native Tooltip works well
                      child: Tooltip(
                        message: 'Tier ${idx + 1}: ₹${3 + idx}/unit',
                        preferBelow: false,
                        child: Container(),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('0', style: TextStyle(color: Color(0xFF64748B), fontSize: 10, fontFamily: 'monospace')),
              Text('50', style: TextStyle(color: Color(0xFF64748B), fontSize: 10, fontFamily: 'monospace')),
              Text('100', style: TextStyle(color: Color(0xFF64748B), fontSize: 10, fontFamily: 'monospace')),
              Text('150', style: TextStyle(color: Color(0xFF64748B), fontSize: 10, fontFamily: 'monospace')),
              Text('200', style: TextStyle(color: Color(0xFF64748B), fontSize: 10, fontFamily: 'monospace')),
              Text('250+', style: TextStyle(color: Color(0xFF64748B), fontSize: 10, fontFamily: 'monospace')),
            ],
          ),
        ],
      ),
    );
  }
}
