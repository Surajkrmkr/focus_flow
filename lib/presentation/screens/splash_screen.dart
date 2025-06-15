import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:focus_flow/data/services/local_storage_service.dart';
import 'package:focus_flow/presentation/screens/home_screen.dart';
import 'package:focus_flow/presentation/screens/login_screen.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initApp();
  }

  Future<void> _initApp() async {
    await Future.delayed(const Duration(seconds: 2));
    final isFirstTime = await LocalStorageService.isFirstTime();
    final user = FirebaseAuth.instance.currentUser;

    if (isFirstTime) {
      Get.offAll(() => const LoginScreen());
    } else if (user != null) {
      Get.offAll(() => const HomeScreen());
    } else {
      Get.offAll(() => const LoginScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}