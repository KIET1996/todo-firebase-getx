import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_firebase_getx/controllers/auth_controller.dart';
import 'package:todo_firebase_getx/pages/signup_page.dart';

class SignInPage extends GetWidget<AuthController> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign In"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: "Email"
                ),
              ),
              const SizedBox(height: 30,),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                    hintText: "Password"
                ),
              ),
              const SizedBox(height: 32,),
              ElevatedButton(
                child: const Text("Sign In"),
                onPressed: (){},
              ),
              const SizedBox(height: 20,),
              TextButton(
                onPressed: () => {Get.to(SignUpPage())},
                child: const Text("Sign Up")
              ),
            ],
          ),
        ),
      ),
    );
  }
}
