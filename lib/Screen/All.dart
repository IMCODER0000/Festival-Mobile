import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'dart:convert';

import './detail.dart';

class AllScreen extends StatefulWidget {
  const AllScreen({Key? key}) : super(key: key);

  @override
  _AllScreenState createState() => _AllScreenState();
}

class _AllScreenState extends State<AllScreen> {
  List<Map<String, dynamic>> festivals = [];

  @override
  void initState() {
    super.initState();
    fetchFestivals();
  }

  void fetchFestivals() async {
    try {
      final response =
          await http.get(Uri.parse('http://14.35.239.82:4000/api/festival'));

      if (response.statusCode == 200) {
        final List<dynamic> decodedData = json.decode(response.body);

        setState(() {
          festivals = List<Map<String, dynamic>>.from(decodedData);
        });
        print(festivals);
      } else {
        print('Failed to load festivals. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching festivals: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
        child: Padding(
      padding: const EdgeInsets.only(
          top: 16.0, left: 16.0, right: 16.0, bottom: 16.0), // 여기에서 top을 조절
      child: Column(
        children: [
          Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
              ),
              itemCount: festivals.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(_createRoute(festivals[index], index: index + 1));
                  },
                  child: Hero(
                    tag: 'image${festivals[index]['id']}',
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Image.network(
                          festivals[index]['Image'],
                          fit: BoxFit.cover,
                          errorBuilder: (BuildContext context, Object error,
                              StackTrace? stackTrace) {
                            print('Error loading image: $error');
                            print(stackTrace);
                            return const Text('Failed to load image');
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 120.0), // 여기에 원하는 여백을 추가하세요
        ],
      ),
    ));
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
