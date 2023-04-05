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
import 'package:medisight/screen/create_alarm.dart';
import '../page/search_result.dart';

class ShootQr extends StatefulWidget {
  @override
  ShootQrState createState() => ShootQrState();
}

class ShootQrState extends State<ShootQr> {
  CameraController? _cameraController;
  Future<void>? _initCameraControllerFuture;
  int cameraIndex = 0;
  bool _canVibrate = true;
  final FlutterTts tts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _initCamera();
    _initRecog();
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
        title: Text("의약품 촬영"),
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
                  Future.delayed(const Duration(seconds: 3), () {
                    // 3초마다 snapshot을 찍어서, 결과 도출 or 서버로 보냄
                    cameraSnapshot();
                  });
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
        Uri.parse('http://34.64.96.217:8000/guide/'),
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
        String responseBodyCut = responseBody.toString().substring(9);
        tts.speak(responseBodyCut.toString());
        print(responseBodyCut.toString());
      } else {
        print(
            "===============Fail connect: ${response.statusCode}============");
      }
    } catch (e) {
      print("error: $e");
    }
  }

  bool checkMedicine(String code) {
    final int index;
    final String cutCode;
    final String businessCode;
    bool isMedi = false;
    var codeSize = code.length;
    var startCodeList = ['0499', '6199', '6399'];
    var endCodeList = ['1000', '6299', '6999'];

    if (code.contains('880') && codeSize >= 13) {
      index = code.indexOf('880');
      print("index: $index");
      cutCode = code.substring(index, 13);
      print("cutCode: $cutCode");
      businessCode = cutCode.substring(3, 7);
      print("cutCode: $businessCode");

      for (int i = 0; i < 3; i++) {
        print("start: ${businessCode.compareTo(startCodeList[i])}");
        print("end: ${businessCode.compareTo(endCodeList[i])}");
        if (businessCode.compareTo(startCodeList[i]) == 1 &&
            businessCode.compareTo(endCodeList[i]) == -1) {
          isMedi = true;
          break;
        }
      }
    }
    return isMedi;
  }

  void qrCallback(String code) {
    FlutterBeep.beep(); // 비프음
    if (_canVibrate) Vibrate.feedback(FeedbackType.heavy); // 진동

    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SearchResultPage(code),
      ),
    );
  }

  Future scanBar(InputImage inputImage) async {
    final List<BarcodeFormat> formats = [BarcodeFormat.all];
    final barcodeScanner = BarcodeScanner(formats: formats);
    final List<Barcode> barcodes =
        await barcodeScanner.processImage(inputImage);

    print("--------------------------barcodes: $barcodes-----------------");
    print("------------------barcodes length: ${barcodes.length}-------------");

    if (barcodes.isEmpty) {
      // 이미지를 서버로 보내는 코드
      await hitAPI(inputImage);
    } else {
      for (Barcode barcode in barcodes) {
        final BarcodeType type = barcode.type;
        final String? displayValue = barcode.displayValue;
        final bool isMedi;

        if (displayValue == null) {
          tts.speak("올바른 바코드를 스캔해 주세요.");
        } else {
          switch (type) {
            case BarcodeType.product:
              isMedi = checkMedicine(displayValue);
              if (isMedi) {
                qrCallback(displayValue);
              } else {
                tts.speak("의약품의 바코드를 스캔해 주세요.");
              }
              break;
            default:
              tts.speak("의약품의 바코드를 스캔해 주세요.");
              break;
          }
        }
      }
    }
  }

  Future<void> cameraSnapshot() async {
    try {
      await _cameraController!.takePicture().then((value) async {
        await scanBar(InputImage.fromFilePath(value.path));
      });

      // 화면 상태 변경
      setState(() {});
    } catch (e) {
      print("$e");
    }
  }
}
