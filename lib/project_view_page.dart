import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main.dart';
import 'project_service.dart';

class ProjectViewPage extends StatefulWidget {
  const ProjectViewPage({super.key});

  @override
  State<ProjectViewPage> createState() => _ProjectViewPageState();
}

class _ProjectViewPageState extends State<ProjectViewPage> {
  @override
  Widget build(BuildContext context) {
    authService.signIn;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 200,
        elevation: 0,
        title: const Text('프로젝트 목록'),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Consumer<ProjectService>(
          builder: (context, projectService, _) {
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
                    String image = doc.get('image');
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ListTile(
                          title: Text(name),
                          subtitle: Row(
                            children: [
                              Image.asset(
                                'assets/won.png',
                                color: Colors.black,
                              ),
                              Text("$reward"),
                              const SizedBox(width: 50),
                              Image.asset(
                                'assets/pencil.png',
                                color: Colors.black,
                              ),
                              Text(annotation),
                            ],
                          ),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  insetPadding: const EdgeInsets.symmetric(
                                      vertical: 40, horizontal: 24),
                                  actions: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.deepPurple,
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('시작하기'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                  content: Column(
                                    children: [
                                      Text(name),
                                      const SizedBox(height: 20),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.network(
                                          image,
                                          height: 300,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const Text(
                                            "분량",
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          Text(" 사진 $count장  "),
                                          const Text(
                                            "분야 ",
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          Text(field),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
