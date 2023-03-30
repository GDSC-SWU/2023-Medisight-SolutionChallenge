import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medisight/screen/shoot_period.dart';
import '../provider/CustomCheckBoxGroup.dart';
import 'package:medisight/service/alarm_scheduler.dart';
import 'package:medisight/screen/medi_screen.dart';
import 'package:medisight/screen/alarm_observer.dart';
import 'package:medisight/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

class CreateAlarm extends StatefulWidget {
  final String uid;
  final responseBody;
  const CreateAlarm({Key? key, required this.uid, required this.responseBody})
      : super(key: key);

  @override
  State<CreateAlarm> createState() => _CreateAlarmState();
}

class _CreateAlarmState extends State<CreateAlarm> {
  CollectionReference? product;
  bool _beepIsChecked = true;
  bool _vibIsChecked = true;
  late TimeOfDay time;
  late List<Map<String, dynamic>> firestoreList;

  @override
  void initState() {
    super.initState();
    product = FirebaseFirestore.instance
        .collection('user')
        .doc(widget.uid)
        .collection('alarm');

    product?.orderBy('alarmId', descending: false).get().then((querySnapshot) {
      firestoreList = List<Map<String, dynamic>>.from(
          querySnapshot.docs.map((doc) => doc.data()).toList());
      setState(() {});
    });
  }

  void _onCameraButtonPressed() async {
    // navigate to camera screen
    final expirationDate = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const ShootPeriod(
          isFrom: 'create',
          alarm: null,
        ),
      ),
    );
    setState(() {
      expirationController.text = expirationDate;
    });
  }

  int getAvailableAlarmId() {
    int id = 14;

    for (final alarm in firestoreList) {
      if (alarm['alarmId'] != id) {
        break;
      }
      id = id + 7;
    }
    return id;
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController expirationController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final themeMode =
        Provider.of<ThemeProvider>(context, listen: false).themeMode;
    if (widget.responseBody != '-1') {
      expirationController.text = widget.responseBody;
    }

    String value = "";
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("내 약품 추가"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 약품명 입력
            Container(
              width: size.width,
              padding: const EdgeInsets.only(
                  left: 34, top: 30, right: 34, bottom: 13),
              child: const Text(
                '약품명',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              width: size.width * 0.85,
              height: 52,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                color: themeMode == ThemeMode.light
                    ? Color(0xffffffff)
                    : Theme.of(context).canvasColor,
                border: Border.all(
                    width: 2.0,
                    color: themeMode == ThemeMode.light
                        ? Color(0xffdbe2ea)
                        : Theme.of(context).primaryColor),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0a2c2738),
                    offset: Offset(0, 4),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: TextField(
                controller: nameController,
                style: TextStyle(
                  fontSize: 14,
                  color: themeMode == ThemeMode.light
                      ? Color(0xff000000)
                      : Colors.white,
                  fontWeight: FontWeight.w500,
                ),
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                  border: InputBorder.none,
                  hintText: "약품명을 입력하세요.",
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Color(0xffcbd0d6),
                  ),
                ),
              ),
            ),

            // 사용 기한 입력
            Container(
              width: size.width,
              padding: const EdgeInsets.only(
                  left: 34, top: 30, right: 34, bottom: 13),
              child: const Text(
                '사용 기한',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              width: size.width * 0.85,
              height: 52,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                color: themeMode == ThemeMode.light
                    ? Color(0xffffffff)
                    : Theme.of(context).canvasColor,
                border: Border.all(
                    width: 2.0,
                    color: themeMode == ThemeMode.light
                        ? Color(0xffdbe2ea)
                        : Theme.of(context).primaryColor),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0a2c2738),
                    offset: Offset(0, 4),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: TextField(
                controller: expirationController,
                readOnly: false,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      helpText: "유효기간 설정",
                      cancelText: "취소",
                      confirmText: "확인",
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101));

                  if (pickedDate != null) {
                    print(pickedDate);
                    String formattedDate =
                        DateFormat('yyyy년 MM월 dd일').format(pickedDate);
                    print(formattedDate);

                    setState(() {
                      expirationController.text = formattedDate;
                    });
                  }
                },
                style: TextStyle(
                  fontSize: 14,
                  color: themeMode == ThemeMode.light
                      ? Color(0xff000000)
                      : Colors.white,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: _onCameraButtonPressed,
                    icon: Icon(
                      Icons.camera_alt,
                      color: themeMode == ThemeMode.light
                          ? Color(0xff000000)
                          : Theme.of(context).primaryColor,
                    ),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                  border: InputBorder.none,
                  hintText: "사용기한을 입력하세요.",
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    color: Color(0xffcbd0d6),
                  ),
                ),
                onChanged: (text) {
                  value = text;
                  print(value);
                },
              ),
            ),

            // 알람 시간 입력
            Container(
              width: size.width,
              padding: const EdgeInsets.only(
                  left: 34, top: 30, right: 34, bottom: 13),
              child: const Text(
                '알람 시간',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              width: size.width * 0.85,
              height: 52,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                color: themeMode == ThemeMode.light
                    ? Color(0xffffffff)
                    : Theme.of(context).canvasColor,
                border: Border.all(
                    width: 2.0,
                    color: themeMode == ThemeMode.light
                        ? Color(0xffdbe2ea)
                        : Theme.of(context).primaryColor),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0a2c2738),
                    offset: Offset(0, 4),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: TextField(
                controller: timeController,
                readOnly: false,
                onTap: () async {
                  time = (await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                      initialEntryMode: TimePickerEntryMode.input,
                      cancelText: "취소",
                      confirmText: "확인",
                      helpText: "알람 시간 설정",
                      hourLabelText: "시간",
                      minuteLabelText: "분"))!; //end of showTimePicker
                  timeController.text = time.format(context);
                },
                style: TextStyle(
                  fontSize: 14,
                  color: themeMode == ThemeMode.light
                      ? Color(0xff000000)
                      : Colors.white,
                  fontWeight: FontWeight.w500,
                ),
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                  border: InputBorder.none,
                  hintText: "복약시간을 선택하세요.",
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Color(0xffcbd0d6),
                  ),
                ),
                onChanged: (text) {
                  value = text;
                },
              ),
            ),

            // 요일 선택
            Container(
              width: size.width,
              padding: const EdgeInsets.only(
                  left: 34, top: 30, right: 34, bottom: 13),
              child: const Text(
                '요일 선택',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              width: size.width,
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              child: CustomCheckBoxGroup(
                  controller: dateController,
                  enableShape: true,
                  elevation: 0,
                  autoWidth: true,
                  unSelectedColor: Theme.of(context).canvasColor,
                  buttonLables: ["일", "월", "화", "수", "목", "금", "토"],
                  buttonValuesList: ["일", "월", "화", "수", "목", "금", "토"],
                  checkBoxButtonValues: (values) {
                    dateController.text = values.join(" ");
                  },
                  selectedColor: Theme.of(context).primaryColor

                  // colorScheme.secondary
                  ),
            ),

            Container(
                height: 1.0,
                width: size.width * 0.9,
                color: Color.fromARGB(255, 197, 196, 196)),

            // 알람음
            Row(
              // 오른쪽 간격 수정하기
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(
                      left: 34, top: 30, right: 25, bottom: 13),
                  child: const Text(
                    '알람음',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                      left: 34, top: 30, right: 25, bottom: 13),
                  child: Switch(
                    value: _beepIsChecked,
                    onChanged: (value) {
                      setState(() {
                        _beepIsChecked = value;
                      });
                    },
                    activeColor: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),

            // 진동음
            Row(
              // 오른쪽 간격 수정하기
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(
                      left: 34, top: 20, right: 25, bottom: 13),
                  child: const Text(
                    '진동',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                      left: 34, top: 20, right: 25, bottom: 13),
                  child: Switch(
                    value: _vibIsChecked,
                    onChanged: (value) {
                      setState(() {
                        _vibIsChecked = value;
                      });
                    },
                    activeColor: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.only(
                  left: 25, top: 0, right: 25, bottom: 13),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final String name = nameController.text.isEmpty
                      ? nameController.text = "알람"
                      : nameController.text;
                  final String timestr = timeController.text;
                  final String expiration = expirationController.text;
                  final List<String> dateList = dateController.text.split(' ');
                  final List<bool> weekday = [
                    false,
                    false,
                    false,
                    false,
                    false,
                    false,
                    false
                  ];
                  AlarmScheduler scheduler = new AlarmScheduler();

                  if (timestr.isNotEmpty && dateController.text.isNotEmpty) {
                    dateList.contains('일')
                        ? weekday[0] = true
                        : weekday[0] = false;
                    dateList.contains('월')
                        ? weekday[1] = true
                        : weekday[1] = false;
                    dateList.contains('화')
                        ? weekday[2] = true
                        : weekday[2] = false;
                    dateList.contains('수')
                        ? weekday[3] = true
                        : weekday[3] = false;
                    dateList.contains('목')
                        ? weekday[4] = true
                        : weekday[4] = false;
                    dateList.contains('금')
                        ? weekday[5] = true
                        : weekday[5] = false;
                    dateList.contains('토')
                        ? weekday[6] = true
                        : weekday[6] = false;

                    final alarmDocRef = await product?.add({
                      'alarmId': getAvailableAlarmId(),
                      'weekday': weekday,
                      'expire': expiration,
                      'name': name,
                      'time': timestr,
                      'beep': _beepIsChecked,
                      'vibration': _vibIsChecked,
                      'enabled': true,
                    });

                    final alarmDocSnapshot = await alarmDocRef?.get();
                    final alarmData = alarmDocSnapshot?.data();

                    await scheduler.scheduleRepeatable(alarmData);

                    nameController.text = "";
                    timeController.text = "";
                    dateController.text = "";

                    Navigator.pushNamedAndRemoveUntil(
                        context, '/', (_) => false);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => AlarmObserver(
                              uid: widget.uid,
                              child: MediScreen(uid: widget.uid))),
                    );
                  } else if (timestr.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('알람 시간을 입력하세요.'),
                          duration: Duration(seconds: 2)),
                    );
                  } else if (dateController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('요일을 선택하세요.'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                    elevation: 3,
                    // minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    padding: const EdgeInsets.all(20)),
                child: const Text(
                  '추가하기',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
