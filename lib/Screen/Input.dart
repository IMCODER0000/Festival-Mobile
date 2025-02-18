// Input.dart

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:ui';
import 'dart:io';
import 'dart:convert';
import '../communication.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: InputScreen(),
    );
  }
}

class InputScreen extends StatelessWidget {
  late TextEditingController festivalNameController;
  late TextEditingController dateController;
  late TextEditingController hashtagController;
  late TextEditingController reviewController;

  InputScreen({Key? key}) : super(key: key) {
    festivalNameController = TextEditingController();
    dateController = TextEditingController();
    hashtagController = TextEditingController();
    reviewController = TextEditingController();
  }

  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/a.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          Positioned(
            top: 40,
            left: 10,
            child: GestureDetector(
              onTap: () {
                // 뒤로가기
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 30.0,
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: Image.asset(
              'assets/b.jpg',
              width: 100, // 이미지의 너비 조절
              height: 100, // 이미지의 높이 조절
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.0,
            left: 16.0,
            right: 16.0,
            child: Column(
              children: [
                const SizedBox(height: 100.0),
                GestureDetector(
                  onTap: () {
                    _getImage(context); // 이미지 업로드 함수 호출
                  },
                  child: Container(
                    width: 100.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: _image == null
                        ? const Icon(
                            Icons.add_photo_alternate,
                            size: 40.0,
                            color: Colors.black,
                          )
                        : Image.file(_image!),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: festivalNameController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: '축제이름',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: hashtagController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: '해시태그',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: reviewController,
                  maxLines: 4,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: '후기 입력',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 32.0),
                ElevatedButton(
                  onPressed: () async {
                    if (_image != null) {
                      String fName = festivalNameController.text;

                      String hash = hashtagController.text;
                      String review = reviewController.text;
                      print(fName);
                      print(hash);
                      print(review);

                      await ServerCommunication().uploadImageWithText(
                        _image!,
                        fName,
                        hash,
                        review,
                      );

                      showUploadDialog(context);
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('이미지 선택 오류'),
                            content: const Text('이미지를 선택해주세요.'),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('확인'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.0),
                    child: Text('Upload'),
                  ),
                ),
              ],
            ),
          )
        ]));
  }

  Future<void> _getImage(BuildContext context) async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      // 이미지가 선택되었을 때만 변수에 저장
      _image = File(pickedImage.path);
    }
  }

  void showUploadDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Upload Completed'),
          content: const Text('upload되었습니다.'),
          actions: <Widget>[
            TextButton(
              child: const Text('확인'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
