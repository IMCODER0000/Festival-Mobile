import 'package:flutter/material.dart';
import 'dart:ui';
import './Home.dart';
import './mypage.dart';
import './drawer.dart';
import './qqq.dart';

class RecommendPage extends StatelessWidget {
  const RecommendPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(children: [
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
        // '안녕하세요' 텍스트

        Positioned(
          top: 10,
          right: 10,
          child: GestureDetector(
            onTap: () {
              // 이미지를 눌렀을 때 처리할 내용
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
        Positioned(
          top: 30.0,
          left: 0.0,
          child: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () {
                Scaffold.of(context).openDrawer(); // Drawer 열기
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.transparent,
              ),
              child: const Icon(
                Icons.menu,
                color: Colors.white,
                size: 30.0,
              ),
            ),
          ),
        ),
        const Positioned(
            top: 90, // 상단 여백 조절
            left: 20, // 좌측 여백 조절
            child: Text(
              '추천 축제',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            )),
        // 이미지 리스트를 좌우로 스크롤할 수 있는 ListView.builder
        Positioned(
          top: 120.0,
          left: 0.0,
          right: 0.0,
          bottom: 0.0,
          child: SizedBox(
            height: 000.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // 이미지를 눌렀을 때 처리할 내용
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => qqqScreen(
                    //       imageIndex: index, // 이미지의 인덱스를 전달
                    //       heroTag: 'hero_tag_$index', // 고유한 heroTag를 생성하여 전달
                    //       // 해당 이미지에 대한 축제 정보를 전달
                    //     ),
                    //   ),
                    // );
                  },
                  child: SizedBox(
                    width: 300.0,
                    height: 10.0, // 이미지 높이 조절
                    child: Container(
                      width: 500.0, // 이미지의 너비 조절
                      height: 200.0,
                      margin: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/F/G/${index + 1}.jpg',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ]),
      drawer: myDrawer(context), // drawer.dart에서 정의한 Drawer 위젯 적용
      bottomNavigationBar: ClipRect(
        child: DecoratedBox(
          decoration: const ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            color: Color.fromARGB(255, 102, 101, 101), // 배경색
          ),
          child: BottomNavigationBar(
            // currentIndex: _currentIndex,
            onTap: (index) {
              if (index == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RecommendPage()),
                );
              } else if (index == 1) {
                // 이동할 페이지로 변경 (예: RecommendPage)
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              } else if (index == 2) {
                // 마이페이지로 이동하도록 변경
                // _currentScreen = const MyPageScreen();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyHomePage()),
                );
              }
            },
            backgroundColor: Colors.transparent,
            unselectedItemColor: const Color.fromARGB(
                255, 176, 173, 173), // 선택되지 않은 아이콘과 텍스트의 색상
            selectedItemColor: Colors.white,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.star),
                label: '축제 추천',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: '마이페이지',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
