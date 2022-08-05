import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_firebase_getx/controllers/auth_controller.dart';

class SignUpPage extends GetWidget<AuthController> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                    hintText: "Full name"
                ),
              ),
              const SizedBox(height: 30,),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                    hintText: "Email"
                ),
              ),
              const SizedBox(height: 30,),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                    hintText: "Password"
                ),
              ),
              const SizedBox(height: 32,),
              ElevatedButton(
                child: const Text("Sign Up"),
                onPressed: (){
                  controller.signUp(nameController.text.trim(), emailController.text.trim(), passwordController.text);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
