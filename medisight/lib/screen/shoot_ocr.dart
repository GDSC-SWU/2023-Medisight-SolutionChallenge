import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class Shootocr extends StatefulWidget {
  const Shootocr({Key? key}) : super(key: key);

  @override
  ShootocrState createState() => ShootocrState();
}

class ShootocrState extends State<Shootocr> {
  File? _image;
  final picker = ImagePicker();

  Future getImage(ImageSource imageSource) async {
    final image = await picker.pickImage(source: imageSource);

    setState(() {
      _image = File(image!.path);
      hitAPI();
    });
  }

  Widget showImage() {
    return Container(
        color: const Color(0xffd0cece),
        width: MediaQuery.of(context as BuildContext).size.width,
        height: MediaQuery.of(context as BuildContext).size.width,
        child: Center(
            child: _image == null
                ? const Text('No image selected.')
                : Image.file(File(_image!.path))));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return Scaffold(
      backgroundColor: const Color(0xfff4f3f9),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 25.0),
          showImage(),
          const SizedBox(
            height: 50.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FloatingActionButton(
                tooltip: 'pick Iamge',
                onPressed: () async {
                  getImage(ImageSource.camera);
                },
                child: const Icon(Icons.add_a_photo),
              ),

              FloatingActionButton(
                tooltip: 'pick Iamge',
                onPressed: () {
                  getImage(ImageSource.gallery);
                },
                child: const Icon(Icons.wallpaper),
              ),

              // Send image button
              FloatingActionButton(
                tooltip: 'Send Image',
                onPressed: () {
                  debugPrint('눌림');
                  performOCR(_image!);
                },
                child: const Icon(Icons.send),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Future<void> hitAPI() async {
  try {
    final response = await http.get(
      // 10.0.2.2
      'http://172.18.22.134:8000/' as Uri,
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
    } else {
      throw Exception('Failed to send image');
    }
  } catch (e) {}
}

void performOCR(File imageFile) async {
  var request = http.MultipartRequest(
    'POST',
    Uri.parse('http://172.18.22.134:8000/OCR/'),
  );

  request.files.add(
    http.MultipartFile(
      'file',
      imageFile.readAsBytes().asStream(),
      imageFile.lengthSync(),
      filename: imageFile.path.split("/").last,
    ),
  );

  var response = await request.send();
  var responseData = await response.stream.toBytes();

  if (response.statusCode == 200) {
    String result = utf8.decode(responseData);
    debugPrint("OCR Result: $result");
  } else {
    debugPrint("OCR failed with status code ${response.statusCode}");
  }
}
