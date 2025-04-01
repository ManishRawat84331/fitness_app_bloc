import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';

class StartWorkoutTimer extends StatefulWidget {
  final int time;
  final bool isPaused;

  const StartWorkoutTimer({
    required this.time,
    required this.isPaused,
    Key? key,
  }) : super(key: key);

  @override
  _StartWorkoutTimerState createState() => _StartWorkoutTimerState();
}

class _StartWorkoutTimerState extends State<StartWorkoutTimer>
    with SingleTickerProviderStateMixin {
  late final CustomTimerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CustomTimerController(
      vsync: this,
      begin: Duration(seconds: widget.time),
      end: Duration.zero,
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.isPaused ? _createPauseText() : _createCountdownTimer();
  }

  Widget _createCountdownTimer() {
    return CustomTimer(
      key: UniqueKey(),
      controller: _controller,
      builder: (state, remaining) {
        return Text(
          "${remaining.minutes}:${remaining.seconds.toString().padLeft(2, '0')}",
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        );
      },
    );
  }

  Widget _createPauseText() {
    final minutes = widget.time ~/ 60;
    final seconds = widget.time % 60;
    return Text(
      "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}",
      style: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
