import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:flutter_beep/flutter_beep.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShootPeriod extends StatefulWidget {
  @override
  ShootPeriodState createState() => ShootPeriodState();
}

class ShootPeriodState extends State<ShootPeriod> {
  CameraController? _cameraController;
  Future<void>? _initCameraControllerFuture;
  int cameraIndex = 0;
  bool _canVibrate = true;
  final FlutterTts tts = FlutterTts();
  bool isAlert = false;

  final user = FirebaseAuth.instance.currentUser!;
  CollectionReference userProduct =
      FirebaseFirestore.instance.collection('user');

  @override
  void initState() {
    super.initState();
    _initCamera();
    _initRecog();
    tts.setLanguage('en');
    tts.setSpeechRate(0.4);
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();
    _cameraController =
        CameraController(cameras[cameraIndex], ResolutionPreset.veryHigh);
    _initCameraControllerFuture = _cameraController!.initialize().then((value) {
      setState(() {});
    });
  }

  void _initRecog() async {
    bool canVibrate = await Vibrate.canVibrate;
    setState(() {
      // 진동 관련
      _canVibrate = canVibrate;
      _canVibrate
          ? debugPrint("This device can vibrate")
          : debugPrint("This device cannot vibrate");
    });
  }

  @override
  void dispose() {
    _cameraController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Camera Example"),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Flexible(
            flex: 3,
            fit: FlexFit.tight,
            child: FutureBuilder<void>(
              future: _initCameraControllerFuture,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (!isAlert) {
                    Future.delayed(const Duration(seconds: 5), () {
                      // 5초마다 snapshot을 찍어서, 결과 도출 or 서버로 보냄
                      cameraSnapshot();
                    });
                  }
                  return SizedBox(
                    width: size.width,
                    height: size.width,
                    child: ClipRect(
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: SizedBox(
                          width: size.width,
                          child: AspectRatio(
                              aspectRatio:
                                  1 / _cameraController!.value.aspectRatio,
                              child: CameraPreview(_cameraController!)),
                        ),
                      ),
                    ),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> hitAPI(InputImage inputImage) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('http://34.64.96.217:8000/OCR/'),
      );

      request.files.add(
        await http.MultipartFile.fromPath(
          'file',
          inputImage.filePath!,
          contentType: MediaType('image', 'png'),
        ),
      );

      final response = await http.Response.fromStream(await request.send());

      if (response.statusCode == 200) {
        final responseBody = json.decode(utf8.decode(response.bodyBytes));
        if (responseBody == null) {
          tts.speak("카메라에 상자의 네 꼭짓점이 모두 나오게 스캔해 주세요.");
        } else {
          FlutterBeep.beep(); // 비프음
          if (_canVibrate) Vibrate.feedback(FeedbackType.heavy); // 진동
          isAlert = true;
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('유효기간'),
              content: Text(responseBody),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isAlert = false;
                    });
                    Navigator.pop(context);
                  },
                  child: const Text('닫기'),
                ),
              ],
            ),
          );
          print("responseBody : $responseBody");
        }
      } else {
        print(
            "===============Fail connect: ${response.statusCode}============");
      }
    } catch (e) {
      print("error: $e");
    }
  }

  Future<void> cameraSnapshot() async {
    try {
      await _cameraController!.takePicture().then((value) async {
        await hitAPI(InputImage.fromFilePath(value.path));
      });

      // 화면 상태 변경
      setState(() {});
    } catch (e) {
      print("$e");
    }
  }
}

/*

Future<void> _getRoute(User user) async {
  final documentSnapshot =
      await FirebaseFirestore.instance.collection('user').doc(user.uid).get();
  bool subfield = documentSnapshot.data()?.containsKey('isAlarm') ?? false;

  if (subfield) {
    // 알람페이지에서 들어왔을 떄
    await FirebaseFirestore.instance
        .collection('user')
        .doc(user.uid)
        .set({'isAlarm': false});

    return Navigator.pop(
      context,
      MaterialPageRoute(builder: (_) => CreateAlarm()),
    );
  } else {
    // 촬영 페이지에서 들어왔을 때
  }
}
*/