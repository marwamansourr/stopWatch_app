import 'dart:async';
import 'package:flutter/material.dart';

class StopWatchScreen extends StatefulWidget {
  const StopWatchScreen({Key? key}) : super(key: key);

  @override
  State<StopWatchScreen> createState() => _StopWatchScreenState();
}

class _StopWatchScreenState extends State<StopWatchScreen> {
  Duration duration = const Duration();
  Timer? timer;
  void addTime() {
    const addSeconds = 1;
    setState(() {
      final seconds = duration.inSeconds + addSeconds;
      duration = Duration(seconds: seconds);
    });
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      addTime();
    });
  }

  void resetTimer() {
    setState(() {
      duration = const Duration();
    });
  }

  void stopTimer() {
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stop Watch"),
        centerTitle: true,
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        buildTime(),
        const SizedBox(
          height: 25,
        ),
        buildButton(),
      ]),
    );
  }

  Widget buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours.remainder(60));
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildTimeCard(time: hours, header: "hours"),
        const SizedBox(
          width: 10,
        ),
        buildTimeCard(time: minutes, header: "minutes"),
        const SizedBox(
          width: 10,
        ),
        buildTimeCard(time: seconds, header: "seconds"),
      ],
    );
  }

  Widget buildButton() {
    final isRunning = timer == null ? false : timer!.isActive;
    return isRunning
        ? Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildButtonBase(
            onPress: () {
              if (isRunning) {
                stopTimer();
              }
            },
            text: "Stop"),
        const SizedBox(
          width: 8,
        ),
        buildButtonBase(
            onPress: () {
              resetTimer();
            },
            text: "Rest"),
      ],
    )
        : Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildButtonBase(
            onPress: () {
              startTimer();
            },
            text: "Start"),
      ],
    );
  }

  Widget buildTimeCard({required String time, required String header}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Text(
              time,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 72,
                  color: Colors.black),
            )),
        Text(
          header,
          style: const TextStyle(fontSize: 18, color: Colors.white),
        )
      ],
    );
  }

  Widget buildButtonBase({required Function() onPress, required String text}) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: TextButton(
            onPressed: onPress,
            child: Text(
              text,
              style: const TextStyle(color: Colors.black, fontSize: 18),
            )));
  }


}
