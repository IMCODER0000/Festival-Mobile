import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:ui';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<ProfileScreen> {
  String userName = '사용자 이름';
  String email = '이메일 주소';
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 배경 이미지
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/a.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 배경 이미지에 어둡게 하는 BackdropFilter
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),

          // '뒤로가기' 버튼
          Positioned(
            top: 35.0,
            left: 0.0,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),

          // 이미지, 사용자 이름, 이메일, 버튼들을 화면 위로 옮김
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end, // 아래에 정렬
              children: [
                GestureDetector(
                  onTap: () {
                    _getImage(context);
                  },
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: _image != null
                        ? FileImage(_image!)
                        : const AssetImage('assets/default_profile_image.jpg')
                            as ImageProvider<Object>,
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  userName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  email,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // 프로필 수정 다이얼로그 함수 호출
                        _showEditProfileDialog(context);
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                      ),
                      child: const Text('프로필 저장'),
                    ),
                    const SizedBox(width: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        // 메시지 보내기 로직 추가
                        _sendMessage(context);
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                      ),
                      child: const Text('메시지 보내기'),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                // 관심축제 텍스트 추가
                const Padding(
                  padding: EdgeInsets.only(right: 300.0),
                  child: Text(
                    '좋아요',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _getImage(BuildContext context) async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  // 프로필 수정 다이얼로그를 띄우는 함수
  void _showEditProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('프로필 수정', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.black,
          content: Column(
            children: [
              TextField(
                controller: _userNameController,
                decoration: const InputDecoration(
                  labelText: '새로운 사용자 이름',
                  labelStyle: TextStyle(color: Colors.white),
                ),
                onChanged: (value) {
                  setState(() {
                    userName = value;
                  });
                },
              ),
              TextField(
                controller: _bioController,
                decoration: const InputDecoration(
                  labelText: '새로운 이메일 주소',
                  labelStyle: TextStyle(color: Colors.white),
                ),
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('취소', style: TextStyle(color: Colors.white)),
            ),
            ElevatedButton(
              onPressed: () {
                // 프로필 수정 완료 시 필요한 로직 추가
                _handleSaveProfile(context);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              child: const Text('저장', style: TextStyle(color: Colors.black)),
            ),
          ],
        );
      },
    );
  }

  void _handleSaveProfile(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('프로필이 성공적으로 저장되었습니다.'),
      ),
    );
  }

  void _sendMessage(BuildContext context) {
    TextEditingController userNameController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('메시지 보내기', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.black,
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 사용자 이름 입력 칸 (박스 형태)
              Container(
                width: 300.0,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextField(
                    controller: userNameController,
                    decoration: const InputDecoration(
                      labelText: '사용자 이름',
                      labelStyle: TextStyle(color: Colors.white),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),

              // 메시지 입력 칸 (박스 형태)
              Container(
                width: 300.0,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    maxLength: 150,
                    maxLines: null,
                    decoration: const InputDecoration(
                      labelText: '메시지를 입력하세요 (최대 150자)',
                      labelStyle: TextStyle(color: Colors.white),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(8.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // actions에 Column을 사용하여 버튼을 세로로 배치합니다.
          // actionsPadding을 이용하여 actions의 위치를 조절합니다.
          actionsPadding: const EdgeInsets.only(right: 16.0),
          actions: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // 종이비행기 버튼
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.white),
                  onPressed: () {
                    _handleSendMessage(context);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  // _handleSendMessage 함수는 변경하지 않았습니다.
  void _handleSendMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('사용자의 메시지가 전송되었습니다.'),
      ),
    );
  }
}
