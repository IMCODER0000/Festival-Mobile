// // detail2.dart

// import 'package:flutter/material.dart';
// import 'dart:ui';
// import 'Recommend.dart';
// import 'Home.dart';
// import 'Companion.dart';
// import 'Companion2.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import './mypage.dart';


// class Detail2Screen extends StatelessWidget {
//   final int imageIndex;
 

//   const Detail2Screen({
//     super.key,
//     required this.imageIndex,
  
//   });


//      @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           color: Colors.white,
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => const HomeScreen()),
//             );
//           },
//         ),
//       ),
//       body: CustomScrollView(
//         slivers: <Widget>[
//           SliverList(
//             delegate: SliverChildListDelegate(
//               [
//                 Container(
//                   decoration: const BoxDecoration(
//                     image: DecorationImage(
//                       image: AssetImage("assets/a.jpg"),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 BackdropFilter(
//                   filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
//                   child: Container(
//                     color: Colors.black.withOpacity(0.5),
//                   ),
//                 ),
//                 Positioned(
//                   top: 20.0,
//                   left: 10.0,
//                   child: Hero(
//                     tag: 'image$imageIndex',
//                     child: Material(
//                       color: Colors.transparent,
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(12.0),
//                         child: Image.asset(
//                            'assets/F/$imageIndex.jpg',
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 15),
//                 Positioned(
//                   top: 20.0,
//                   right: 20.0,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       _showCompanionOptionsDialog(context);
//                     },
//                     style: ElevatedButton.styleFrom(
//                       foregroundColor: Colors.black,
//                       backgroundColor: Colors.white,
//                     ),
//                     child: const Text('동행 찾기'),
//                   ),
//                 ),
//                 const SizedBox(height: 25),
//                   Positioned(
//             top: 330.0,
//             left: 20.0,
//             child: Container(
//               padding: const EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 color: Colors.transparent,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     '축제명',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 15),
//                   const Text(
//                     '위치 : ',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 14,
//                     ),
//                   ),
//                   const Text(
//                     '날짜 : ',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 14,
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   const Text(
//                     '홈페이지 ',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 14,
//                     ),
//                   ),
//                   const SizedBox(height: 15),
//                   Container(
//                     width: 360,
//                     height: 150,
//                     decoration: BoxDecoration(
//                       // 박스 스타일 설정
//                       border: Border.all(color: Colors.white), // 테두리 설정
//                       borderRadius: BorderRadius.circular(5), // 테두리의 굴곡 설정
//                     ),
//                     padding: const EdgeInsets.all(10), // 내부 여백 설정
//                     child: const Text(
//                       '이미지에 대한 자세한 설명이 여기에 들어갑니다. 이미지에 대한 자세한 설명이 여기에 들어갑니다.',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 14,
//                       ),
//                       overflow: TextOverflow.visible, // 텍스트가 오버플로우될 때 처리 방식
//                     ),
//                   ),
//                   const SizedBox(height: 30),
//                 ],
//               ),
//             ),
//           ),
//           Positioned(
//             top: 30.0,
//             left: 0.0,
//             child: Builder(
//               builder: (context) => ElevatedButton(
//                 onPressed: () {
//                   Scaffold.of(context).openDrawer();
//                 },
//                 style: ElevatedButton.styleFrom(
//                   foregroundColor: Colors.white,
//                   backgroundColor: Colors.transparent,
//                 ),
//                 child: SvgPicture.string(
//                   '''
//                     <svg fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
//                       <path stroke-linecap="round" stroke-linejoin="round" d="M3.75 6.75h16.5M3.75 12h16.5m-16.5 5.25h16.5"></path>
//                     </svg>
//                   ''',
//                   width: 30,
//                   height: 30,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//           )
//         ]
//       ),
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: <Widget>[
//             UserAccountsDrawerHeader(
//               currentAccountPicture: Stack(
//                 children: [
//                   const CircleAvatar(
//                     backgroundImage: AssetImage('assets/q.jpg'),
//                   ),
//                   Positioned(
//                     bottom: 0,
//                     right: 8,
//                     child: GestureDetector(
//                       onTap: () {
//                         // 로그인 버튼을 클릭할 때 처리할 로직 추가
//                       },
//                       child: Container(
//                         padding: const EdgeInsets.all(5.0),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           color: Colors.white,
//                         ),
//                         child: const Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             SizedBox(width: 5.0),
//                             Text(
//                               'login',
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 12,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               accountName: const Text('User'),
//               accountEmail: const Text(''),
//               decoration: const BoxDecoration(
//                 color: Colors.grey,
//                 borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(30.0),
//                   bottomRight: Radius.circular(30.0),
//                 ),
//               ),
//             ),
//             ListTile(
//               leading: const Icon(Icons.home),
//               title: const Text('홈'),
//               onTap: () {
//                 // '홈' 탭 시 처리할 로직 추가
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const HomeScreen()),
//                 );
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.play_arrow),
//               title: const Text('마이페이지'),
//               onTap: () {
//                 // 추가적인 탭 시 처리할 로직 추가
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.play_arrow),
//               title: const Text('내 축제'),
//               onTap: () {
//                 // 추가적인 탭 시 처리할 로직 추가
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.settings),
//               title: const Text('설정'),
//               onTap: () {
//                 // '설정' 탭 시 처리할 로직 추가
//               },
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: ClipRect(
//         child: DecoratedBox(
//           decoration: const ShapeDecoration(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(15),
//                 topRight: Radius.circular(15),
//               ),
//             ),
//             color: Color.fromARGB(255, 136, 113, 113), // 배경색
//           ),
//           child: BottomNavigationBar(
//             // currentIndex: _currentIndex,
//             onTap: (index) {
//               if (index == 0) {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => const RecommendPage()),
//                 );
//               } else if (index == 1) {
//                 // 이동할 페이지로 변경 (예: RecommendPage)
//               } else if (index == 2) {
//                 // 마이페이지로 이동하도록 변경
//                 // _currentScreen = const MyPageScreen();
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const MyHomePage()),
//                 );
//               }
//             },
//             backgroundColor: Colors.transparent,
//             unselectedItemColor: const Color.fromARGB(
//                 255, 176, 173, 173), // 선택되지 않은 아이콘과 텍스트의 색상
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
//         ),
//       ),
//     );
//   }

//   _showCompanionOptionsDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16.0),
//           ),
//           title: const Text('동행 찾기'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.pop(context); // 닫기
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) =>
//                           CompanionScreen(imageIndex: imageIndex),
//                     ),
//                   );
//                 },
//                 style: ElevatedButton.styleFrom(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12.0),
//                   ),
//                   padding: const EdgeInsets.all(12),
//                   foregroundColor: Colors.black,
//                   backgroundColor: Colors.white,
//                 ),
//                 child: const Text('동행 참가'),
//               ),
//               const SizedBox(height: 10),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.pop(context); // 닫기
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) =>
//                           CompanionScreen2(imageIndex: imageIndex),
//                     ),
//                   );
//                 },
//                 style: ElevatedButton.styleFrom(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12.0),
//                   ),
//                   padding: const EdgeInsets.all(12),
//                   foregroundColor: Colors.black,
//                   backgroundColor: Colors.white,
//                 ),
//                 child: const Text('동행 모집'),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }