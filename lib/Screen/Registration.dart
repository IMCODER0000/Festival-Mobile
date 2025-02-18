import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:http/http.dart' as http;
import './Sel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: RegistrationScreen(),
    );
  }
}

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isKeyboardVisible = false;

  // 사용자가 입력한 데이터를 저장하는 변수들
  String nickname = '';
  String name = '';
  String birth = '';
  String tell = '';
  String email = '';
  String password = '';
  String address = '';

  @override
  void initState() {
    super.initState();

    // 키보드 감지 이벤트 등록
    KeyboardVisibilityController().onChange.listen((bool visible) {
      setState(() {
        _isKeyboardVisible = visible;
        if (visible) {
          // 키보드가 나타나면 화면을 자동으로 스크롤
          _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Stack(
          children: [
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
                width: 100,
                height: 100,
              ),
            ),
            Positioned(
              child: Column(
                children: [
                  const SizedBox(height: 80.0),
                  const Text(
                    '회원가입',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextField(
                    style: const TextStyle(color: Colors.white),
                    onChanged: (value) {
                      nickname = value;
                    },
                    decoration: const InputDecoration(
                      labelText: '닉네임',
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
                    style: const TextStyle(color: Colors.white),
                    onChanged: (value) {
                      name = value;
                    },
                    decoration: const InputDecoration(
                      labelText: '이름',
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
                    style: const TextStyle(color: Colors.white),
                    onChanged: (value) {
                      birth = value;
                    },
                    decoration: const InputDecoration(
                      labelText: '출생년도 (ex_ 1999-08-23)',
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
                    style: const TextStyle(color: Colors.white),
                    onChanged: (value) {
                      tell = value;
                    },
                    decoration: const InputDecoration(
                      labelText: '전화번호  ',
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
                    style: const TextStyle(color: Colors.white),
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Email',
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
                    obscureText: true,
                    style: const TextStyle(color: Colors.white),
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Password',
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
                    style: const TextStyle(color: Colors.white),
                    onChanged: (value) {
                      address = value;
                    },
                    decoration: const InputDecoration(
                      labelText: '주소',
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
                    onPressed: () {
                      _registerUser(context);
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32.0),
                      child: Text('회원가입'),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  GestureDetector(
                    onTap: () {
                      // 뒤로가기
                      Navigator.pop(context);
                    },
                    child: const Text(
                      '뒤로가기',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _registerUser(BuildContext context) async {
    // 서버 URL (본인의 서버 주소로 변경)
    String serverUrl = 'http://121.169.139.193:4000/api/join';

    try {
      // HTTP POST 요청 보내기
      var response = await http.post(
        Uri.parse(serverUrl),
        body: {
          'nickname': nickname,
          'name': name,
          'birth': birth,
          'tell': tell,
          'email': email,
          'password': password,
          'address': address,
        },
      );

      // 응답 처리
      if (response.statusCode == 200) {
        // 회원가입 성공
        print('회원가입 성공');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('알림'),
              content: const Text('회원가입이 성공적으로 완료되었습니다.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // 대화상자 닫기
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SelScreen()),
                    );
                  },
                  child: const Text('확인'),
                ),
              ],
            );
          },
        );
      } else {
        // 회원가입 실패
        print('회원가입 실패: ${response.statusCode}');
      }
    } catch (e) {
      // 오류 처리
      print('오류 발생: $e');
    }
  }
}
