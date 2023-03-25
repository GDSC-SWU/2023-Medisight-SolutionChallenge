import 'package:flutter/material.dart';
import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';
import 'package:flutter_beep/flutter_beep.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:medisight/page/search_result.dart';
import 'package:wakelock/wakelock.dart';
import 'test_screen.dart';

class ShootMedi extends StatefulWidget {
  const ShootMedi({super.key});

  @override
  ShootMediState createState() => ShootMediState();
}

class ShootMediState extends State<ShootMedi> {
  String? _qrInfo = "스캔하세요";
  bool _canVibrate = true;
  bool _camState = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  /// 초기화 함수
  _init() async {
    bool canVibrate = await Vibrate.canVibrate;
    setState(() {
      // 화면 꺼짐 방지
      Wakelock.enable();

      // QR 코드 스캔 관련
      _camState = true;

      // 진동 관련
      _canVibrate = canVibrate;
      _canVibrate
          ? debugPrint("This device can vibrate")
          : debugPrint("This device cannot vibrate");
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  // QR/Bar Code 스캔 성공시 호출
  _qrCallback(String? code) {
    setState(() {
      // 동일한걸 계속 읽을 경우 한번만 소리/진동 실행
      if (code != _qrInfo) {
        FlutterBeep.beep(); // 비프음
        if (_canVibrate) Vibrate.feedback(FeedbackType.heavy); // 진동

        Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => SearchResultPage(code),
            ));
      }
      _camState = false;
      _qrInfo = code;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("의약품 촬영: QR/Bar코드인식")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 500,
            width: 500,
            child: QRBarScannerCamera(
              // 에러 발생시
              onError: (context, error) => Text(
                error.toString(),
                style: const TextStyle(color: Colors.red),
              ),
              // QR이 읽혔을 경우
              qrCodeCallback: (code) {
                _qrCallback(code);
              },
            ),
          ),

          // 사이즈 자동 조절을 위해 FittedBox 사용
          FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                _qrInfo!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ))
        ],
      ),
    );
  }
}
