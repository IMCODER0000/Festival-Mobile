// detail.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // intl 패키지 추가
import './detail2.dart';

class DetailScreen extends StatelessWidget {
  final int imageIndex;
  final String heroTag;
  final Map<String, dynamic> festival;

  const DetailScreen({
    Key? key,
    required this.imageIndex,
    required this.heroTag,
    required this.festival,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: InkWell(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: heroTag,
                child: Material(
                  color: Colors.transparent,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.network(
                      festival['Image'],
                      fit: BoxFit.cover,
                      width: 200.0,
                      height: 200.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Container(
                width: 320.0,
                height: 200.0,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '축제명: ${festival['name']}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      '지역: ${festival['Location']}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      '시작일: ${_formatDate(festival['s_date'])}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      '종료일: ${_formatDate(festival['e_date'])}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Detail2Screen(
                        festival: festival,
                        imageIndex: imageIndex,
                      ),
                    ),
                  );
                },
                child: const Text(
                  '상세 보기',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(String dateString) {
    final DateTime dateTime = DateTime.parse(dateString);
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(dateTime);
  }
}
