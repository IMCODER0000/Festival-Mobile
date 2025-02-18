// Login.dart

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:ui';
import './Home.dart';
import '../AuthManager.dart';
import 'package:provider/provider.dart';
import './Registration.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  LoginScreen({
    Key? key,
  }) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
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
            top: 10,
            right: 10,
            child: Image.asset(
              'assets/b.jpg',
              width: 100,
              height: 100,
            ),
          ),
          Positioned(
            top: 50.0,
            left: 10.0,
            child: GestureDetector(
              onTap: () {
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
            top: MediaQuery.of(context).size.height * 0.3,
            left: 16.0,
            right: 16.0,
            child: Column(
              children: [
                const Text(
                  '로그인',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32.0),
                TextField(
                  controller: emailController,
                  style: const TextStyle(color: Colors.white),
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
                  controller: passwordController,
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
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
                const SizedBox(height: 32.0),
                ElevatedButton(
                  onPressed: () async {
                    await _loginUser(context);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.0),
                    child: Text('로그인'),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigate to registration screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegistrationScreen(),
                      ),
                    );
                  },
                  child: RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                      children: [
                        TextSpan(text: "회원이 아니신가요? "),
                        TextSpan(
                          text: " 회원가입 →",
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
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

  Future<void> _loginUser(BuildContext context) async {
    final String email = emailController.text;
    final String password = passwordController.text;

    // Provider를 사용하여 AuthManager에 대한 참조를 얻음
    final AuthManager authManager =
        Provider.of<AuthManager>(context, listen: false);

    final response = await http.post(
      Uri.parse('http://121.169.139.193:4000/api/login'),
      body: {
        'email': email,
        'password': password,
      },
    );

    final Map<String, dynamic> data = json.decode(response.body);
    print('서버 응답: $data');

    if (data.containsKey('results')) {
      final List<dynamic>? results = data['results'];

      if (results != null && results.isNotEmpty) {
        final Map<String, dynamic> userInfo = results[0];
        authManager.setLoggedIn(true);
        authManager.setUsername(userInfo['name']);
        authManager.setUserId(userInfo['user_ID']);
        authManager.setUserEmail(userInfo['user_ID']);
        authManager.setUserNickname(userInfo['Nickname']);

        final String categoryString =
            userInfo['Category'] ?? ''; // 만약 'Category'가 null이면 빈 문자열로 초기화
        final List<String> userCategories = categoryString.split(',');

        authManager.setUserCategories(userCategories);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      } else {
        print('로그인 실패: 사용자 정보가 없습니다.');
      }
    } else {
      print('로그인 실패: 서버 응답 형식이 올바르지 않습니다.');
    }
  }
}
