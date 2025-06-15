import 'package:focus_flow/data/models/task_model.dart';
import 'package:focus_flow/data/services/firestore_service.dart';

class TaskRepository {
  final FirestoreService _firestoreService = FirestoreService();

  Future<void> addTask(String uid, TaskModel task) {
    return _firestoreService.addTask(uid, task);
  }

  Stream<List<TaskModel>> getTasks(String uid) {
    return _firestoreService.getTasks(uid);
  }

  Future<void> updateTask(String uid, TaskModel task) {
    return _firestoreService.updateTask(uid, task);
  }

  Future<void> deleteTask(String uid, String taskId) {
    return _firestoreService.deleteTask(uid, taskId);
  }
}
