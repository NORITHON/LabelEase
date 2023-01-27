import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/project_service.dart';
import 'package:provider/provider.dart';
import 'boudingPage.dart';
import 'auth_service.dart';
import 'firebase_options.dart';
import 'project_view_page.dart';
import 'image_test.dart';

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
        textTheme: TextTheme(
          // titleLarge: TextStyle(fontSize: 34.0, fontFamily: "NanumSquareNeo"),
          // titleMedium: TextStyle(fontSize: 28.0, fontFamily: "NanumSquareNeo"),
          // titleSmall: TextStyle(fontSize: 22.0, fontFamily: "NanumSquareNeo"),
          // subtitle1: TextStyle(fontSize: 20.0, fontFamily: "NanumSquareNeo"),
          bodyLarge: TextStyle(fontSize: 17.0, fontFamily: "Pretendard"),
          bodyMedium: TextStyle(fontSize: 16.0, fontFamily: "Pretendard"),
          bodySmall: TextStyle(fontSize: 14.0, fontFamily: "Pretendard"),
          labelMedium: TextStyle(fontSize: 12.0, fontFamily: "Pretendard"),
          labelSmall: TextStyle(fontSize: 10.0, fontFamily: "Pretendard"),
        ),
        primaryColor:  const Color(0xff6D3DD2)
      ),
      home: const BoundingPage(),
    );
  }
}
