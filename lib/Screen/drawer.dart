// drawer.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../AuthManager.dart';
import './Login.dart';
import './mypage.dart';
import './F_Input.dart';
import './Input.dart';
import './Home.dart';
import './Setting.dart';
import './mf.dart';

Widget myDrawer(BuildContext context) {
  final authManager = Provider.of<AuthManager>(context);

  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: const BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
          ),
          child: Stack(
            children: [
              const Positioned(
                child: SizedBox(
                  width: 70, // 원하는 가로 크기
                  height: 70, // 원하는 세로 크기
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/q.jpg'),
                  ),
                ),
              ),
              const Positioned(
                top: 80, // 원하는 세로 위치
                left: 20, // 원하는 가로 위치
                child: Text(
                  '환영합니다.',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Positioned(
                top: 105, // 원하는 세로 위치
                left: 20, // 원하는 가로 위치
                child: Text(
                  '${authManager.isLoggedIn ? authManager.username : ''}님',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Positioned(
                bottom: 30,
                right: 20,
                child: GestureDetector(
                  onTap: () {
                    if (authManager.isLoggedIn) {
                      // 로그아웃 로직 추가
                      authManager.setLoggedIn(false);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('로그아웃 되었습니다.'),
                        ),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()),
                      );
                    } else {
                      // 로그인 화면으로 이동
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    }
                  },
                  child: Container(
                    width: 65,
                    height: 35,
                    padding: const EdgeInsets.all(7.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          authManager.isLoggedIn ? 'logout' : 'login',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text('홈'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.play_arrow),
          title: const Text('마이페이지'),
          onTap: () {
            if (authManager.isLoggedIn) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Myfestival()),
              );
            } else {
              // 추가: 로그인이 되어 있지 않으면 다이얼로그 표시
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('알림'),
                    content: const Text('로그인이 필요합니다.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('확인'),
                      ),
                    ],
                  );
                },
              );
            }
          },
        ),
        // ListTile(
        //   leading: const Icon(Icons.play_arrow),
        //   title: const Text('내 축제'),
        //   onTap: () {
        //     if (authManager.isLoggedIn) {
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(builder: (context) => const Myfestival()),
        //       );
        //     } else {
        //       // 추가: 로그인이 되어 있지 않으면 다이얼로그 표시
        //       showDialog(
        //         context: context,
        //         builder: (BuildContext context) {
        //           return AlertDialog(
        //             title: const Text('알림'),
        //             content: const Text('로그인이 필요합니다.'),
        //             actions: [
        //               TextButton(
        //                 onPressed: () {
        //                   Navigator.of(context).pop();
        //                 },
        //                 child: const Text('확인'),
        //               ),
        //             ],
        //           );
        //         },
        //       );
        //     }
        //   },
        // ),
        ListTile(
          leading: const Icon(Icons.play_arrow),
          title: const Text('내 축제 추가'),
          onTap: () {
            if (authManager.isLoggedIn) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InputScreen()),
              );
            } else {
              // 추가: 로그인이 되어 있지 않으면 다이얼로그 표시
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('알림'),
                    content: const Text('로그인이 필요합니다.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('확인'),
                      ),
                    ],
                  );
                },
              );
            }
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('설정'),
          onTap: () {
            // '설정' 탭 시 처리할 로직 추가
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingScreen()),
            );
          },
        ),
      ],
    ),
  );
}
