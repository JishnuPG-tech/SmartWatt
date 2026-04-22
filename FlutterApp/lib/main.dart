import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/household_info_screen.dart';
import 'screens/mode_selection_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Supabase here
  // await Supabase.initialize(url: 'YOUR_URL', anonKey: 'YOUR_ANON_KEY');

  runApp(const SmartWattApp());
}

class SmartWattApp extends StatelessWidget {
  const SmartWattApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartWatt',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF0A0E27), // Background color from NextJS
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF3B82F6), // blue-500
          secondary: Color(0xFF10B981), // emerald-500
          surface: Color(0xFF1E293B), // slate-800
          background: Color(0xFF0A0E27),
          onPrimary: Colors.white,
          onSurface: Color(0xFFE2E8F0), // slate-200
        ),
        textTheme: GoogleFonts.interTextTheme(
          ThemeData.dark().textTheme,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0A0E27),
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
      ),
      // Set the initial route to ModeSelectionScreen
      home: const ModeSelectionScreen(),
    );
  }
}
