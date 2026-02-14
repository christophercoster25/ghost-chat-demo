import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const EliteDemoApp());
}

class EliteDemoApp extends StatelessWidget {
  const EliteDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DemoController(),
    );
  }
}

class DemoController extends StatefulWidget {
  const DemoController({super.key});

  @override
  State<DemoController> createState() => _DemoControllerState();
}

class _DemoControllerState extends State<DemoController> {
  final PageController _pageController = PageController();
  int _index = 0;
  Timer? _autoTimer;

  final Duration slideDuration = const Duration(seconds: 7);

  @override
  void initState() {
    super.initState();
    startAutoPlay();
  }

  void startAutoPlay() {
    _autoTimer = Timer.periodic(slideDuration, (_) {
      if (_index < 5) {
        _index++;
        _pageController.animateToPage(
          _index,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void next() {
    if (_index < 5) {
      _index++;
      _pageController.animateToPage(
        _index,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  void back() {
    if (_index > 0) {
      _index--;
      _pageController.animateToPage(
        _index,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _autoTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0F14),
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              IntroSlide(),
              IdentitySlide(),
              ChatSlide(),
              RoomSlide(),
              TokenSlide(),
              ClosingSlide(),
            ],
          ),
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: back,
                  child: const Text("Back",
                      style: TextStyle(color: Colors.white54)),
                ),
                TextButton(
                  onPressed: next,
                  child: const Text("Next",
                      style: TextStyle(color: Colors.blueAccent)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

/* -------------------- INTRO -------------------- */

class IntroSlide extends StatelessWidget {
  const IntroSlide({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Secure. Real-Time. Scalable.",
        style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

/* -------------------- IDENTITY -------------------- */

class IdentitySlide extends StatefulWidget {
  const IdentitySlide({super.key});

  @override
  State<IdentitySlide> createState() => _IdentitySlideState();
}

class _IdentitySlideState extends State<IdentitySlide>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FadeTransition(
        opacity: controller,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.lock_outline, size: 80, color: Colors.blueAccent),
            SizedBox(height: 20),
            Text(
              "Asymmetric Identity\nPublic / Private Key Security",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

/* -------------------- CHAT -------------------- */

class ChatSlide extends StatefulWidget {
  const ChatSlide({super.key});

  @override
  State<ChatSlide> createState() => _ChatSlideState();
}

class _ChatSlideState extends State<ChatSlide> {
  bool showSecond = false;
  bool typing = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        typing = false;
        showSecond = true;
      });
    });
  }

  Widget bubble(String text, bool isMe) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isMe ? Colors.blueAccent : Colors.white12,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(text,
            style: const TextStyle(color: Colors.white, fontSize: 14)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        bubble("Is the connection secure?", false),
        if (typing)
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Typing...",
                style: TextStyle(color: Colors.white54)),
          ),
        if (showSecond)
          bubble("End-to-end encrypted. Always.", true),
      ],
    );
  }
}

/* -------------------- ROOM -------------------- */

class RoomSlide extends StatefulWidget {
  const RoomSlide({super.key});

  @override
  State<RoomSlide> createState() => _RoomSlideState();
}

class _RoomSlideState extends State<RoomSlide>
    with SingleTickerProviderStateMixin {
  late AnimationController pulse;

  @override
  void initState() {
    super.initState();
    pulse =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..repeat(reverse: true);
  }

  @override
  void dispose() {
    pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ScaleTransition(
        scale: Tween(begin: 1.0, end: 1.1).animate(pulse),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.videocam, size: 80, color: Colors.blueAccent),
            SizedBox(height: 20),
            Text(
              "Encrypted Conference Rooms\nAES-256 Secured",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

/* -------------------- TOKEN -------------------- */

class TokenSlide extends StatefulWidget {
  const TokenSlide({super.key});

  @override
  State<TokenSlide> createState() => _TokenSlideState();
}

class _TokenSlideState extends State<TokenSlide>
    with SingleTickerProviderStateMixin {
  late AnimationController rise;

  @override
  void initState() {
    super.initState();
    rise =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..repeat(reverse: true);
  }

  @override
  void dispose() {
    rise.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SlideTransition(
        position: Tween(
          begin: const Offset(0, 0.2),
          end: const Offset(0, -0.2),
        ).animate(rise),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.monetization_on,
                size: 80, color: Colors.amber),
            SizedBox(height: 20),
            Text(
              "Integrated Token Economy\nJWT-Secured Transactions",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

/* -------------------- CLOSING -------------------- */

class ClosingSlide extends StatelessWidget {
  const ClosingSlide({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Built to Lead the Next Era\nof Digital Communities.",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 22,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}