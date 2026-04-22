import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../config/usage_forms.dart';
import 'results_report_screen.dart';

class UsageDetailsScreen extends StatefulWidget {
  final List<String> selectedAppliances;
  
  const UsageDetailsScreen({
    Key? key, 
    // Fallback default for testing if not passed
    this.selectedAppliances = const ['refrigerator', 'air_conditioner', 'mixer', 'fans'],
  }) : super(key: key);

  @override
  State<UsageDetailsScreen> createState() => _UsageDetailsScreenState();
}

class _UsageDetailsScreenState extends State<UsageDetailsScreen> {
  int _currentStep = 1;
  late int _totalSteps;
  
  // Store form state (applianceId -> key -> value)
  final Map<String, Map<String, dynamic>> _formState = {};

  @override
  void initState() {
    super.initState();
    _totalSteps = widget.selectedAppliances.length;
    
    // Initialize default values based on config
    for (String applianceId in widget.selectedAppliances) {
      _formState[applianceId] = {};
      final config = UsageForms.config[applianceId];
      if (config != null) {
        if (config.containsKey('defaultPattern')) {
          _formState[applianceId]!['pattern'] = config['defaultPattern'];
        }
        if (config.containsKey('fields')) {
          for (var field in config['fields']) {
            _formState[applianceId]![field['key']] = field['options'][0]['value'];
          }
        }
        if (config.containsKey('eventBased')) {
          _formState[applianceId]!['q1'] = config['eventBased']['q1']['options'][0]['value'];
          _formState[applianceId]!['q2'] = config['eventBased']['q2']['options'][0]['value'];
        }
        if (config.containsKey('roomBased')) {
          _formState[applianceId]!['hours'] = config['roomBased']['defaultHours'].toString();
        }
      }
    }
  }

  Widget _buildDropdown(String applianceId, String key, String label, List<dynamic> options) {
    String currentValue = _formState[applianceId]?[key] ?? options[0]['value'];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 12, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFF0F172A),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF334155)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: currentValue,
              isExpanded: true,
              dropdownColor: const Color(0xFF1E293B),
              icon: const Icon(LucideIcons.chevronDown, color: Color(0xFF94A3B8), size: 16),
              style: const TextStyle(color: Colors.white, fontSize: 14),
              items: options.map<DropdownMenuItem<String>>((dynamic option) {
                return DropdownMenuItem<String>(
                  value: option['value'].toString(),
                  child: Text(option['label'].toString()),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _formState[applianceId]![key] = newValue;
                  });
                }
              },
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildDynamicForm(String applianceId) {
    final config = UsageForms.config[applianceId];
    if (config == null) return const Text('Configuration not found', style: TextStyle(color: Colors.red));

    List<Widget> formElements = [];

    // Pattern Based
    if (config.containsKey('patterns')) {
      formElements.add(_buildDropdown(applianceId, 'pattern', 'Usage Pattern', config['patterns']));
    }

    // Fields Based
    if (config.containsKey('fields')) {
      for (var field in config['fields']) {
        formElements.add(_buildDropdown(applianceId, field['key'], field['label'], field['options']));
      }
    }

    // Event Based
    if (config.containsKey('eventBased')) {
      var q1 = config['eventBased']['q1'];
      var q2 = config['eventBased']['q2'];
      formElements.add(_buildDropdown(applianceId, 'q1', q1['question'], q1['options']));
      formElements.add(_buildDropdown(applianceId, 'q2', q2['question'], q2['options']));
    }
    
    // Room Based
    if (config.containsKey('roomBased')) {
       // Convert presets to dropdown format for simplicity
       List<dynamic> mappedOptions = (config['roomBased']['presets'] as List).map((p) => {
         'value': p['val'].toString(),
         'label': p['label'].toString(),
       }).toList();
       formElements.add(_buildDropdown(applianceId, 'hours', 'Daily Usage', mappedOptions));
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: formElements);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.selectedAppliances.isEmpty) {
      return const Scaffold(body: Center(child: Text("No appliances selected.", style: TextStyle(color: Colors.white))));
    }

    String currentApplianceId = widget.selectedAppliances[_currentStep - 1];

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
              children: [
                const Text('Usage Details', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                Text('Configuring ${currentApplianceId.toUpperCase()}', style: const TextStyle(fontSize: 10, color: Color(0xFF60A5FA), fontWeight: FontWeight.w500)),
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
                  Text('Appliance $_currentStep of $_totalSteps', style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
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
            
            // Dynamic Appliance Card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0x661E293B),
                border: Border.all(color: const Color(0x80334155)),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(color: const Color(0x333B82F6), borderRadius: BorderRadius.circular(16)),
                        child: const Icon(LucideIcons.settings, color: Color(0xFF60A5FA), size: 28),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          currentApplianceId.replaceAll('_', ' ').toUpperCase(),
                          style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _buildDynamicForm(currentApplianceId),
                ],
              ),
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
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text(_currentStep < _totalSteps ? 'Next' : 'Calculate', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)), const SizedBox(width: 8), Icon(_currentStep < _totalSteps ? LucideIcons.arrowRight : LucideIcons.calculator, size: 20)]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
