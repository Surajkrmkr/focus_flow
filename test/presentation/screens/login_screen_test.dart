import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:focus_flow/presentation/screens/login_screen.dart';
import 'package:focus_flow/presentation/controllers/auth_controller.dart';

void main() {
  setUp(() {
    Get.testMode = true;
    Get.put(AuthController());
  });

  testWidgets('Login screen UI and validation', (WidgetTester tester) async {
    await tester.pumpWidget(
      GetMaterialApp(home: LoginScreen()),
    );

    // Verify widgets exist
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);

    // Tap login with empty form
    await tester.tap(find.text('Login'));
    await tester.pump();

    // Expect validation error
    expect(find.text('Email is required'), findsOneWidget);
    expect(find.text('Password is required'), findsOneWidget);

    // Enter valid input
    await tester.enterText(find.byType(TextFormField).first, 'surajkarmakar2000@gmail.com');
    await tester.enterText(find.byType(TextFormField).last, 'Pass@123');

    // Tap login again
    await tester.tap(find.text('Login'));
    await tester.pump();

    // If everything passes, no error should be shown now
    expect(find.text('Email is required'), findsNothing);
  });
}
