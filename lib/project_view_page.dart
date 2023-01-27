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
