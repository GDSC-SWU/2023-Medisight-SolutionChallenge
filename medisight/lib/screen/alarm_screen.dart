import 'dart:async';
import 'package:intl/intl.dart';

import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/material.dart';
import 'package:medisight/provider/alarm_state.dart';
import 'package:medisight/service/alarm_scheduler.dart';
import 'package:medisight/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({Key? key, required this.alarm}) : super(key: key);

  final Map<String, dynamic>? alarm;

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> with WidgetsBindingObserver {
  late FlutterTts tts = FlutterTts();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    tts.speak(widget.alarm!['name'] + " 알람입니다.");

    if (widget.alarm!['beep']) {
      FlutterRingtonePlayer.play(
          fromAsset: "assets/audios/ringtone.mp3",
          looping: true,
          volume: 5,
          asAlarm: false);
    }

    if (widget.alarm!['vibration']) {
      _vibrateDevice();
    }
  }

  void _vibrateDevice() {
    _timer = Timer.periodic(Duration(milliseconds: 1500), (timer) async {
      if (await Vibrate.canVibrate) {
        Vibrate.vibrate();
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        _dismissAlarm();
        break;
      default:
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  TimeOfDay fromString(String time) {
    int hh = 0;
    if (time.endsWith('PM')) hh = 12;
    time = time.split(' ')[0];
    return TimeOfDay(
      hour: hh +
          int.parse(time.split(":")[0]) %
              24, // in case of a bad time format entered manually by the user
      minute: int.parse(time.split(":")[1]) % 60,
    );
  }

  void _dismissAlarm() async {
    FlutterRingtonePlayer.stop();

    final alarmState = context.read<AlarmState>();
    final callbackAlarmId = alarmState.callbackAlarmId!;
    // 알람 콜백 ID는 `AlarmScheduler`에 의해 일(0), 월(1), 화(2), ... , 토요일(6) 만큼 더해져 있다.
    // 따라서 이를 7로 나눈 몫이 해당 요일을 나타낸다.
    final firedAlarmWeekday = callbackAlarmId % 7;
    final timeOfDay = fromString(widget.alarm!['time']);
    final nextAlarmTime = timeOfDay.toComingDateTimeAt(firedAlarmWeekday);

    await AlarmScheduler.reschedule(callbackAlarmId, nextAlarmTime);

    alarmState.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    final themeMode =
        Provider.of<ThemeProvider>(context, listen: false).themeMode;
    final now = DateTime.now();
    final format = DateFormat('Hm');

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Center(
              child: Container(
                width: 325,
                height: 325,
                decoration: ShapeDecoration(
                    shape: CircleBorder(
                        side: BorderSide(
                            color: themeMode == ThemeMode.light
                                ? Color.fromARGB(255, 255, 206, 60)
                                : Color.fromARGB(255, 255, 214, 0),
                            style: BorderStyle.solid,
                            width: 4))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(
                      Icons.alarm,
                      color: themeMode == ThemeMode.light
                          ? Color.fromARGB(255, 255, 206, 60)
                          : Color.fromARGB(255, 255, 214, 0),
                      size: 32,
                    ),
                    Text(
                      format.format(now),
                      style: const TextStyle(
                          fontSize: 52, fontWeight: FontWeight.w900),
                    ),
                    Text(
                      widget.alarm!['name'],
                      style: const TextStyle(fontSize: 24),
                    ),
                  ],
                ),
              ),
            ),
            widget.alarm!['expire'] != ""
                ? Text(
                    '사용기한: ${widget.alarm!['expire']}까지',
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                : Container(),
            ElevatedButton(
                onPressed: _dismissAlarm,
                style: ElevatedButton.styleFrom(
                    backgroundColor: themeMode == ThemeMode.light
                        ? Color.fromARGB(255, 255, 206, 60)
                        : Theme.of(context).canvasColor,
                    side: BorderSide(
                        color: themeMode == ThemeMode.light
                            ? Color.fromARGB(255, 255, 206, 60)
                            : Color.fromARGB(255, 255, 214, 0),
                        width: 2.5),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    padding: const EdgeInsets.all(20)),
                child: Text(
                  widget.alarm!['name'] + ' 알람 해제',
                  style: TextStyle(
                    color: themeMode == ThemeMode.light
                        ? Colors.black
                        : Color.fromARGB(255, 255, 214, 0),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
