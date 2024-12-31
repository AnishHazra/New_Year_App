import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class CelebrationScreen extends StatefulWidget {
  const CelebrationScreen({super.key});

  @override
  State<CelebrationScreen> createState() => _CelebrationScreenState();
}

class _CelebrationScreenState extends State<CelebrationScreen> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 5));
    _confettiController.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.center,
        children: [
          const Center(
            child: Text(
              '🎆 Happy New Year! 🎆',
              style: TextStyle(
                fontSize: 30,
                color: Colors.yellow,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Image.network(
                "https://media.tenor.com/pFWqZTC2LPIAAAAM/dancing-doge-doge.gif"),
          ),
          ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: true,
            //! Fireworks colors
            colors: const [
              Colors.red,
              Colors.green,
              Colors.blue,
              Colors.yellow
            ],
            numberOfParticles: 50,
          ),
        ],
      ),
    );
  }
}
