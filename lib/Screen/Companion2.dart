import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:ui';
import './mypage.dart';
import './Recommend.dart';
import './Home.dart';
import './Companion.dart';

class CompanionScreen2 extends StatefulWidget {
  final int imageIndex;
  final Map<String, dynamic> festival;

  const CompanionScreen2({
    Key? key,
    required this.imageIndex,
    required this.festival,
  }) : super(key: key);

  @override
  _CompanionScreen2State createState() => _CompanionScreen2State();
}

class _CompanionScreen2State extends State<CompanionScreen2> {
  final TextEditingController _meetingNameController = TextEditingController();
  final TextEditingController _numberOfPeopleController =
      TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _hashTagsController = TextEditingController();
  final TextEditingController _meetingContentController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false, // 여기로 이동
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back,
                color: Colors.white), // 백 버튼 색상을 흰색으로 설정
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.black, // AppBar 배경색을 검정으로 설정
        ),
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Positioned(
                  top: 10.0,
                  left: 10.0,
                  child: Text(
                    '동행 모집',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
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
                const SizedBox(height: 16.0),
                TextField(
                  controller: _meetingNameController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: '모임 이름',
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
                  controller: _meetingContentController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: '모집 내용',
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
                  controller: _dateController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: '날짜',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                // 나머지 TextField 및 나머지 위젯들 추가

                const SizedBox(height: 32.0),
                ElevatedButton(
                  onPressed: () async {
                    if (_meetingNameController.text.isEmpty ||
                        _dateController.text.isEmpty ||
                        _meetingContentController.text.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('알림'),
                          content: const Text('입력 항목이 비어있습니다. 전부 입력해주세요.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('확인'),
                            ),
                          ],
                        ),
                      );
                    } else {
                      final response = await http.post(
                        Uri.parse(
                            'http://ceprj.gachon.ac.kr:60040/api/companion/make'),
                        body: {
                          'name': _meetingNameController.text,
                          'date': _dateController.text,
                          'content': _meetingContentController.text,
                        },
                      );

                      if (response.statusCode == 200) {
                        print('Data sent successfully');
                      } else {
                        print(
                            'Failed to send data. Status code: ${response.statusCode}');
                      }

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CompanionScreen(
                            imageIndex: widget.imageIndex,
                            festival: widget.festival,
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    padding: const EdgeInsets.all(12),
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                  ),
                  child: const Text(
                    '모집 만들기',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                ),
                const SizedBox(height: 32.0),
              ],
            ),
          ),
        ),
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
            onTap: (index) {
              if (index == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RecommendPage(),
                  ),
                );
              } else if (index == 1) {
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
        )));
  }
}
























// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:ui';
// import './mypage.dart';
// import './Recommend.dart';
// import './Home.dart';
// import './Companion.dart';

// class CompanionScreen2 extends StatefulWidget {
//   final int imageIndex;
//   final Map<String, dynamic> festival;

//   const CompanionScreen2({
//     Key? key,
//     required this.imageIndex,
//     required this.festival,
//   }) : super(key: key);

//   @override
//   _CompanionScreen2State createState() => _CompanionScreen2State();
// }

// class _CompanionScreen2State extends State<CompanionScreen2> {
//   final TextEditingController _meetingNameController = TextEditingController();
//   final TextEditingController _numberOfPeopleController =
//       TextEditingController();
//   final TextEditingController _dateController = TextEditingController();
//   final TextEditingController _hashTagsController = TextEditingController();
//   final TextEditingController _meetingContentController =
//       TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         resizeToAvoidBottomInset: false, // 여기로 이동
//         appBar: AppBar(
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back,
//                 color: Colors.white), // 백 버튼 색상을 흰색으로 설정
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//           backgroundColor: Colors.black, // AppBar 배경색을 검정으로 설정
//         ),
//         backgroundColor: Colors.black,
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Positioned(
//                   top: 10.0,
//                   left: 10.0,
//                   child: Text(
//                     '동행 모집',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 24.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   top: 100.0,
//                   left: 10.0,
//                   child: Hero(
//                     tag: 'image${widget.imageIndex}',
//                     child: Material(
//                       color: Colors.transparent,
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(12.0),
//                         child: Image.network(
//                           widget.festival['Image'],
//                           fit: BoxFit.cover,
//                           width: 200.0,
//                           height: 200.0,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 16.0),
//                 TextField(
//                   controller: _meetingNameController,
//                   style: const TextStyle(color: Colors.white),
//                   decoration: const InputDecoration(
//                     labelText: '모임 이름',
//                     labelStyle: TextStyle(color: Colors.white),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.white),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.white),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 16.0),
//                 TextField(
//                   controller: _meetingContentController,
//                   style: const TextStyle(color: Colors.white),
//                   decoration: const InputDecoration(
//                     labelText: '모집 내용',
//                     labelStyle: TextStyle(color: Colors.white),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.white),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.white),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 16.0),
//                 TextField(
//                   controller: _dateController,
//                   style: const TextStyle(color: Colors.white),
//                   decoration: const InputDecoration(
//                     labelText: '날짜',
//                     labelStyle: TextStyle(color: Colors.white),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.white),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.white),
//                     ),
//                   ),
//                 ),
//                 // 나머지 TextField 및 나머지 위젯들 추가

//                 const SizedBox(height: 32.0),
//                 ElevatedButton(
//                   onPressed: () async {
//                     if (_meetingNameController.text.isEmpty ||
//                         _dateController.text.isEmpty ||
//                         _meetingContentController.text.isEmpty) {
//                       showDialog(
//                         context: context,
//                         builder: (context) => AlertDialog(
//                           title: const Text('알림'),
//                           content: const Text('입력 항목이 비어있습니다. 전부 입력해주세요.'),
//                           actions: [
//                             TextButton(
//                               onPressed: () {
//                                 Navigator.pop(context);
//                               },
//                               child: const Text('확인'),
//                             ),
//                           ],
//                         ),
//                       );
//                     } else {
//                       final response = await http.post(
//                         Uri.parse(
//                             'http://121.169.139.193:4000/api/companion/make'),
//                         body: {
//                           'name': _meetingNameController.text,
//                           'date': _dateController.text,
//                           'content': _meetingContentController.text,
//                         },
//                       );

//                       if (response.statusCode == 200) {
//                         print('Data sent successfully');
//                       } else {
//                         print(
//                             'Failed to send data. Status code: ${response.statusCode}');
//                       }

//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => CompanionScreen(
//                             imageIndex: widget.imageIndex,
//                             festival: widget.festival,
//                           ),
//                         ),
//                       );
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12.0),
//                     ),
//                     padding: const EdgeInsets.all(12),
//                     foregroundColor: Colors.black,
//                     backgroundColor: Colors.white,
//                   ),
//                   child: const Text(
//                     '모집 만들기',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16.0,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 32.0),
//               ],
//             ),
//           ),
//         ),
//         bottomNavigationBar: ClipRect(
//             child: DecoratedBox(
//           decoration: const ShapeDecoration(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(15),
//                 topRight: Radius.circular(15),
//               ),
//             ),
//             color: Color.fromARGB(255, 102, 101, 101), // 배경색
//           ),
//           child: BottomNavigationBar(
//             onTap: (index) {
//               if (index == 0) {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const RecommendPage(),
//                   ),
//                 );
//               } else if (index == 1) {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const HomeScreen()),
//                 );
//               } else if (index == 2) {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const MyHomePage()),
//                 );
//               }
//             },
//             backgroundColor: Colors.transparent,
//             unselectedItemColor: const Color.fromARGB(255, 176, 173, 173),
//             selectedItemColor: Colors.white,
//             items: const [
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.star),
//                 label: '축제 추천',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.home),
//                 label: 'Home',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.person),
//                 label: '마이페이지',
//               ),
//             ],
//           ),
//         )));
//   }
// }
