import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/project_service.dart';
import 'package:provider/provider.dart';

import 'auth_service.dart';
import 'firebase_options.dart';

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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    authService.signIn;
    return Scaffold(
      body: Center(
        child: Consumer<ProjectService>(builder: (context, projectService, _) {
          return FutureBuilder<QuerySnapshot>(
              future: projectService.read(),
              builder: (context, snapshot) {
                final docs = snapshot.data?.docs ?? [];
                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final doc = docs[index];
                    String name = doc.get('name');
                    String field = doc.get('field');
                    String annotation = doc.get('annotation');
                    int count = doc.get('count');
                    int reward = doc.get('reward');
                    return ListTile(
                      title: Text(name),
                      subtitle: Row(
                        children: [
                          Text("$reward"),
                          Text(annotation),
                        ],
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              insetPadding:
                                  const EdgeInsets.fromLTRB(0, 80, 0, 80),
                              actions: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('시작'),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                              content: Column(
                                children: [
                                  Text(name),
                                  Text("$count"),
                                  Text(field),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                );
              });
        }),
      ),
    );
  }
}
