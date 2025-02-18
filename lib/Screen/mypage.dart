import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:provider/provider.dart';
import '../AuthManager.dart';
import './Recommend.dart';
import './Home.dart';
import './drawer.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthManager(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final AuthManager authManager = Provider.of<AuthManager>(context);
    print('User ID: ${authManager.userId}');

    return Scaffold(
      backgroundColor: Colors.black,
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
          Positioned(
            top: 10,
            right: 10,
            child: Image.asset(
              'assets/b.jpg',
              width: 100,
              height: 100,
            ),
          ),
          const Positioned(
            bottom: 500.0,
            left: 30.0,
            child: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('assets/q.jpg'),
            ),
          ),
          const Positioned(
            bottom: 520.0,
            left: 100.0,
            child: Text(
              '안녕 님',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Positioned(
            bottom: 480.0,
            right: 20.0,
            child: Text(
              '회원 정보 수정',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            bottom: 400.0,
            left: 50.0,
            child: Text(
              '카테고리: ${authManager.isLoggedIn ? authManager.userCategories.join(', ') : '비로그인'}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            bottom: 300.0,
            left: 50.0,
            child: Text(
              '회원 id: ${authManager.isLoggedIn ? authManager.userId : '비로그인'}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      drawer: myDrawer(context),
      bottomNavigationBar: ClipRect(
        child: DecoratedBox(
          decoration: const ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            color: Color.fromARGB(255, 102, 101, 101),
          ),
          child: BottomNavigationBar(
            onTap: (index) {
              setState(() {
                if (index == 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RecommendPage()),
                  );
                } else if (index == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                } else if (index == 2) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyHomePage()),
                  );
                }
              });
            },
            backgroundColor: Colors.transparent,
            unselectedItemColor: const Color.fromARGB(255, 176, 173, 173),
            selectedItemColor: Colors.white,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.star),
                label: '축제 추천',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: '마이페이지',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
