import 'package:flutter/material.dart';
import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'dart:async';
import 'package:new_year_2025/celebration_screen.dart';

class NewYearCountdown extends StatefulWidget {
  const NewYearCountdown({super.key});

  @override
  State<NewYearCountdown> createState() => _NewYearCountdownState();
}

class _NewYearCountdownState extends State<NewYearCountdown> {
  late Timer _timer;
  late Duration _timeRemaining;
  final DateTime _targetTime = DateTime(2025, 1, 1, 0, 0, 0);

  @override
  void initState() {
    super.initState();
    _timeRemaining = _targetTime.difference(DateTime.now());
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _timeRemaining = _targetTime.difference(DateTime.now());
        if (_timeRemaining <= Duration.zero) {
          _timer.cancel();
          _navigateToNextPage();
        }
      });
    });
  }

  void _navigateToNextPage() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const CelebrationScreen()),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Countdown to New Year 🎉',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            AnimatedFlipCounter(
              value: _timeRemaining.inSeconds.toDouble(),
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeInOut,
              fractionDigits: 0,
              textStyle: const TextStyle(
                fontSize: 40,
                color: Colors.yellowAccent,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              _formatDuration(_timeRemaining),
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
