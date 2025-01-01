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
  DateTime? _targetTime;

  @override
  void initState() {
    super.initState();
    _timeRemaining = Duration.zero;
  }

  void _startTimer() {
    if (_targetTime == null) return;

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _timeRemaining = _targetTime!.difference(DateTime.now());
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

  void _pickDateTime() async {
    DateTime now = DateTime.now();

    //! Pick the date
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 10),
    );

    if (pickedDate == null) return;

    //! Pick the time
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime == null) return;

    setState(() {
      _targetTime = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );
      _timeRemaining = _targetTime!.difference(DateTime.now());
      _startTimer();
    });
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
              'Countdown Timer ⏳',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            if (_targetTime != null)
              Column(
                children: [
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
              )
            else
              const Text(
                textAlign: TextAlign.center,
                "Select a date and time to start the countdown!",
                style: TextStyle(fontSize: 18, color: Colors.white70),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickDateTime,
        backgroundColor: Colors.yellowAccent,
        child: const Icon(Icons.timer, color: Colors.black),
      ),
    );
  }
}
