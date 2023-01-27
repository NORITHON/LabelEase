import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/project_view_page.dart';
import 'package:provider/provider.dart';

import 'auth_service.dart';
import 'firebase_options.dart';
import 'project_service.dart';

final AuthService authService = AuthService();

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // main 함수에서 async 사용하기 위함
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => ProjectService(),
      builder: (context, _) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: const TextTheme(
          bodySmall: TextStyle(
              fontSize: 14.0,
              fontFamily: "Pretendard-Regular",
              color: Color(0xFFD7D7D7)),
          bodyMedium: TextStyle(
              fontSize: 20.0,
              fontFamily: "Pretendard-Medium",
              color: Color(0xFFD7D7D7)),
          bodyLarge: TextStyle(
              fontSize: 22.0,
              fontFamily: "Pretendard-Bold",
              color: Color(0xFFD7D7D7)),
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
        primaryColor: const Color(0xFF6d3dd2),
      ),
      home: const ProjectViewPage(),
    );
  }
}
