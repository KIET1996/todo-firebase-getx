import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_firebase_getx/controllers/auth_controller.dart';
import 'package:todo_firebase_getx/pages/signin_page.dart';
import 'package:firebase_core/firebase_core.dart';

import 'controllers/bindings/binding_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) => Get.put(AuthController()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: ControllerBinding(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SignInPage(),
    );
  }
}
