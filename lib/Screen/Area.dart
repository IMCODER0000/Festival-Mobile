import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import './detail.dart';

class AreaScreen extends StatefulWidget {
  final String selectedDistrict;
  final String selectedCity;

  const AreaScreen({
    Key? key,
    required this.selectedDistrict,
    required this.selectedCity,
  }) : super(key: key);

  @override
  _AreaScreenState createState() => _AreaScreenState();
}

class _AreaScreenState extends State<AreaScreen> {
  List<Map<String, dynamic>> festivals = [];
  List<Map<String, dynamic>> filteredFestivals = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchFestivals();
  }

  Future<void> fetchFestivals() async {
    try {
      final response = await http.get(
        Uri.parse(
          'http://121.169.139.193:4000/api/festival?district=${widget.selectedDistrict}&city=${widget.selectedCity}',
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> decodedData = jsonDecode(response.body);

        setState(() {
          festivals = List<Map<String, dynamic>>.from(decodedData);
          filterFestivals();
        });
      } else {
        throw Exception('Failed to load festivals');
      }
    } catch (e) {
      print('Error fetching festivals: $e');
    }
  }

  void filterFestivals() {
    filteredFestivals = festivals
        .where((festival) =>
            festival['area']?.trim().toLowerCase() ==
            widget.selectedDistrict.trim().toLowerCase())
        .toList();

    print(festivals);
    print(widget.selectedDistrict);
    print(filteredFestivals);

    // 필터링이 완료된 후에 상태를 갱신하여 화면을 다시 그립니다.
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            color: Colors.transparent,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                    ),
                    itemCount: filteredFestivals.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(_createRoute(
                              filteredFestivals[index],
                              index: index + 1));
                        },
                        child: Hero(
                          tag: 'image${filteredFestivals[index]['id']}',
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: Image.network(
                                filteredFestivals[index]['Image'],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 150.0), // 여기에 원하는 여백을 추가하세요
              ],
            ),
          );
  }

  Route _createRoute(Map<String, dynamic> festival, {required int index}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => DetailScreen(
          imageIndex: index,
          heroTag: 'image${festival['id']}',
          festival: festival),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = 0.0;
        const end = 1.0;
        const curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        var opacityAnimation = animation.drive(tween);

        return FadeTransition(
          opacity: opacityAnimation,
          child: child,
        );
      },
    );
  }
}









//   Route createRoute(int index) {
//     return PageRouteBuilder(
//       pageBuilder: (context, animation, secondaryAnimation) => DetailScreen(
//         imageIndex: index,
//         heroTag: 'image$index',
//         festival: filteredFestivals[index],
//       ),
//       transitionsBuilder: (context, animation, secondaryAnimation, child) {
//         const begin = 0.0;
//         const end = 1.0;
//         const curve = Curves.easeInOut;

//         var tween =
//             Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

//         var opacityAnimation = animation.drive(tween);

//         return FadeTransition(
//           opacity: opacityAnimation,
//           child: child,
//         );
//       },
//     );
//   }
// }
