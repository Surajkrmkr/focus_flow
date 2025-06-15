import 'package:flutter/material.dart';
import 'package:focus_flow/presentation/controllers/export.dart';
import 'package:focus_flow/presentation/widgets/export.dart';
import 'package:get/get.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  final SignupController controller = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('images/icon.png', height: 80),
            SizedBox(height: 30),
            Form(
              key: controller.formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: _buildFormBody(),
            ),
          ],
        ),
      ),
    );
  }

  Column _buildFormBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomTextField(
          label: 'Email',
          controller: controller.emailController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Email is required';
            }
            if (!GetUtils.isEmail(value)) {
              return 'Enter a valid email';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        PasswordField(
          controller: controller.passwordController,
          isObscure: controller.isPasswordHidden,
          onToggle: controller.togglePasswordVisibility,
        ),
        const SizedBox(height: 24),
        PrimaryButton(label: 'Sign Up', onPressed: controller.signUp),
      ],
    );
  }
}
