// // SelScreen.dart

// import 'package:flutter/material.dart';
// import 'dart:ui';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// import './detail.dart';

// class SelScreen extends StatefulWidget {
//   const SelScreen({Key? key}) : super(key: key);

//   @override
//   _SelScreenState createState() => _SelScreenState(); // Fix class name here
// }

// class _SelScreenState extends State<SelScreen> {
//   List<Map<String, dynamic>> festivals = [];
//   Set<int> selectedIndices = <int>{};

//   @override
//   void initState() {
//     super.initState();
//     fetchFestivals();
//   }

//   void fetchFestivals() async {
//     try {
//       final response =
//           await http.get(Uri.parse('http://121.169.139.193:4000/api/sel'));

//       if (response.statusCode == 200) {
//         final List<dynamic> decodedData = json.decode(response.body);

//         setState(() {
//           festivals = List<Map<String, dynamic>>.from(decodedData);
//         });
//         print(festivals);
//       } else {
//         print('Failed to load festivals. Status Code: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error fetching festivals: $e');
//     }
//   }

//   void goToNextScreen() {
//     // 선택된 이미지가 1개 이상일 때만 다음 화면으로 이동
//     if (selectedIndices.isNotEmpty && selectedIndices.length <= 2) {
//       // 선택된 이미지들에 대한 정보를 가져오는 코드
//       List<Map<String, dynamic>> selectedFestivals = [];
//       for (int index in selectedIndices) {
//         selectedFestivals.add(festivals[index]);
//       }

//       // 여기에 다음 화면으로 이동하는 코드 추가
//       // 예: Navigator.push(...)
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(height: 60.0),
//           const Padding(
//             padding: EdgeInsets.all(10.0),
//             child: Text(
//               "본인의 취향에 가까운 이미지를 선택해주세요\n(최대: 2개)",
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 18.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           Expanded(
//             child: Container(
//               color: Colors.transparent,
//               padding: const EdgeInsets.all(10.0),
//               child: GridView.builder(
//                 shrinkWrap: true,
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   crossAxisSpacing: 20.0,
//                   mainAxisSpacing: 20.0,
//                 ),
//                 itemCount: festivals.length,
//                 itemBuilder: (context, index) {
//                   final isSelected = selectedIndices.contains(index);

//                   return GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         if (isSelected) {
//                           selectedIndices.remove(index);
//                         } else {
//                           if (selectedIndices.length < 2) {
//                             selectedIndices.add(index);
//                           }
//                         }
//                       });
//                     },
//                     child: AspectRatio(
//                       aspectRatio: 1.0,
//                       child: Stack(
//                         children: [
//                           Container(
//                             decoration: BoxDecoration(
//                               border: Border.all(
//                                 color: isSelected
//                                     ? Colors.blue
//                                     : Colors.transparent,
//                                 width: 2.0,
//                               ),
//                               borderRadius: BorderRadius.circular(5.0),
//                             ),
//                             child: Hero(
//                               tag: 'image${festivals[index]['id']}',
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(5.0),
//                                 child: Image.network(
//                                   festivals[index]['image'],
//                                   fit: BoxFit.cover,
//                                   errorBuilder: (BuildContext context,
//                                       Object error, StackTrace? stackTrace) {
//                                     print('Error loading image: $error');
//                                     print(stackTrace);
//                                     return const Text('Failed to load image');
//                                   },
//                                 ),
//                               ),
//                             ),
//                           ),
//                           if (isSelected)
//                             Container(
//                               decoration: BoxDecoration(
//                                 color: Colors.black.withOpacity(0.5),
//                                 borderRadius: BorderRadius.circular(5.0),
//                               ),
//                             ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//       // Next 버튼 추가
//       floatingActionButton: FloatingActionButton(
//         onPressed: goToNextScreen,
//         backgroundColor:
//             selectedIndices.isNotEmpty && selectedIndices.length <= 2
//                 ? Colors.blue
//                 : Colors.grey,
//         child: const Icon(Icons.arrow_forward),
//       ),
//     );
//   }
// }
