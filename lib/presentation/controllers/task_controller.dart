import 'package:get/get.dart';
import 'package:focus_flow/data/models/task_model.dart';
import 'package:focus_flow/data/repositories/task_repository.dart';
import 'package:focus_flow/presentation/controllers/auth_controller.dart';

class TaskController extends GetxController {
  final TaskRepository _taskRepo = TaskRepository();
  final AuthController _authController = Get.find();

  RxList<TaskModel> tasks = <TaskModel>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    final uid = _authController.currentUser.value?.uid;
    if (uid != null) {
      tasks.bindStream(_taskRepo.getTasks(uid));
    }
  }

  void loadTasks(String uid) {
    _taskRepo.getTasks(uid).listen((taskList) {
      tasks.assignAll(taskList);
    });
  }

  Future<void> addTask(TaskModel task) async {
    final uid = _authController.currentUser.value?.uid;
    if (uid == null) return;
    await _taskRepo.addTask(uid, task);
  }

  Future<void> updateTask(TaskModel task) async {
    final uid = _authController.currentUser.value?.uid;
    if (uid == null) return;
    await _taskRepo.updateTask(uid, task);
  }

  Future<void> deleteTask(String taskId) async {
    final uid = _authController.currentUser.value?.uid;
    if (uid == null) return;
    await _taskRepo.deleteTask(uid, taskId);
  }
}
