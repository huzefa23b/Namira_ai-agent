import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

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
      title: 'Namira AI',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const ChatScreen(),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({required this.text, required this.isUser, required this.timestamp});
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _msgController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    // Initial greeting from Namira
    _messages.add(
      ChatMessage(
        text: "Hello Huzefa! Main Namira hoon, aapki personal AI assistant. Aaj main aapki kya madad kar sakti hoon?",
        isUser: false,
        timestamp: DateTime.now(),
      ),
    );
  }

  void _sendMessage() async {
    final text = _msgController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(text: text, isUser: true, timestamp: DateTime.now()));
      _msgController.clear();
      _isTyping = true;
    });

    _scrollToBottom();

    // Simulate intelligent AI response
    await Future.delayed(const Duration(milliseconds: 900));

    String aiReply = _generateAIResponse(text);

    setState(() {
      _isTyping = false;
      _messages.add(ChatMessage(text: aiReply, isUser: false, timestamp: DateTime.now()));
    });

    _scrollToBottom();
  }

  String _generateAIResponse(String query) {
    final q = query.toLowerCase();
    
    if (q.contains('hello') || q.contains('hi') || q.contains('hey')) {
      return "Hello Huzefa! Sab kuch badhiya chal raha hai. Boliye, kaun sa project ya task execute karna hai?";
    } else if (q.contains('code') || q.contains('flutter') || q.contains('app') || q.contains('git')) {
      return "Codebase bilkul clean aur optimized hai. Aapke GitHub par repository (`huzefa23b/Namira_ai-agent`) successfully synced hai. Aur bataiye, kya features add karne hain?";
    } else if (q.contains('time') || q.contains('date')) {
      return "Abhi current time 03 November 2026, raat ke 8 bajne wale hain. Sab systems perfectly online hain!";
    } else if (q.contains('who are you') || q.contains('naam kya hai') || q.contains('namira')) {
      return "Main Namira hoon — aapki personal AI agent, jo aapke Windows PC aur mobile devices ko control aur automate karti hai!";
    } else if (q.contains('kya haal hai') || q.contains('kaise ho')) {
      return "Main ekdum fit aur ready hoon! Aap bataiye Huzefa, aapka din kaisa ja raha hai?";
    } else {
      List<String> intelligentReplies = [
        "Yeh ek behtareen idea hai Huzefa! Isko hum jaldi se implement kar dete hain.",
        "Aapki baat bilkul samajh aa gayi. Main is par kaam shuru kar rahi hoon.",
        "Sabhi parameters check kar liye hain. Isko smoothly execute karte hain!",
        "Perfect! Aur koi specific requirement hai iske alawa?",
      ];
      return intelligentReplies[Random().nextInt(intelligentReplies.length)];
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.cardColor,
        elevation: 0,
        title: Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: const BoxDecoration(
                color: Colors.greenAccent,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'Namira AI',
              style: TextStyle(color: AppTheme.softWhite, fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: AppTheme.greyText),
            onPressed: () {
              setState(() {
                _messages.clear();
                _messages.add(
                  ChatMessage(
                    text: "Chat reset ho gayi hai. Phir se shuru karte hain Huzefa!",
                    isUser: false,
                    timestamp: DateTime.now(),
                  ),
                );
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return Align(
                  alignment: msg.isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
                    decoration: BoxDecoration(
                      color: msg.isUser ? AppTheme.primaryPink : AppTheme.cardColor,
                      borderRadius: BorderRadius.circular(18).copyWith(
                        bottomRight: msg.isUser ? const Radius.circular(4) : const Radius.circular(18),
                        bottomLeft: !msg.isUser ? const Radius.circular(4) : const Radius.circular(18),
                      ),
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
          if (_isTyping)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              alignment: Alignment.centerLeft,
              child: const Text(
                "Namira is typing...",
                style: TextStyle(color: AppTheme.greyText, fontStyle: FontStyle.italic),
              ),
            ),
          Container(
            padding: const EdgeInsets.all(12),
            color: AppTheme.cardColor,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _msgController,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => _sendMessage(),
                    decoration: const InputDecoration(
                      hintText: 'Ask Namira anything...',
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: _sendMessage,
                  icon: const Icon(Icons.send_rounded, color: AppTheme.primaryPink, size: 28),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
