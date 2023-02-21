import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'service/auth_service.dart';
import 'firebase_options.dart';
import 'page/home_page.dart';
import 'service/project_service.dart';

final AuthService authService = AuthService();

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // main 함수에서 async 사용하기 위함
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  authService.signIn(email: 'admin@handong.ac.kr', password: '123456');
  runApp(
    ChangeNotifierProvider(
      create: (context) => ProjectService(),
      builder: (context, _) => const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: const TextTheme(
          bodySmall: TextStyle(
              fontSize: 14.0,
              fontFamily: "Pretendard-Regular",
              color: Color(0xFF9E9E9E)),
          bodyMedium: TextStyle(
              fontSize: 20.0,
              fontFamily: "Pretendard-Medium",
              color: Color(0xFF9E9E9E)),
          bodyLarge: TextStyle(
              fontSize: 22.0,
              fontFamily: "Pretendard-Bold",
              color: Color(0xFF9E9E9E)),
          displaySmall: TextStyle(
              fontSize: 14.0,
              fontFamily: "NanumSquareNeo-aLt",
              color: Colors.black),
          displayMedium: TextStyle(
              fontSize: 20.0,
              fontFamily: "NanumSquareNeo-cBd",
              color: Colors.black),
          displayLarge: TextStyle(
              fontSize: 22.0,
              fontFamily: "NanumSquareNeo-eHv",
              color: Colors.black),
        ),
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF6D3DD2),
      ),
      home: const HomePage(),
    );
  }
}
