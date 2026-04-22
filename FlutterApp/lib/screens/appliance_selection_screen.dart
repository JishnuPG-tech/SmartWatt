import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ApplianceSelectionScreen extends StatefulWidget {
  const ApplianceSelectionScreen({Key? key}) : super(key: key);

  @override
  State<ApplianceSelectionScreen> createState() => _ApplianceSelectionScreenState();
}

class _ApplianceSelectionScreenState extends State<ApplianceSelectionScreen> {
  final List<String> _selectedAppliances = [];
  final Map<String, dynamic> _details = {};

  final List<Map<String, dynamic>> _categories = [
    {
      'title': 'Major Appliances',
      'items': [
        {'id': 'air_conditioner', 'label': 'AC', 'icon': LucideIcons.airVent, 'color': const Color(0xFF22D3EE), 'hasQuantity': false},
        {'id': 'refrigerator', 'label': 'Fridge', 'icon': LucideIcons.refrigerator, 'color': const Color(0xFF60A5FA), 'hasQuantity': false},
        {'id': 'washing_machine', 'label': 'Washing M.', 'icon': LucideIcons.washingMachine, 'color': const Color(0xFF818CF8), 'hasQuantity': false},
        {'id': 'geyser', 'label': 'Geyser', 'icon': LucideIcons.showerHead, 'color': const Color(0xFFF87171), 'hasQuantity': false},
        {'id': 'microwave', 'label': 'Microwave', 'icon': LucideIcons.microwave, 'color': const Color(0xFFFB923C), 'hasQuantity': false},
        {'id': 'kettle', 'label': 'Kettle', 'icon': LucideIcons.coffee, 'color': const Color(0xFFD97706), 'hasQuantity': false},
        {'id': 'induction', 'label': 'Induction', 'icon': LucideIcons.zap, 'color': const Color(0xFFEF4444), 'hasQuantity': false},
      ]
    },
    {
      'title': 'Kitchen Appliances',
      'items': [
        {'id': 'mixer', 'label': 'Mixer', 'icon': LucideIcons.disc, 'color': const Color(0xFF94A3B8), 'hasQuantity': false},
        {'id': 'rice_cooker', 'label': 'Rice Cooker', 'icon': LucideIcons.cookingPot, 'color': Colors.white, 'hasQuantity': false},
        {'id': 'toaster', 'label': 'Toaster', 'icon': LucideIcons.sandwich, 'color': const Color(0xFFFDBA74), 'hasQuantity': false},
        {'id': 'food_processor', 'label': 'Food Proc.', 'icon': LucideIcons.utensils, 'color': const Color(0xFF9CA3AF), 'hasQuantity': false},
      ]
    },
    {
      'title': 'Lighting & Fans',
      'items': [
        {'id': 'fans', 'label': 'Ceiling Fan', 'icon': LucideIcons.fan, 'color': const Color(0xFF93C5FD), 'hasQuantity': true, 'key': 'num_fans'},
        {'id': 'led_lights', 'label': 'LED Bulb', 'icon': LucideIcons.lightbulb, 'color': const Color(0xFFFACC15), 'hasQuantity': true, 'key': 'num_led'},
        {'id': 'cfl_lights', 'label': 'CFL Bulb', 'icon': LucideIcons.lightbulb, 'color': Colors.white, 'hasQuantity': true, 'key': 'num_cfl'},
        {'id': 'tube_lights', 'label': 'Tube Light', 'icon': LucideIcons.lightbulb, 'color': const Color(0xFFE2E8F0), 'hasQuantity': true, 'key': 'num_tube'},
      ]
    },
    {
      'title': 'Other Appliances',
      'items': [
        {'id': 'tv', 'label': 'Television', 'icon': LucideIcons.tv, 'color': const Color(0xFF34D399), 'hasQuantity': false},
        {'id': 'desktop', 'label': 'Desktop PC', 'icon': LucideIcons.monitor, 'color': const Color(0xFF3B82F6), 'hasQuantity': false},
        {'id': 'laptop', 'label': 'Laptop', 'icon': LucideIcons.laptop, 'color': const Color(0xFF38BDF8), 'hasQuantity': false},
        {'id': 'pump', 'label': 'Water Pump', 'icon': LucideIcons.droplets, 'color': const Color(0xFF2563EB), 'hasQuantity': false},
        {'id': 'iron', 'label': 'Iron', 'icon': LucideIcons.shirt, 'color': const Color(0xFFEAB308), 'hasQuantity': false},
        {'id': 'hair_dryer', 'label': 'Hair Dryer', 'icon': LucideIcons.wind, 'color': const Color(0xFFF472B6), 'hasQuantity': false},
        {'id': 'vacuum', 'label': 'Vacuum', 'icon': LucideIcons.wind, 'color': const Color(0xFF2DD4BF), 'hasQuantity': false},
      ]
    }
  ];

  void _toggleAppliance(String id) {
    setState(() {
      if (_selectedAppliances.contains(id)) {
        _selectedAppliances.remove(id);
      } else {
        _selectedAppliances.add(id);
        // Set default quantity if needed
        for (var cat in _categories) {
          for (var item in cat['items']) {
            if (item['id'] == id && item['hasQuantity'] == true) {
              if (!_details.containsKey(item['key'])) {
                _details[item['key']] = 1;
              }
            }
          }
        }
      }
    });
  }

  Widget _buildApplianceCard(Map<String, dynamic> item) {
    bool isSelected = _selectedAppliances.contains(item['id']);
    
    return GestureDetector(
      onTap: () => _toggleAppliance(item['id']),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0x333B82F6) : const Color(0x801E293B),
          border: Border.all(
            color: isSelected ? const Color(0xFF3B82F6) : const Color(0x80334155),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: isSelected
              ? [const BoxShadow(color: Color(0x263B82F6), blurRadius: 15, spreadRadius: 2)]
              : [],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF3B82F6) : const Color(0xFF1E293B),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    item['icon'],
                    color: isSelected ? Colors.white : const Color(0xFF94A3B8),
                    size: 24,
                  ),
                ),
                if (isSelected)
                  Positioned(
                    top: -6,
                    right: -6,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981),
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFF0A0E27), width: 2),
                      ),
                      child: const Icon(LucideIcons.check, color: Colors.white, size: 12),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              item['label'],
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF94A3B8),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (isSelected && item['hasQuantity']) ...[
              const SizedBox(height: 12),
              Container(
                height: 1,
                color: const Color(0x80334155),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('QTY', style: TextStyle(color: Color(0xFF60A5FA), fontSize: 10, fontWeight: FontWeight.bold)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3B82F6),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text('${_details[item['key']]}', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w900)),
                  )
                ],
              ),
              // Simplified slider using standard flutter Slider with custom theme
              SliderTheme(
                data: SliderThemeData(
                  trackHeight: 4,
                  thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                  overlayShape: const RoundSliderOverlayShape(overlayRadius: 12),
                  activeTrackColor: const Color(0xFF60A5FA),
                  inactiveTrackColor: const Color(0xFF0F172A),
                  thumbColor: const Color(0xFF60A5FA),
                ),
                child: Slider(
                  value: (_details[item['key']] as int).toDouble(),
                  min: 1,
                  max: 20,
                  onChanged: (val) {
                    setState(() {
                      _details[item['key']] = val.toInt();
                    });
                  },
                ),
              ),
            ]
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
              decoration: BoxDecoration(color: const Color(0x333B82F6), shape: BoxShape.circle, border: Border.all(color: const Color(0x4D3B82F6))),
              child: const Text('2', style: TextStyle(color: Color(0xFF60A5FA), fontSize: 12, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Appliances', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                Text('Select what you use', style: TextStyle(fontSize: 10, color: Color(0xFF60A5FA), fontWeight: FontWeight.w500)),
              ],
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(color: const Color(0x801E293B), borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0x80334155))),
            child: Row(
              children: [
                Text('${_selectedAppliances.length}', style: TextStyle(color: _selectedAppliances.isNotEmpty ? const Color(0xFF60A5FA) : const Color(0xFF94A3B8), fontWeight: FontWeight.bold)),
                const Text(' Selected', style: TextStyle(color: Color(0xFF94A3B8), fontWeight: FontWeight.bold, fontSize: 10)),
              ],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 120),
        child: Column(
          children: _categories.map((cat) {
            return Container(
              margin: const EdgeInsets.only(bottom: 24),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: const Color(0x661E293B), borderRadius: BorderRadius.circular(24), border: Border.all(color: const Color(0x80334155))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(width: 6, height: 16, decoration: BoxDecoration(color: const Color(0xFF3B82F6), borderRadius: BorderRadius.circular(4))),
                      const SizedBox(width: 8),
                      Text(cat['title'], style: const TextStyle(color: Color(0xFFCBD5E1), fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.85, // Adjust based on slider presence
                    ),
                    itemCount: cat['items'].length,
                    itemBuilder: (context, index) {
                      return _buildApplianceCard(cat['items'][index]);
                    },
                  )
                ],
              ),
            );
          }).toList(),
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
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1E293B), foregroundColor: const Color(0xFFCBD5E1), padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), side: const BorderSide(color: Color(0xFF334155))),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: const [Icon(LucideIcons.arrowLeft, size: 20), SizedBox(width: 8), Text('Back', style: TextStyle(fontWeight: FontWeight.bold))]),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: _selectedAppliances.isEmpty ? null : () {},
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2563EB), disabledBackgroundColor: const Color(0xFF334155), disabledForegroundColor: const Color(0xFF64748B), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), elevation: 4),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: const [Text('Usage Details', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)), SizedBox(width: 8), Icon(LucideIcons.arrowRight, size: 20)]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
