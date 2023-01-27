import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProjectService extends ChangeNotifier {
  final projectCollection = FirebaseFirestore.instance.collection('project');

  Future<QuerySnapshot> read() async {
    return projectCollection.get();
  }

  void update(String projectId, String imageId, bool isSolved) async {
    projectCollection.doc(projectId).collection('images').doc(imageId);
    notifyListeners();
  }
}
