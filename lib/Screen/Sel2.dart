import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './Home.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Sel2Screen extends StatefulWidget {
  final List<int> selectedIds;

  const Sel2Screen({Key? key, required this.selectedIds}) : super(key: key);

  @override
  _SelScreenState createState() => _SelScreenState(); // 클래스 이름 수정
}

class _SelScreenState extends State<Sel2Screen> {
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
          await http.get(Uri.parse('http://14.35.239.82:4000/api/sel2'));

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
      // 로딩 다이얼로그를 띄우기
      showLoadingDialog();

      // 선택된 이미지의 id를 selectedIds1, selectedIds2에 저장
      List<int> selectedIds1 = [];
      List<int> selectedIds2 = [];

      for (int index in selectedIndices) {
        print('Selected Index: $index');
        print('widget.selectedIds length: ${widget.selectedIds.length}');
        print('festivals length: ${festivals.length}');

        if (index >= 0 &&
            index < widget.selectedIds.length &&
            index < festivals.length) {
          selectedIds1.add(widget.selectedIds[index]);
          selectedIds2.add(festivals[index]['id']);
        } else {
          print('Invalid index: $index');
        }
      }

      // 서버에 데이터 전송
      sendToServer(selectedIds1, selectedIds2);

      // 3초 후에 다이얼로그를 닫고 HomeScreen으로 이동
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pop(context); // 다이얼로그 닫기
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      });
    } else {
      print('Select 1 to 2 images.');
    }
  }

  void sendToServer(List<int> selectedIds1, List<int> selectedIds2) async {
    try {
      // 서버에 데이터를 전송할 URL 설정
      final Uri url = Uri.parse(
          'http://14.35.239.82:4000/api/selInput'); // TODO: 실제 서버 API의 URL로 변경

      // HTTP 요청을 보내기 위한 데이터 구성
      Map<String, dynamic> requestData = {
        'selectedIds1': selectedIds1,
        'selectedIds2': selectedIds2,
        // 추가로 전송해야 할 데이터가 있다면 여기에 추가
      };

      // HTTP POST 요청 보내기
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestData),
      );

      if (response.statusCode == 200) {
        // 성공적으로 서버에 데이터를 전송한 경우
        print('Data sent successfully!');
      } else {
        // 서버에 데이터 전송 실패
        print(
            'Failed to send data to server. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      // 오류 발생
      print('Error sending data to server: $e');
    }
  }

  void showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // 다이얼로그 외부 터치로 닫히지 않도록 설정
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SpinKitFadingCube(
                color: Colors.blue, // 로딩 애니메이션의 색상
                size: 50.0, // 로딩 애니메이션의 크기
              ),
              SizedBox(height: 20),
              Text('분석 중입니다...'),
            ],
          ),
        );
      },
    );
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
