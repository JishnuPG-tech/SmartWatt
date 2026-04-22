import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'appliance_selection_screen.dart';

class HouseholdInfoScreen extends StatefulWidget {
  const HouseholdInfoScreen({Key? key}) : super(key: key);

  @override
  State<HouseholdInfoScreen> createState() => _HouseholdInfoScreenState();
}

class _HouseholdInfoScreenState extends State<HouseholdInfoScreen> {
  // States mapped from Next.js implementation
  String _season = 'summer';
  String _locationType = 'urban';
  String _houseType = 'independent';
  double _kwh = 250;
  int _numPeople = 4;

  Widget _buildTapCard({
    required String title,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0x333B82F6) : const Color(0x801E293B),
          border: Border.all(
            color: isSelected ? const Color(0xFF3B82F6) : const Color(0x80334155),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: isSelected
              ? [const BoxShadow(color: Color(0x263B82F6), blurRadius: 12, spreadRadius: 2)]
              : [],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? const Color(0xFF60A5FA) : const Color(0xFF94A3B8),
              size: 28,
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF94A3B8),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
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
              decoration: BoxDecoration(
                color: const Color(0x333B82F6),
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0x4D3B82F6)),
              ),
              child: const Text('1', style: TextStyle(color: Color(0xFF60A5FA), fontSize: 12, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Household Info', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                Text('KSEB Bill & Location', style: TextStyle(fontSize: 10, color: Color(0xFF60A5FA), fontWeight: FontWeight.w500)),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bill Input
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0x661E293B),
                border: Border.all(color: const Color(0x80334155)),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('LATEST KSEB BILL', style: TextStyle(color: Color(0xFF94A3B8), fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: '250',
                            hintStyle: TextStyle(color: Color(0xFF475569)),
                          ),
                          style: const TextStyle(fontSize: 48, fontWeight: FontWeight.w900, color: Colors.white),
                          onChanged: (val) => setState(() => _kwh = double.tryParse(val) ?? 0),
                        ),
                      ),
                      const Text('Units', style: TextStyle(color: Color(0xFF60A5FA), fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Season Section
            const Text('SEASON', style: TextStyle(color: Color(0xFF94A3B8), fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _buildTapCard(title: 'Summer', icon: LucideIcons.sun, isSelected: _season == 'summer', onTap: () => setState(() => _season = 'summer'))),
                const SizedBox(width: 12),
                Expanded(child: _buildTapCard(title: 'Monsoon', icon: LucideIcons.cloudRain, isSelected: _season == 'monsoon', onTap: () => setState(() => _season = 'monsoon'))),
                const SizedBox(width: 12),
                Expanded(child: _buildTapCard(title: 'Winter', icon: LucideIcons.snowflake, isSelected: _season == 'winter', onTap: () => setState(() => _season = 'winter'))),
              ],
            ),
            const SizedBox(height: 24),

            // Location Section
            const Text('LOCATION', style: TextStyle(color: Color(0xFF94A3B8), fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _buildTapCard(title: 'Urban', icon: LucideIcons.building, isSelected: _locationType == 'urban', onTap: () => setState(() => _locationType = 'urban'))),
                const SizedBox(width: 12),
                Expanded(child: _buildTapCard(title: 'Rural', icon: LucideIcons.home, isSelected: _locationType == 'rural', onTap: () => setState(() => _locationType = 'rural'))),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Color(0xF20F172A),
          border: Border(top: BorderSide(color: Color(0xFF1E293B))),
        ),
        child: SafeArea(
          child: ElevatedButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ApplianceSelectionScreen())),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2563EB),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 4,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('Next Step', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(width: 8),
                Icon(LucideIcons.arrowRight, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
