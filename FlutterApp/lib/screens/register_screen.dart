import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  String? _error;

  Future<void> _handleSignup() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    if (_passwordController.text != _confirmPasswordController.text) {
      setState(() {
        _error = "Passwords do not match";
        _isLoading = false;
      });
      return;
    }

    if (_passwordController.text.length < 6) {
      setState(() {
        _error = "Password must be at least 6 characters";
        _isLoading = false;
      });
      return;
    }

    try {
      // Uncomment when Supabase is initialized in main.dart
      /*
      final response = await Supabase.instance.client.auth.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      
      if (!mounted) return;
      // Navigate to Login with success flag equivalent
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen(message: "Registration successful! Please login.")));
      return;
      */
      
      // Mock Register for demonstration purposes until backend is configured
      await Future.delayed(const Duration(seconds: 2));
      if (!mounted) return;
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
      
    } on AuthException catch (e) {
      setState(() => _error = e.message);
    } catch (e) {
      setState(() => _error = "Network error or Authentication not configured.");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E1117), // bg-[#0e1117]
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Container(
            width: double.infinity,
            constraints: const BoxConstraints(maxWidth: 400),
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: const Color(0xFF1A202C), // bg-[#1a202c]
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: const Color(0xFF334155)), // border-slate-700
              boxShadow: const [BoxShadow(color: Color(0x331E3A8A), blurRadius: 40, spreadRadius: 0)], // shadow-blue-900/20
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                const Text(
                  'SMARTWATT',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF60A5FA), // gradient fallback
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Create your account',
                  style: TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
                ),
                const SizedBox(height: 32),

                // Error Message
                if (_error != null)
                  Container(
                    margin: const EdgeInsets.only(bottom: 24),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0x1AEF4444),
                      border: Border.all(color: const Color(0x80EF4444)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(_error!, style: const TextStyle(color: Color(0xFFF87171), fontSize: 12), textAlign: TextAlign.center),
                  ),

                // Form Fields
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Email Address', style: TextStyle(color: Color(0xFFE2E8F0), fontSize: 14, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(color: Color(0xFFE2E8F0)),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFF0E1117),
                        hintText: 'you@example.com',
                        hintStyle: const TextStyle(color: Color(0xFF475569)),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF475569))),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF475569))),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF3B82F6))),
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    const Text('Password', style: TextStyle(color: Color(0xFFE2E8F0), fontSize: 14, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      style: const TextStyle(color: Color(0xFFE2E8F0)),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFF0E1117),
                        hintText: '••••••••',
                        hintStyle: const TextStyle(color: Color(0xFF475569)),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF475569))),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF475569))),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF3B82F6))),
                      ),
                    ),
                    const SizedBox(height: 24),

                    const Text('Confirm Password', style: TextStyle(color: Color(0xFFE2E8F0), fontSize: 14, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      style: const TextStyle(color: Color(0xFFE2E8F0)),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFF0E1117),
                        hintText: '••••••••',
                        hintStyle: const TextStyle(color: Color(0xFF475569)),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF475569))),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF475569))),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF3B82F6))),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleSignup,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2563EB),
                      disabledBackgroundColor: const Color(0x802563EB),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 8,
                    ),
                    child: _isLoading 
                      ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                      : const Text('Register', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),

                const SizedBox(height: 24),
                
                // Footer
                const Text("Already have an account?", style: TextStyle(color: Color(0xFF94A3B8), fontSize: 14)),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
                  },
                  child: const Text('Back to Login', style: TextStyle(color: Color(0xFF60A5FA), fontSize: 14, fontWeight: FontWeight.w600)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
