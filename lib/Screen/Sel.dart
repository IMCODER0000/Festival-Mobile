import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './Sel2.dart';

class SelScreen extends StatefulWidget {
  const SelScreen({Key? key}) : super(key: key);

  @override
  _SelScreenState createState() => _SelScreenState();
}

class _SelScreenState extends State<SelScreen> {
  List<Map<String, dynamic>> festivals = [];
  Set<int> selectedIndices = <int>{};

  @override
  void initState() {
    super.initState();
    fetchFestivals();
  }

  void fetchFestivals() async {
    try {
      final response =
          await http.get(Uri.parse('http://14.35.239.82:4000/api/sel'));

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

  void goToNextScreen() {
    if (selectedIndices.isNotEmpty && selectedIndices.length <= 2) {
      List<int> selectedIds = [];
      for (int index in selectedIndices) {
        selectedIds.add(festivals[index]['id']);
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Sel2Screen(selectedIds: selectedIds),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 60.0),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "본인의 취향에 가까운 이미지를 선택해주세요\n(최대: 2개)",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.all(10.0),
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 20.0,
                ),
                itemCount: festivals.length,
                itemBuilder: (context, index) {
                  final isSelected = selectedIndices.contains(index);

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          selectedIndices.remove(index);
                        } else {
                          if (selectedIndices.length < 2) {
                            selectedIndices.add(index);
                          }
                        }
                      });
                    },
                    child: AspectRatio(
                      aspectRatio: 1.0,
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: isSelected
                                    ? Colors.blue
                                    : Colors.transparent,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Hero(
                              tag: 'image${festivals[index]['id']}',
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5.0),
                                child: Image.network(
                                  festivals[index]['image'], // 이미지 URL 사용
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          if (isSelected)
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      // Next 버튼 추가
      floatingActionButton: FloatingActionButton(
        onPressed: goToNextScreen,
        backgroundColor:
            selectedIndices.isNotEmpty && selectedIndices.length <= 2
                ? Colors.blue
                : Colors.grey,
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
