import 'package:focus_flow/data/models/user_model.dart';
import 'package:focus_flow/data/repositories/auth_repository.dart';
import 'package:focus_flow/data/services/local_storage_service.dart';
import 'package:focus_flow/presentation/screens/home_screen.dart';
import 'package:focus_flow/presentation/screens/login_screen.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final AuthRepository _authRepo = AuthRepository();

  var isLoading = false.obs;
  Rxn<UserModel> currentUser = Rxn<UserModel>();

  @override
  void onInit() {
    currentUser.value = _authRepo.getCurrentUser();
    super.onInit();
  }

  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;
      final user = await _authRepo.login(email, password);
      currentUser.value = user;
      await LocalStorageService.setFirstTimeFalse();
      Get.offAll(() => HomeScreen());
    } catch (e) {
      Get.snackbar(
        'Login Failed',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      isLoading.value = true;
      final user = await _authRepo.signUp(email, password);
      currentUser.value = user;
      Get.offAll(() => HomeScreen());
    } catch (e) {
      Get.snackbar(
        'Signup Failed',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void logout() async {
    await _authRepo.logout();
    currentUser.value = null;
    await LocalStorageService.setFirstTimeFalse();
    Get.offAll(() => LoginScreen());
  }
}
