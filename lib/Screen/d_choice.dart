// d_choice.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:ui';
import './Home.dart';

class DChoiceScreen extends StatefulWidget {
  final void Function(DateTimeRange) onDateRangeSelected;

  const DChoiceScreen({Key? key, required this.onDateRangeSelected})
      : super(key: key);

  @override
  _DChoiceScreenState createState() => _DChoiceScreenState();
}

class _DChoiceScreenState extends State<DChoiceScreen> {
  DateTimeRange? _selectedDateRange;
  bool _pickingDate = false;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_pickingDate) {
        _pickingDate = true;
        _pickDateRange(context);
      }
    });

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('날짜 선택'),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/a.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (mounted) {
      // _selectedDateRange에 관련된 정리 작업 등을 수행할 수 있습니다.
    }
  }

  Future<void> _pickDateRange(BuildContext context) async {
    // 달력이 이미 열려있는 경우 또 열지 않도록 체크
    if (_selectedDateRange == null) {
      // 커스텀 다이얼로그 생성
      DateTimeRange? pickedDateRange = await showDateRangePicker(
        context: context,
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
        initialDateRange: DateTimeRange(
          start: DateTime.now(),
          end: DateTime.now().add(const Duration(days: 7)),
        ),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.dark(), // 달력이 어두운 테마로 보이도록 설정
            child: Scaffold(
              appBar: AppBar(
                title: const Text('날짜 선택'),
                backgroundColor: Colors.black,
                leading: IconButton(
                  icon: const Icon(Icons.close), // "X" 버튼 아이콘
                  onPressed: () {
                    // "X" 버튼을 눌렀을 때 홈으로 이동
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()),
                    );
                  },
                ),
              ),
              body: child!, // 기존의 달력 위젯
            ),
          );
        },
      );

      if (pickedDateRange != null) {
        setState(() {
          _selectedDateRange = pickedDateRange;
        });

        // 선택된 날짜 범위를 HomeScreen으로 전달
        widget.onDateRangeSelected(pickedDateRange);

        if (mounted) {
          Navigator.pop(context);
        }
      }

      _pickingDate = false; // 달력이 종료되면 다시 선택 가능한 상태로 변경
    }
  }
}
