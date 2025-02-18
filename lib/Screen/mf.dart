import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import './Home.dart';
import './Input.dart';
import '../AuthManager.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthManager(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Myfestival(),
    );
  }
}

class MyPage {
  List<String> posts = [];

  void addPost(String post) {
    posts.add(post);
  }
}

class Myfestival extends StatefulWidget {
  const Myfestival({
    super.key,
  });

  @override
  _MyfestivalState createState() => _MyfestivalState();
}

class _MyfestivalState extends State<Myfestival> {
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _interestsController = TextEditingController();
  File? _image;
  int currentIndex = 1;
  late AuthManager authManager; // authManager를 선언
  List<Map<String, dynamic>> post = []; // 추가: 축제 목록을 저장할 리스트

  void fetchFestivals() async {
    try {
      final response = await http.get(Uri.parse(
          'http://121.169.139.193:4000/api/post/${authManager.userId}'));
      print(authManager.userId);

      if (response.statusCode == 200) {
        final List<dynamic> decodedData = json.decode(response.body);

        setState(() {
          post = List<Map<String, dynamic>>.from(decodedData);
        });
        print(post);
      } else {
        print('Failed to load festivals. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching festivals: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    authManager = Provider.of<AuthManager>(context, listen: false);
    fetchFestivals(); // 위에서 정의한 함수를 initState에서 호출
  }

  @override
  Widget build(BuildContext context) {
    authManager = Provider.of<AuthManager>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // 배경 이미지 설정
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/a.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        // 이미지에 블러 효과 적용
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(
            color: Colors.black.withOpacity(0.5),
          ),
        ),
        // 뒤로 가기 버튼
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // 양쪽 끝에 정렬
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 0.0, left: 10.0),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0, right: 10),
              child: GestureDetector(
                onTap: () {
                  // 이미지를 눌렀을 때 처리할 내용
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
                child: Image.asset(
                  'assets/b.jpg',
                  width: 100, // 이미지의 너비 조절
                  height: 100, // 이미지의 높이 조절
                ),
              ),
            ),
          ],
        ),
        // 사용자 정보 및 프로필 수정 버튼
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const SizedBox(width: 10.0),
                  // 사용자 이미지 (왼쪽 상단 정렬)
                  GestureDetector(
                    onTap: () {
                      _getImage(context);
                    },
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: _image != null
                          ? FileImage(_image!)
                          : const AssetImage('assets/q.jpg')
                              as ImageProvider<Object>,
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  // 사용자 정보 (사용자 닉네임 및 관심 분야)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        authManager.Nickname,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        authManager.username,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // 버튼 (가운데 정렬)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 프로필 수정 버튼
                  ElevatedButton(
                    onPressed: () {
                      // 프로필 수정 다이얼로그 함수 호출
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                    ),
                    child: const Text('프로필 수정'),
                  ),
                  const SizedBox(width: 20), // 간격 조절
                  // 게시물 수정 버튼
                  ElevatedButton(
                    onPressed: () {
                      // 게시물 관리 로직 추가
                      _showPostManagementDialog(context);
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                    ),
                    child: const Text('게시물 관리'),
                  ),
                ],
              ),
            ],
          ),
        ),
        // 스크롤 가능한 이미지 목록
        Expanded(
            child: SingleChildScrollView(
                child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
          ),
          itemCount: post.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // Navigator.of(context)
                //     .push(_createRoute(post[index], index: index + 1));
              },
              child: Hero(
                tag: 'image${post[index]['id']}',
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.network(
                      post[index]['image'],
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
        ))),
      ]),
    );
  }

  Widget _buildImage(String imagePath) {
    return Container(
      width: 120.0,
      height: 120.0,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(15.0),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(imagePath),
        ),
      ),
    );
  }

  // 프로필 수정 다이얼로그를 띄우는 함수

  void _handleSaveProfile(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('프로필이 성공적으로 저장되었습니다.'),
      ),
    );
  }

  // 이미지를 가져오는 메서드
  Future<void> _getImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('이미지를 선택하지 않았습니다.'),
          ),
        );
      }
    });
  }
}

void _showEditPostDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.black, // 다이얼로그의 배경색을 검은색으로 설정
        title: const Text(
          '게시물 수정',
          style: TextStyle(color: Colors.white), // 제목 글자색을 흰색으로 설정
        ),
        content: const Text(
          '정말로 게시물을 삭제하시겠습니까?',
          style: TextStyle(color: Colors.white), // 내용 글자색을 흰색으로 설정
        ),
        actions: [
          TextButton(
            onPressed: () {
              // 확인 버튼을 눌렀을 때의 로직을 추가하세요
              // 예를 들어, 게시물 삭제 및 메시지 표시 등의 동작을 수행할 수 있습니다.
              _deletePost(); // 게시물 삭제 메서드 호출
              Navigator.of(context).pop(); // 다이얼로그 닫기
              // 추가로 수행할 로직을 여기에 작성하세요
            },
            child: const Text(
              '확인',
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () {
              // 취소 버튼을 눌렀을 때의 로직을 추가하세요
              Navigator.of(context).pop(); // 다이얼로그 닫기
              // 추가로 수행할 로직을 여기에 작성하세요
            },
            child: const Text(
              '취소',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      );
    },
  );
}

void _showPostManagementDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.black, // 다이얼로그 창 배경색을 검은색으로 변경
        title: const Text(
          '게시물 관리',
          style: TextStyle(color: Colors.white), // 글자색을 하얀색으로 변경
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                // 삭제 로직 추가
                // _deletePost();
                Navigator.of(context).pop(); // 다이얼로그 닫기
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.transparent, // 글자색을 흰색으로 설정
                side: const BorderSide(color: Colors.white), // 테두리 색상을 흰색으로 설정
              ),
              child: const Text('삭제'),
            ),
            ElevatedButton(
              onPressed: () {
                // 추가 로직 추가 (필요한 경우)
                // _addPost();
                Navigator.of(context).pop(); // 다이얼로그 닫기
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => InputScreen()), // InputScreen으로 이동
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.transparent, // 글자색을 흰색으로 설정
                side: const BorderSide(color: Colors.white), // 테두리 색상을 흰색으로 설정
              ),
              child: const Text('추가'),
            ),
          ],
        ),
      );
    },
  );
}

void _deletePost() {
  // 게시물 삭제 로직을 여기에 추가하세요
  // 예를 들어, 데이터베이스에서 해당 게시물을 삭제하거나
  // 게시물 목록에서 해당 게시물을 제거하는 등의 동작을 수행할 수 있습니다.
  // 추가로 수행할 로직을 여기에 작성하세요
  print('게시물이 삭제되었습니다.');
}
