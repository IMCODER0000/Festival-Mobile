// // test.dart
// import 'package:flutter/material.dart';
// import './detail.dart';
// import '../communication.dart';
// import 'dart:typed_data';

// class TestScreen extends StatefulWidget {
//   const TestScreen({Key? key}) : super(key: key);

//   @override
//   _TestScreenState createState() => _TestScreenState();
// }

// class _TestScreenState extends State<TestScreen> {
//   final ServerCommunication serverCommunication = ServerCommunication();

//   @override
//   void initState() {
//     super.initState();
//     _fetchFestivalData();
//   }

//   Future<void> _fetchFestivalData() async {
//     try {
//       await serverCommunication.U();
//       setState(() {});
//     } catch (e) {
//       print('Error fetching festival data: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     List<Map<String, dynamic>> festivalList =
//         serverCommunication.getFestivalList();

//     return Stack(
//       children: [
//         Container(
//           color: Colors.transparent,
//           padding: const EdgeInsets.all(16.0),
//           child: GridView.builder(
//             shrinkWrap: true,
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               crossAxisSpacing: 16.0,
//               mainAxisSpacing: 16.0,
//             ),
//             itemCount: festivalList.length,
//             itemBuilder: (context, index) {
//               return GestureDetector(
//                 onTap: () {
//                   // 여기에서 선택된 특정 축제의 상세 화면으로 이동하는 코드 추가
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(12.0),
//                     child: FutureBuilder<Uint8List?>(
//                       future: serverCommunication
//                           .getImageData(festivalList[index]['Image']),
//                       builder: (context, snapshot) {
//                         if (snapshot.connectionState == ConnectionState.done &&
//                             snapshot.hasData) {
//                           return Image.memory(
//                             snapshot.data!,
//                             fit: BoxFit.cover,
//                           );
//                         } else {
//                           // 이미지 로딩 중이거나 로딩 실패 시 대체 이미지 등을 표시할 수 있습니다.
//                           return Container(
//                             color: Colors.grey, // 대체 색 또는 이미지
//                           );
//                         }
//                       },
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

// Route _createRoute(int index, String heroTag) {
//   return PageRouteBuilder(
//     pageBuilder: (context, animation, secondaryAnimation) =>
//         DetailScreen(imageIndex: index, heroTag: heroTag),
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       const begin = 0.0;
//       const end = 1.0;
//       const curve = Curves.easeInOut;

//       var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

//       var opacityAnimation = animation.drive(tween);

//       return FadeTransition(
//         opacity: opacityAnimation,
//         child: child,
//       );
//     },
//   );
// }
