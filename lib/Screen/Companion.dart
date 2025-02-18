import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './Recommend.dart';
import './Home.dart';
import './mypage.dart';
import './detail2.dart';
import 'dart:ui';

class CompanionScreen extends StatefulWidget {
  final int imageIndex;
  final Map<String, dynamic> festival;

  const CompanionScreen({
    Key? key,
    required this.imageIndex,
    required this.festival,
  }) : super(key: key);

  @override
  _CompanionScreenState createState() => _CompanionScreenState();
}

class _CompanionScreenState extends State<CompanionScreen> {
  List<Map<String, dynamic>> companions = [];
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchCompanions();
  }

  Future<void> fetchCompanions() async {
    try {
      final response = await http.get(
        Uri.parse('http://121.169.139.193:4000/api/companion'),
      );

      if (response.statusCode == 200) {
        setState(() {
          companions = List<Map<String, dynamic>>.from(
            jsonDecode(response.body),
          );
        });
      } else {
        print('Failed to load companions. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching companions: $e');
    }
  }

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
              width: 100,
              height: 100,
            ),
          ),
        ),
        Positioned(
          top: 100.0,
          left: 10.0,
          child: Hero(
            tag: 'image${widget.imageIndex}',
            child: Material(
              color: Colors.transparent,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(
                  widget.festival['Image'],
                  fit: BoxFit.cover,
                  width: 200.0,
                  height: 200.0,
                ),
              ),
            ),
          ),
        ),
        Positioned(
            top: 300.0, // companions를 표시할 위치 조절
            left: 10.0,
            right: 10.0,
            bottom: 80.0, // companions를 표시할 위치 조절
            child: ListView.builder(
                itemCount: companions.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> companion = companions[index];

                  return Container(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.transparent, // 백그라운드 컬러 투명
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(color: Colors.white), // 테두리 색상 흰색
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '모집 이름: ${companion['name']}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '날짜 : ${companion['date']}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.0,
                                        ),
                                      ),

                                      // 다른 동행자 정보를 표시하거나 인원수를 추가로 표시할 수 있습니다.
                                      // 현재는 '(인원수: )'로만 나타내어져 있습니다.
                                    ],
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    // 버튼이 클릭되었을 때 수행할 동작 추가
                                    // 예: 참가 처리 로직
                                    _showSendMessageDialog(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor:
                                        Colors.transparent, // 글자색 흰색
                                    side: const BorderSide(
                                        color: Colors.white), // 테두리 색상 흰색
                                  ),
                                  child: const Text('참가'),
                                ),
                              ],
                            ),
                            Text(
                              '내용 : ${companion['content']}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                          ]));
                })),
        Positioned(
          top: 30.0,
          left: 10.0,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Detail2Screen(
                    festival: widget.festival,
                    imageIndex: widget.imageIndex,
                  ),
                ),
              );
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 30.0,
            ),
          ),
        )
      ]),
      bottomNavigationBar: ClipRect(
        child: DecoratedBox(
          decoration: const ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            color: Color.fromARGB(255, 102, 101, 101),
          ),
          child: BottomNavigationBar(
            onTap: (index) {
              if (index == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RecommendPage(),
                  ),
                );
              } else if (index == 1) {
                // 이동할 페이지로 변경 (예: RecommendPage)

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              } else if (index == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyHomePage()),
                );
              }
            },
            backgroundColor: Colors.transparent,
            unselectedItemColor: const Color.fromARGB(255, 176, 173, 173),
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

  Future<void> _showSendMessageDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('신청 보내기'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: messageController,
                decoration: const InputDecoration(
                  hintText: '메시지를 입력하세요',
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  // 여기에 메시지 전송 로직을 추가합니다.
                  String message = messageController.text;
                  // 메시지 전송 로직을 수행하도록 추가합니다.
                  _showNotification('신청이 완료되었습니다');
                  print('메시지 전송: $message');
                  Navigator.pop(context); // 대화상자 닫기
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: const Text('신청'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showNotification(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
