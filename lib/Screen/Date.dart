import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './detail.dart';

class DateScreen extends StatefulWidget {
  final String selectedDistrict2;

  const DateScreen({
    Key? key,
    required this.selectedDistrict2,
  }) : super(key: key);

  @override
  _DateScreenState createState() => _DateScreenState();
}

class _DateScreenState extends State<DateScreen> {
  List<Map<String, dynamic>> festivals = [];
  List<Map<String, dynamic>> filteredFestivals = [];

  @override
  void initState() {
    super.initState();
    fetchFestivals();
  }

  Future<void> fetchFestivals() async {
    try {
      final response =
          await http.get(Uri.parse('http://121.169.139.193:4000/api/festival'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          festivals = List<Map<String, dynamic>>.from(data);
        });

        filterFestivals();
      } else {
        throw Exception('Failed to load festivals');
      }
    } catch (e) {
      print('Error fetching festivals: $e');
      // 에러 처리 로직 추가 (예: 다이얼로그 표시 또는 에러 메시지 출력)
    }
  }

  void filterFestivals() {
    List<String> dateRange = widget.selectedDistrict2.split(' - ');
    DateTime startDateRange = DateTime.parse(dateRange[0]);
    DateTime endDateRange = DateTime.parse(dateRange[1]);

    print('Start Date Range: $startDateRange');
    print('End Date Range: $endDateRange');

    filteredFestivals = festivals.where((festival) {
      try {
        DateTime startDate = DateTime.parse(festival['s_date']);
        DateTime endDate = DateTime.parse(festival['e_date']);

        print('Parsed start date: $startDate');
        print('Parsed end date: $endDate');

        return (startDate.isAfter(startDateRange) &&
                startDate.isBefore(endDateRange)) ||
            (endDate.isAfter(startDateRange) && endDate.isBefore(endDateRange));
      } catch (e) {
        print('Error parsing date: $e');
        return false; // 날짜 파싱에 실패한 경우 해당 축제를 필터링하지 않음
      }
    }).toList();

    print(festivals);
    print(widget.selectedDistrict2);
    print('============================================================');
    print(filteredFestivals);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.all(16.0),
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
              itemCount: filteredFestivals.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(_createRoute(
                        filteredFestivals[index],
                        index: index + 1));
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
    );
  }

  Route _createRoute(Map<String, dynamic> festival, {required int index}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => DetailScreen(
        imageIndex: index,
        heroTag: 'image${festival['id']}',
        festival: festival,
      ),
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
