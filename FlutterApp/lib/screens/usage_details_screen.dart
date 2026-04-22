import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'results_report_screen.dart';

class UsageDetailsScreen extends StatefulWidget {
  final List<String> selectedAppliances;
  
  const UsageDetailsScreen({Key? key, required this.selectedAppliances}) : super(key: key);

  @override
  State<UsageDetailsScreen> createState() => _UsageDetailsScreenState();
}

class _UsageDetailsScreenState extends State<UsageDetailsScreen> {
  int _currentStep = 1;
  final int _totalSteps = 3;

  Widget _buildPatternCard({required String title, required String subtitle, required IconData icon, required String selectedPattern}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0x661E293B),
        border: Border.all(color: const Color(0x80334155)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0x333B82F6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: const Color(0xFF60A5FA), size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                    Text(subtitle, style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Mock Dropdown for Pattern Selection
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF0F172A),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF334155)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedPattern,
                isExpanded: true,
                dropdownColor: const Color(0xFF1E293B),
                icon: const Icon(LucideIcons.chevronDown, color: Color(0xFF94A3B8), size: 16),
                style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
                items: <String>['Heavy Usage (10+ hrs)', 'Medium Usage (4-8 hrs)', 'Light Usage (1-3 hrs)'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {},
              ),
            ),
          )
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
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(color: const Color(0x333B82F6), shape: BoxShape.circle, border: Border.all(color: const Color(0x4D3B82F6))),
              child: const Text('3', style: TextStyle(color: Color(0xFF60A5FA), fontSize: 12, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Usage Details', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                Text('Major Appliances', style: TextStyle(fontSize: 10, color: Color(0xFF60A5FA), fontWeight: FontWeight.w500)),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 120),
        child: Column(
          children: [
            // Progress Bar
            Container(
              margin: const EdgeInsets.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('Step $_currentStep of $_totalSteps', style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: _currentStep / _totalSteps,
                    backgroundColor: const Color(0xFF1E293B),
                    valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
                    minHeight: 6,
                    borderRadius: BorderRadius.circular(4),
                  )
                ],
              ),
            ),
            
            _buildPatternCard(
              title: 'Air Conditioner (AC)',
              subtitle: 'Select your typical usage pattern',
              icon: LucideIcons.airVent,
              selectedPattern: 'Medium Usage (4-8 hrs)',
            ),
            _buildPatternCard(
              title: 'Refrigerator',
              subtitle: 'Select your fridge size/age',
              icon: LucideIcons.refrigerator,
              selectedPattern: 'Medium Usage (4-8 hrs)', // Mapped for demo
            ),
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
                  onPressed: () {
                    if (_currentStep > 1) {
                      setState(() => _currentStep--);
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1E293B), foregroundColor: const Color(0xFFCBD5E1), padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), side: const BorderSide(color: Color(0xFF334155))),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: const [Icon(LucideIcons.arrowLeft, size: 20), SizedBox(width: 8), Text('Back', style: TextStyle(fontWeight: FontWeight.bold))]),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: () {
                    if (_currentStep < _totalSteps) {
                      setState(() => _currentStep++);
                    } else {
                      // Navigate to Results
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const ResultsReportScreen()));
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2563EB), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), elevation: 4),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text(_currentStep < _totalSteps ? 'Next Category' : 'Calculate', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)), const SizedBox(width: 8), Icon(_currentStep < _totalSteps ? LucideIcons.arrowRight : LucideIcons.calculator, size: 20)]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
