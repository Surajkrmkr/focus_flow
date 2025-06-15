import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:focus_flow/data/models/task_model.dart';

class FirestoreService {
  final FirebaseFirestore _db;

  FirestoreService({FirebaseFirestore? firestore})
      : _db = firestore ?? FirebaseFirestore.instance;

  Future<void> addTask(String uid, TaskModel task) async {
    await _db.collection('users').doc(uid).collection('tasks').add(task.toMap());
  }

  Stream<List<TaskModel>> getTasks(String uid) {
    return _db
        .collection('users')
        .doc(uid)
        .collection('tasks')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => TaskModel.fromMap(doc.data(), doc.id))
            .toList());
  }

  Future<void> updateTask(String uid, TaskModel task) async {
    await _db.collection('users').doc(uid).collection('tasks').doc(task.id).update(task.toMap());
  }

  Future<void> deleteTask(String uid, String taskId) async {
    await _db.collection('users').doc(uid).collection('tasks').doc(taskId).delete();
  }
}
