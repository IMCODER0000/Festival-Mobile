import 'package:flutter/material.dart';
import './Home.dart';
import 'package:provider/provider.dart';
import 'dart:ui';

class User {
  final String name;
  final String email;

  User({required this.name, required this.email});
}

class AppSettings {
  bool pushNotificationsEnabled;
  bool locationPermissionGranted;

  AppSettings(
      {required this.pushNotificationsEnabled,
      required this.locationPermissionGranted});
}

class SettingsProvider with ChangeNotifier {
  User user = User(name: '사용자', email: 'user@example.com');
  AppSettings appSettings = AppSettings(
      pushNotificationsEnabled: true, locationPermissionGranted: false);

  bool cameraAccessEnabled = false;
  bool galleryAccessEnabled = false;

  void togglePushNotifications() {
    appSettings.pushNotificationsEnabled =
        !appSettings.pushNotificationsEnabled;
    notifyListeners();
  }

  void toggleLocationPermission() {
    appSettings.locationPermissionGranted =
        !appSettings.locationPermissionGranted;
    notifyListeners();
  }

  void toggleCameraAccess() async {
    cameraAccessEnabled = !cameraAccessEnabled;
    notifyListeners();
  }

  void toggleGalleryAccess() {
    galleryAccessEnabled = !galleryAccessEnabled;
    notifyListeners();
  }

  void changePassword(String newPassword) {
    // 비밀번호 변경 로직 추가
    // newPassword를 사용하여 비밀번호를 업데이트하고 필요한 처리를 수행합니다.
    // 예: 실제로는 서버로 새 비밀번호를 전송하거나 로컬 저장소에 저장할 수 있습니다.
    print('계정관리: $newPassword');
  }

  void deleteUserAccount() {
    // 회원탈퇴 로직 추가
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Cafe24Moyamoya', // 폰트 적용
        // 다른 테마 속성들도 설정 가능
      ),
      home: const SettingScreen(),
    );
  }
}

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 다음 라인은 SettingsProvider의 새 인스턴스를 만들기 때문에 제거합니다.
    // var settingsProvider = Provider.of<SettingsProvider>(context);

    return ChangeNotifierProvider(
      create: (context) => SettingsProvider(),
      child: Scaffold(
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

            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ),

            // '안녕하세요' 텍스트
            Positioned(
              top: 10,
              right: 10,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
                child: Image.asset(
                  'assets/b.jpg',
                  width: 100, // 이미지의 너비 조절
                  height: 100, // 이미지의 높이 조절
                ),
              ),
            ),
            // 뒤로가기 버튼
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
            Consumer<SettingsProvider>(
              builder: (context, settingsProvider, child) {
                return Padding(
                  padding: const EdgeInsets.only(
                    top: 100.0,
                    left: 16.0,
                    right: 16.0,
                    bottom: 16.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      SwitchListTile(
                        title: const Text(
                          '카메라 접근',
                          style: TextStyle(color: Colors.white),
                        ),
                        value: settingsProvider.cameraAccessEnabled,
                        onChanged: (value) {
                          settingsProvider.toggleCameraAccess();
                        },
                        tileColor: Colors.transparent,
                        activeColor: Colors.white,
                        inactiveTrackColor: Colors.grey,
                      ),
                      SwitchListTile(
                        title: const Text(
                          '갤러리 접근',
                          style:
                              TextStyle(color: Colors.white), // 텍스트 색상을 흰색으로 지정
                        ),
                        value: settingsProvider.galleryAccessEnabled,
                        onChanged: (value) {
                          settingsProvider.toggleGalleryAccess();
                        },
                        tileColor: Colors.transparent,
                        activeColor: Colors.white,
                        inactiveTrackColor: Colors.grey,
                      ),
                      SwitchListTile(
                        title: const Text(
                          'Push 알림 설정',
                          style: TextStyle(color: Colors.white),
                        ),
                        value: settingsProvider
                            .appSettings.pushNotificationsEnabled,
                        onChanged: (value) {
                          settingsProvider.togglePushNotifications();
                        },
                        tileColor: Colors.transparent,
                        activeColor: Colors.white,
                        inactiveTrackColor: Colors.grey,
                      ),
                      SwitchListTile(
                        title: const Text(
                          '위치정보 수집 동의',
                          style: TextStyle(color: Colors.white),
                        ),
                        value: settingsProvider
                            .appSettings.locationPermissionGranted,
                        onChanged: (value) {
                          settingsProvider.toggleLocationPermission();
                        },
                        tileColor: Colors.transparent,
                        activeColor: Colors.white,
                        inactiveTrackColor: Colors.grey,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          _showAnnouncementDialog(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                        child: const Text(
                          '공지사항                                                     >',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          _showHelpDialog(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                        child: const Text(
                          '도움말                                                        >',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

void _showHelpDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.black, // 배경 색상을 검은색으로 변경
        title: const Text('도움말',
            style: TextStyle(color: Colors.white)), // 제목 텍스트 색상을 흰색으로 변경
        content: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('버전 정보: 1.0.0',
                style: TextStyle(color: Colors.white)), // 텍스트 색상을 흰색으로 변경
            SizedBox(height: 10),
            Text('고객센터 이메일: gustn9025@naver.com',
                style: TextStyle(color: Colors.white)), // 텍스트 색상을 흰색으로 변경
            // 또는
            // Text('고객센터 연락처: 123-456-7890', style: TextStyle(color: Colors.white)), // 텍스트 색상을 흰색으로 변경
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('닫기',
                style: TextStyle(color: Colors.white)), // 버튼 텍스트 색상을 흰색으로 변경
          ),
        ],
      );
    },
  );
}

void _showAnnouncementDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.black,
        title: const Text('공지사항', style: TextStyle(color: Colors.white)),
        content: const Text(
          '여기에 공지사항 내용을 추가하세요.',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // 확인 버튼을 누르면 다이얼로그를 닫습니다.
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
            ),
            child: const Text('확인', style: TextStyle(color: Colors.black)),
          ),
        ],
      );
    },
  );
}
