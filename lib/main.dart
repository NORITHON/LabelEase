import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth_service.dart';
import 'firebase_options.dart';
import 'home_page.dart';
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
          bodyLarge: TextStyle(fontSize: 17.0, fontFamily: "NotoSansKR"),
          bodyMedium: TextStyle(fontSize: 16.0, fontFamily: "NotoSansKR"),
          bodySmall: TextStyle(fontSize: 14.0, fontFamily: "NotoSansKR"),
        ),
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
