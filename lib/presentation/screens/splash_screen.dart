import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:focus_flow/data/services/export.dart';
import 'package:focus_flow/presentation/screens/export.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Future<void> _initApp() async {
    await Future.delayed(const Duration(seconds: 2));
    final isFirstTime = await LocalStorageService.isFirstTime();
    final user = FirebaseAuth.instance.currentUser;

    if (isFirstTime) {
      Get.offAll(() => LoginScreen());
    } else if (user != null) {
      Get.offAll(() => HomeScreen());
    } else {
      Get.offAll(() => LoginScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    Future.microtask(() => _initApp());
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
