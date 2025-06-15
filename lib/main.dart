import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:focus_flow/firebase_options.dart';
import 'package:focus_flow/presentation/controllers/auth_controller.dart';
import 'package:focus_flow/presentation/screens/splash_screen.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Get.put(AuthController());
  runApp(const FocusFlowApp());
}

class FocusFlowApp extends StatelessWidget {
  const FocusFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'FocusFlow',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Poppins'),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
