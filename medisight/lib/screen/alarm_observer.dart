import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medisight/provider/alarm_state.dart';
import 'package:provider/provider.dart';
import 'package:medisight/service/alarm_polling_worker.dart';
import 'package:medisight/screen/alarm_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AlarmObserver extends StatefulWidget {
  final Widget child;
  final uid;

  const AlarmObserver({
    Key? key,
    required this.uid,
    required this.child,
  }) : super(key: key);

  @override
  State<AlarmObserver> createState() => _AlarmObserverState();
}

class _AlarmObserverState extends State<AlarmObserver>
    with WidgetsBindingObserver {
  late List<Map<String, dynamic>> firestoreList = [];

  @override
  void initState() {
    super.initState();

    CollectionReference collectionRef = FirebaseFirestore.instance
        .collection('user')
        .doc(widget.uid)
        .collection('alarm');
    collectionRef.get().then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        List<Map<String, dynamic>> firestoreList = querySnapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
        setState(() {
          this.firestoreList = firestoreList;
        });
      }
    });

    WidgetsBinding.instance.addObserver(this);
  }

  Map<String, dynamic>? getAlarmBy(int callbackId) {
    for (final alarm in firestoreList) {
      final id = (callbackId / 7).floor() * 7;

      if (id == alarm['alarmId']) {
        debugPrint('found ${jsonEncode(alarm)}');
        return alarm;
      }
    }
    return null;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        AlarmPollingWorker().createPollingWorker(context.read<AlarmState>());
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AlarmState>(builder: (context, state, child) {
      Widget? alarmScreen;

      if (state.isFired) {
        final callbackId = state.callbackAlarmId!;
        Map<String, dynamic>? alarm = getAlarmBy(callbackId);
        if (alarm != null) {
          alarmScreen = AlarmScreen(alarm: alarm);
        }
      }
      return IndexedStack(
        index: alarmScreen != null ? 0 : 1,
        children: [
          alarmScreen ?? Container(),
          widget.child,
        ],
      );
    });
  }
}
