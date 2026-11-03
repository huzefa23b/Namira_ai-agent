import 'package:flutter/material.dart';

void main() {
  runApp(const NamiraApp());
}

class AppTheme {
  static const Color primaryPink = Color(0xFFFF2E7E);
  static const Color darkBackground = Color(0xFF121212);
  static const Color cardColor = Color(0xFF1E1E1E);
  static const Color softWhite = Color(0xFFF8F9FA);
  static const Color greyText = Color(0xFF9E9E9E);

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: darkBackground,
    primaryColor: primaryPink,
    colorScheme: const ColorScheme.dark(
      primary: primaryPink,
      surface: cardColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: cardColor,
      hintStyle: const TextStyle(color: greyText),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: primaryPink, width: 2),
      ),
    ),
  );
}

class NamiraApp extends StatelessWidget {
  const NamiraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Namira',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const AuthScreen(),
    );
  }
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLogin = true;

  void _submit() {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email daalna zaroori hai!")),
      );
      return;
    }

    // Direct Chat Screen par bhej denge bina kisi error ke
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen(userEmail: email)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  _isLogin ? "Welcome Back ❤️" : "Create Account ✨",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 32, 
                    fontWeight: FontWeight.bold, 
                    color: AppTheme.softWhite
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _isLogin ? "Log in to continue to Namira" : "Sign up to start chatting",
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: AppTheme.greyText, fontSize: 16),
                ),
                const SizedBox(height: 40),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(hintText: 'Email Address'),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(hintText: 'Password'),
                  obscureText: true,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryPink,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    _isLogin ? 'Log In' : 'Sign Up', 
                    style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () => setState(() => _isLogin = !_isLogin),
                  child: Text(
                    _isLogin ? "Don't have an account? Sign Up" : "Already have an account? Log In",
                    style: const TextStyle(color: AppTheme.primaryPink),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final String userEmail;
  const HomeScreen({super.key, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('❤️ NAMIRA CHAT'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const AuthScreen()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Text(
          "Welcome, $userEmail! 🎉\nApp is working perfectly.",
          textAlign: TextAlign.center,
          style: const TextStyle(color: AppTheme.softWhite, fontSize: 20),
        ),
      ),
    );
  }
}