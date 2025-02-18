// Home.dart

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import './Area.dart';
import './Date.dart';
import 'dart:ui';
import 'a_choice.dart';
import 'd_choice.dart';
import './Recommend.dart';
import './mypage.dart';
import './F_Input.dart';
import 'package:intl/intl.dart';
import './drawer.dart';
import './All.dart';
import './Input.dart';
import './Sel.dart';
import './mf.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Widget _currentScreen;
  String buttonText = '지역선택';
  DateTimeRange? selectedDateRange;
  String selectedDistrict = '';
  String selectedCity = '';

  @override
  void initState() {
    super.initState();
    // 초기에 보여질 화면 설정
    _currentScreen = const AllScreen(); // 변경된 부분
    buttonText = '전체'; // 변경된 부분
  }

  String getSelectedAreaText() {
    if (_currentScreen is AChoiceScreen) {
      // AChoiceScreen에서 선택된 지역 가져오는 논리
      return 'AChoiceScreen에서 선택된 지역';
    } else {
      // 다른 경우 처리하거나 기본값 반환
      return '지역이 선택되지 않았습니다';
    }
  }

  Widget _buildSelectedArea() {
    final selectedAreaText = getSelectedAreaText();
    return Text(
      '지역 : $selectedDistrict ${selectedCity.isNotEmpty ? '- $selectedCity' : ''}',
      style: const TextStyle(color: Colors.white),
    );
  }

  // DChoiceScreen에서 날짜를 선택한 후 호출될 함수
  void onDateRangeSelected(DateTimeRange dateRange) {
    setState(() {
      selectedDateRange = dateRange;
    });
  }

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

          // '안녕하세요' 텍스트
          Positioned(
            top: 10,
            right: 10,
            child: Image.asset(
              'assets/b.jpg',
              width: 100, // 이미지의 너비 조절
              height: 100, // 이미지의 높이 조절
            ),
          ),

          // 아바타 위젯
          Positioned(
            top: 120.0,
            left: 30.0,
            child: CircleAvatar(
              radius: 40,
              backgroundImage: const AssetImage('assets/q.jpg'),
              child: GestureDetector(
                onTap: () {
                  // 추가적인 탭 시 처리할 로직 추가
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SelScreen()),
                  );
                }, // 버튼이 클릭되었을 때 실행되는 코드 작성

                child: Container(
                  width: 65, // 버튼의 너비
                  height: 65, // 버튼의 높이
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue, // 버튼의 배경색
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.add, // 아이콘 변경 가능
                      color: Colors.white, // 아이콘 색상 변경 가능
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Positioned(
            top: 120.0, // 아바타의 하단 여백 조절
            right: 200.0, // 아바타의 우측 여백 조절
            child: CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/q.jpg'),
            ),
          ),
          const Positioned(
            top: 120.0, // 아바타의 하단 여백 조절
            right: 100.0, // 아바타의 우측 여백 조절
            child: CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/q.jpg'),
            ),
          ),

          // 버튼을 맨 왼쪽 맨 위에 위치시키기
          Positioned(
            top: 30.0, // 버튼의 상단 여백
            left: 0.0, // 버튼의 좌측 여백
            child: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  // 버튼이 클릭되었을 때 실행되는 코드 작성
                  Scaffold.of(context).openDrawer(); // Drawer 열기
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.transparent,
                ),
                child: SvgPicture.string(
                  '''
                      <svg fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M3.75 6.75h16.5M3.75 12h16.5m-16.5 5.25h16.5"></path>
                      </svg>
                    ''',
                  width: 30,
                  height: 30,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          // 가운데 정렬된 버튼들
          // 초기값 설정

          // ...

          Stack(
            children: [
              Positioned(
                top: 230.0,
                left: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _currentScreen = const AllScreen(); // 변경된 부분
                          buttonText = '전체';
                          print('전체 화면으로 이동');
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.transparent,
                        side: BorderSide(
                          color: _currentScreen is AllScreen
                              ? Colors.white
                              : Colors.transparent,
                          width: 2.0,
                        ),
                      ),
                      child: const Text('전체'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _currentScreen = AreaScreen(
                            selectedDistrict:
                                '${selectedDistrict.isNotEmpty ? selectedDistrict : ''} ${selectedCity.isNotEmpty ? '- $selectedCity' : ''}',
                            selectedCity: '',
                          );
                          buttonText = '지역 선택';
                          print('지역 선택 화면으로 이동');
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.transparent,
                        side: BorderSide(
                          color: _currentScreen is AreaScreen
                              ? Colors.white
                              : Colors.transparent,
                          width: 2.0,
                        ),
                      ),
                      child: const Text('지역별'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _currentScreen = DateScreen(
                            selectedDistrict2: selectedDateRange != null
                                ? '${DateFormat('yyyy-MM-dd').format(selectedDateRange!.start)} - ${DateFormat('yyyy-MM-dd').format(selectedDateRange!.end)}'
                                : '',
                          );
                          buttonText = '날짜 선택';
                          print('날짜 선택 화면으로 이동');
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.transparent,
                        side: BorderSide(
                          color: _currentScreen is DateScreen
                              ? Colors.white
                              : Colors.transparent,
                          width: 2.0,
                        ),
                      ),
                      child: const Text('날짜별'),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 280.0, // 오른쪽 맨 위에 위치
                right: 20.0,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end, // 오른쪽 정렬
                    children: [
                      // if (_currentScreen is DateScreen)
                      //   const Text(
                      //     '날짜 : ',
                      //     style: TextStyle(color: Colors.white),
                      //   ),
                      if (_currentScreen is DateScreen &&
                          selectedDateRange != null)
                        Text(
                          '날짜 :  ${DateFormat('yyyy-MM-dd').format(selectedDateRange!.start)} - ${DateFormat('yyyy-MM-dd').format(selectedDateRange!.end)}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      if (_currentScreen is AreaScreen) _buildSelectedArea(),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 230.0,
                right: 10.0,
                child: ElevatedButton(
                  onPressed: () async {
                    // _currentScreen 상태에 따라 텍스트를 변경하지 않도록 합니다.
                    // _currentScreen 상태 변경 시에만 buttonText 값을 변경합니다.
                    if (_currentScreen is! AreaScreen &&
                        _currentScreen is! DateScreen) {
                      buttonText = '안녕';
                    } else if (_currentScreen is AreaScreen) {
                      // 지역 선택 버튼을 눌렀을 때 AChoice.dart로 이동
                      Map<String, String>? result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AChoiceScreen()),
                      );
                      if (result != null && result.containsKey('district')) {
                        String selectedDistrict = result['district'] ?? '';
                        String selectedCity = result['city'] ?? '';

                        setState(() {
                          // 선택된 지역과 도시를 상태에 업데이트
                          this.selectedDistrict = selectedDistrict;
                          this.selectedCity = selectedCity;
                        });
                      }
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => AreaScreen(
                      //       selectedDistrict:
                      //           '${selectedDistrict.isNotEmpty ? selectedDistrict : ''} ${selectedCity.isNotEmpty ? '- $selectedCity' : ''}',
                      //       selectedCity: '',
                      //     ),
                      //   ),
                      // );
                    } else if (_currentScreen is DateScreen) {
                      // 날짜 선택 버튼을 눌렀을 때 DChoice.dart로 이동
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DChoiceScreen(
                            onDateRangeSelected: (dateRange) {
                              // 선택된 날짜를 받아와서 화면에 표시
                              setState(() {
                                selectedDateRange = dateRange;
                              });
                            },
                          ),
                        ),
                      );
                    }
                    // AChoiceScreen으로 이동하고 선택된 지역을 받아옴

                    // 선택된 지역이 있는 경우에만 처리
                  },

                  // 이제 buttonText를 표시하거나 다른 동작을 수행할 수 있습니다.

                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.transparent,
                  ),
                  child: Text(buttonText),
                ),
              ),
            ],
          ),
          // Area 또는 Date 화면을 표시하는 부분
          Positioned(
            bottom: -150.0, // 위치 조절
            left: 0.0,
            right: 0.0,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height -
                        200.0, // 아래로 무한대로 확장되도록 설정
                    child: _currentScreen,
                  ),
                  if (selectedDateRange != null)
                    Text(
                      '선택된 날짜: ${selectedDateRange!.start} - ${selectedDateRange!.end}',
                      style: const TextStyle(color: Colors.white),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
      drawer: myDrawer(context),
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
              setState(() {
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
                    MaterialPageRoute(builder: (context) => const Myfestival()),
                  );
                }
              });
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

Widget _buildSelectedDates(DateTimeRange dateRange) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        '선택된 날짜들:',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      const SizedBox(height: 8),
      Column(
        children: [
          Text(
            DateFormat('yyyy-MM-dd').format(dateRange.start),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(
            DateFormat('yyyy-MM-dd').format(dateRange.end),
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    ],
  );
}
