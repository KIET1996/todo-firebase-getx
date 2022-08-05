import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_firebase_getx/controllers/auth_controller.dart';
import 'package:todo_firebase_getx/pages/signup_page.dart';
import 'package:email_validator/email_validator.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);
  @override
  State<SignInPage> createState() => _SignInPageState();
}
class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  AuthController controller = Get.put(AuthController());

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
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    hintText: "Email"
                  ),
                  validator: (value) {
                    bool isValid = EmailValidator.validate(value!);
                    if(value.isEmpty){
                      return "Email can not be blank";
                    }
                    else if (!isValid){
                      return "Email is invalid";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30,),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                      hintText: "Password"
                  ),
                  validator: (value) {
                    if(value!.isEmpty){
                      return "Password can not be blank";
                    };
                    return null;
                  }
                ),
                const SizedBox(height: 32,),
                ElevatedButton(
                  child: const Text("Sign In"),
                  onPressed: (){
                    if(_formKey.currentState!.validate()){
                      controller.signIn(emailController.text.trim(), passwordController.text);
                    }
                  },
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
      ),
    );
  }
}
