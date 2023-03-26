import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:medisight/page/search_result.dart';
import 'package:medisight/screen/test_screen.dart';
import 'package:http_parser/http_parser.dart';

class ShootQr extends StatefulWidget {
  @override
  ShootQrState createState() => ShootQrState();
}

class ShootQrState extends State<ShootQr> {
  CameraController? _cameraController;
  Future<void>? _initCameraControllerFuture;
  int cameraIndex = 0;

  // bool isCapture = false;
  late File captureImage;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();
    _cameraController =
        CameraController(cameras[cameraIndex], ResolutionPreset.veryHigh);
    _initCameraControllerFuture = _cameraController!.initialize().then((value) {
      setState(() {});
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
                  Future.delayed(const Duration(seconds: 5), () {
                    print(
                        "================================start!================================");
                    // 10초마다 snapshot을 찍어서, 결과 도출 or 서버로 보냄
                    cameraSnapshot();
                    print(
                        "********************************capture!***************************************");
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

/*
  void postRequest(InputImage inputImage) async {
    File imageFile = File(inputImage.filePath!);
    List<int> imageBytes = imageFile.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);
    print(base64Image);
    Uri url = Uri.parse('http://34.64.120.235:8000/OCR/');
    http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      }, // this header is essential to send json data
      body: jsonEncode([
        {'image': '$base64Image'}
      ]),
    );
    print(
        "=================response.body: ${response.body}=======================");
  }
  */

  Future<void> hitAPI(InputImage inputImage, String filePath) async {
    var url = Uri.parse('http://34.64.120.235:8000/OCR/');
    try {
      http.MultipartRequest request = http.MultipartRequest(
        "POST",
        url,
      );
      /*
      http.Response response = await http.post(
        url,
        headers: {'Content-Type': 'application/multipart/form-data'},
      );
      */
      request.files
          .add(await http.MultipartFile.fromPath('imageFileList', filePath));

      var result = await request.send();

      /*
      final streamedResponse = await request.send();
      final result = await http.Response.fromStream(streamedResponse);
      */

      if (result.statusCode == 200) {
        print("===============Sucess connect============");
        // final responseBody = json.decode(result.body);
      } else {
        print("===============Fail connect: ${result.statusCode}============");
      }
    } catch (e) {
      print("==============connect error============");
      print("error: $e");
    }
  }

  Future scanBar(InputImage inputImage) async {
    final List<BarcodeFormat> formats = [BarcodeFormat.all];
    final barcodeScanner = BarcodeScanner(formats: formats);
    final List<Barcode> barcodes =
        await barcodeScanner.processImage(inputImage);

    print("--------------------------barcodes: $barcodes-----------------");
    print("------------------barcodes length: ${barcodes.length}-------------");

    if (barcodes.isEmpty) {
      print("바코드를 찍어주세요 or 손을 더 높이 들어주세요 or 화면 초점을 맞춰주세요");
      // 이미지를 서버로 보내는 코드
      // hitAPI(inputImage, inputImage.filePath!);
      // postRequest(inputImage);
    } else {
      for (Barcode barcode in barcodes) {
        final BarcodeType type = barcode.type;
        final String? displayValue;

        switch (type) {
          case BarcodeType.product:
            displayValue = barcode.displayValue;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => SearchResultPage(displayValue),
              ),
            );
            break;
          default:
            print("의약품의 바코드를 스캔해 주세요.");
            break;
        }
      }
    }
  }

  Future<void> cameraSnapshot() async {
    try {
      await _cameraController!.takePicture().then((value) {
        captureImage = File(value.path);
        scanBar(InputImage.fromFilePath(value.path));
      });

      print("-------------------------route1----------------------------");

      /// 화면 상태 변경
      setState(() {});
    } catch (e) {
      print("$e");
    }
  }
}
