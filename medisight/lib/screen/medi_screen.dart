import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medisight/service/alarm_scheduler.dart';
import 'create_alarm.dart';
import 'update_alarm.dart';

class MediScreen extends StatefulWidget {
  final String uid;
  const MediScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<MediScreen> createState() => _MediScreenState();
}

class _MediScreenState extends State<MediScreen> {
  CollectionReference? product;
  AlarmScheduler scheduler = new AlarmScheduler();

  void _switchAlarm(
    product,
    alarm,
    bool enabled,
  ) async {
    final alarmRef = product?.doc(alarm.id);
    await alarmRef.update({"enabled": enabled});
    final newAlarm = await alarmRef?.get();

    if (enabled) {
      await scheduler.scheduleRepeatable(newAlarm);
    } else {
      await scheduler.cancelRepeatable(newAlarm);
    }
  }

  void _handleCardTap(
    uid,
    alarm,
    BuildContext context,
  ) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                UpdateAlarm(uid: uid, alarm: alarm, responseBody: '-1')));
  }

  @override
  // uid가 null일 경우 return하는 함수 필요.
  void initState() {
    super.initState();

    product = FirebaseFirestore.instance
        .collection('user')
        .doc(widget.uid)
        .collection('alarm');
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController expirationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("알람")),
      body: StreamBuilder(
        stream: product?.snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot alarm = streamSnapshot.data!.docs[index];
                return _AlarmCard(
                    product: product,
                    alarm: alarm,
                    onTapSwitch: (enabled) {
                      _switchAlarm(product, alarm, enabled);
                    },
                    onTapCard: () {
                      _handleCardTap(widget.uid, alarm, context);
                    });
              },
            );
          }
          return CircularProgressIndicator();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      CreateAlarm(uid: widget.uid, responseBody: '-1')));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class _AlarmCard extends StatelessWidget {
  const _AlarmCard({
    Key? key,
    required this.product,
    required this.alarm,
    required this.onTapSwitch,
    required this.onTapCard,
  }) : super(key: key);

  final product;
  final alarm;
  final void Function(bool enabled) onTapSwitch;
  final VoidCallback onTapCard;

  Future<void> _delete(String productId) async {
    AlarmScheduler scheduler = new AlarmScheduler();

    await scheduler.cancelRepeatable(alarm);
    await product?.doc(productId).delete();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    String date = '';

    alarm['weekday'][0] ? date += '일 ' : null;
    alarm['weekday'][1] ? date += '월 ' : null;
    alarm['weekday'][2] ? date += '화 ' : null;
    alarm['weekday'][3] ? date += '수 ' : null;
    alarm['weekday'][4] ? date += '목 ' : null;
    alarm['weekday'][5] ? date += '금 ' : null;
    alarm['weekday'][6] ? date += '토 ' : null;

    return Card(
        child: InkWell(
      onTap: onTapCard,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 12, top: 5, right: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    const Icon(
                      Icons.label,
                      color: Colors.blue,
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      alarm['name']!,
                      style:
                          const TextStyle(fontSize: 20, fontFamily: 'avenir'),
                    ),
                  ],
                ),
                Switch(
                  value: alarm['enabled'],
                  onChanged: onTapSwitch,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Text(
              date,
              style: const TextStyle(fontFamily: 'avenir'),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 12, right: 12, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  alarm['time'],
                  style: const TextStyle(
                      fontFamily: 'avenir',
                      fontSize: 24,
                      fontWeight: FontWeight.w700),
                ),
                IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      _delete(alarm.id);
                    }),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
