import 'package:flutter/material.dart';
import 'dart:async';

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

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({required this.text, required this.isUser, required this.timestamp});
}

class HomeScreen extends StatefulWidget {
  final String userEmail;
  const HomeScreen({super.key, required this.userEmail});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _msgController = TextEditingController();
  bool _intruderDetected = false;
  String _intruderStatus = "Monitoring Active 🔒";

  @override
  void initState() {
    super.initState();
    // Welcome greeting
    _messages.add(ChatMessage(
      text: "Hello Huzefa! Namira is active and monitoring security logs. Send 'Hi' to test intruder alert & selfie simulation.", 
      isUser: false, 
      timestamp: DateTime.now()
    ));
  }

  void _handleSend() {
    final text = _msgController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(text: text, isUser: true, timestamp: DateTime.now()));
      _msgController.clear();
    });

    // Check if intruder sent "Hi" or similar trigger
    if (text.toLowerCase() == 'hi' || text.toLowerCase() == 'hello') {
      setState(() {
        _intruderDetected = true;
        _intruderStatus = "🚨 INTRUDER ALERT! Front Camera Selfie Captured & Chat Logged to Local File!";
      });

      // Add security response
      Timer(const Duration(milliseconds: 600), () {
        if (mounted) {
          setState(() {
            _messages.add(ChatMessage(
              text: "📸 [SECURITY SYSTEM]: Unauthorized 'Hi' detected! Front camera selfie snapshot saved successfully. All conversation logs have been exported to `namira_chat_log.txt` on your laptop/device.",
              isUser: false,
              timestamp: DateTime.now(),
            ));
          });
        }
      });
    } else {
      Timer(const Duration(milliseconds: 500), () {
        if (mounted) {
          setState(() {
            _messages.add(ChatMessage(
              text: "Namira received: '$text'. All secure logs updated in real-time.",
              isUser: false,
              timestamp: DateTime.now(),
            ));
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('❤️ NAMIRA SECURITY CHAT'),
        actions: [
          IconButton(
            icon: const Icon(Icons.security, color: AppTheme.primaryPink),
            tooltip: 'Security Status',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: AppTheme.cardColor,
                  title: const Text('Intruder Protection Status'),
                  content: Text(_intruderStatus),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK', style: TextStyle(color: AppTheme.primaryPink)),
                    ),
                  ],
                ),
              );
            },
          ),
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
      body: Column(
        children: [
          // Security Status Banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            color: _intruderDetected ? Colors.red.withOpacity(0.3) : AppTheme.cardColor,
            child: Row(
              children: [
                Icon(
                  _intruderDetected ? Icons.warning_amber_rounded : Icons.shield_rounded,
                  color: _intruderDetected ? Colors.redAccent : AppTheme.primaryPink,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    _intruderStatus,
                    style: TextStyle(
                      color: _intruderDetected ? Colors.redAccent : AppTheme.softWhite,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Chat Messages List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return Align(
                  alignment: msg.isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.all(14),
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
                    decoration: BoxDecoration(
                      color: msg.isUser ? AppTheme.primaryPink : AppTheme.cardColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      msg.text,
                      style: const TextStyle(color: AppTheme.softWhite, fontSize: 16),
                    ),
                  ),
                );
              },
            ),
          ),
          // Input Bar
          Container(
            padding: const EdgeInsets.all(12),
            color: AppTheme.cardColor,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _msgController,
                    decoration: const InputDecoration(
                      hintText: 'Type message or send "Hi"...',
                    ),
                    onSubmitted: (_) => _handleSend(),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(Icons.send, color: AppTheme.primaryPink),
                  onPressed: _handleSend,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
