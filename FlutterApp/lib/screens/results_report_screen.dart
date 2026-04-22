import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:fl_chart/fl_chart.dart';
import '../components/tariff_visualizer.dart';
import '../components/benchmark_card.dart';

class ResultsReportScreen extends StatelessWidget {
  const ResultsReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(color: const Color(0x3310B981), shape: BoxShape.circle, border: Border.all(color: const Color(0x4D10B981))),
              child: const Icon(LucideIcons.check, color: Color(0xFF34D399), size: 12),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Results Dashboard', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                Text('Analysis Complete', style: TextStyle(fontSize: 10, color: Color(0xFF34D399), fontWeight: FontWeight.w500)),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Hero Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFF0F172A),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFF1E293B)),
                boxShadow: const [BoxShadow(color: Color(0x1A3B82F6), blurRadius: 20, spreadRadius: 2)],
              ),
              child: Column(
                children: [
                  const Text('ESTIMATED BI-MONTHLY BILL', style: TextStyle(color: Color(0xFF94A3B8), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: const [
                      Text('₹', style: TextStyle(color: Color(0xFF64748B), fontSize: 24)),
                      Text('1,250', style: TextStyle(color: Colors.white, fontSize: 48, fontWeight: FontWeight.w900)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(color: const Color(0xFF1E293B), borderRadius: BorderRadius.circular(12)),
                    child: const Text('250 Units • KSEB Tiered', style: TextStyle(color: Color(0xFFE2E8F0), fontSize: 12, fontWeight: FontWeight.w600)),
                  )
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Tariff Visualizer (Slab Pricing)
            const TariffVisualizer(householdKwh: 250),
            
            const SizedBox(height: 8),

            // Peer Benchmark Card
            const BenchmarkCard(householdKwh: 250, numPeople: '4'),

            const SizedBox(height: 24),
            
            // Charts Container
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: const Color(0xFF0F172A), borderRadius: BorderRadius.circular(24), border: Border.all(color: const Color(0xFF1E293B))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(LucideIcons.pieChart, color: Color(0xFF60A5FA), size: 18),
                      SizedBox(width: 8),
                      Text('Energy Distribution', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 200,
                    child: PieChart(
                      PieChartData(
                        sectionsSpace: 2,
                        centerSpaceRadius: 40,
                        sections: [
                          PieChartSectionData(color: const Color(0xFF3B82F6), value: 40, title: '40%', radius: 50, titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
                          PieChartSectionData(color: const Color(0xFF10B981), value: 30, title: '30%', radius: 50, titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
                          PieChartSectionData(color: const Color(0xFFF59E0B), value: 15, title: '15%', radius: 50, titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
                          PieChartSectionData(color: const Color(0xFF8B5CF6), value: 15, title: '15%', radius: 50, titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(color: Color(0xF20F172A), border: Border(top: BorderSide(color: Color(0xFF1E293B)))),
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1E293B), foregroundColor: const Color(0xFFCBD5E1), padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), side: const BorderSide(color: Color(0xFF334155))),
                  child: const Text('Restart', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF059669), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), elevation: 4),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: const [Icon(LucideIcons.download, size: 20), SizedBox(width: 8), Text('Save PDF', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
