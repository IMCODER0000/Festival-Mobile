import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Screen/Logo.dart';
import './AuthManager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthManager().init();

  // AuthManager 초기화
  AuthManager authManager = AuthManager();
  await authManager.init();

  runApp(
    ChangeNotifierProvider(
      create: (context) => authManager,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LogoScreen(),
    );
  }
}
