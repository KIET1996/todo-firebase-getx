import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_firebase_getx/controllers/user_controller.dart';
import 'package:todo_firebase_getx/models/user_model.dart';
import '../pages/home_page.dart';
import '../pages/signin_page.dart';
import '../services/database.dart';


class AuthController extends GetxController{
  static AuthController instance = Get.find();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late Rx<User?> _user;
  User? get userInfo => _user.value;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(_auth.currentUser);
    _user.bindStream(_auth.userChanges());
    ever(_user, _initialStream);
  }
  _initialStream(User? user){
    if (user == null){
      Get.offAll(()=>const SignInPage());
    }
    else{
      Get.offAll(()=>const HomePage());
    }
  }

  void signUp(String name, String email, String password) async {
    try{
      await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      ).then((UserCredential? _credential) => {
        if (_credential != null){
          Database().createNewUser(_credential.user?.uid, name, _credential.user?.email!)
        }
      });
    }catch(error){
      Get.snackbar(
        "About user",
        "User message",
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        titleText: const Text(
          "Account register failed",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        messageText: Text(
          error.toString(),
          style: const TextStyle(
            color: Colors.white,
          ),
        )
      );
    }
  }
  void signIn(String email, String password) async {
    try{
      UserCredential userCre = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      Get.find<UserController>().user = await Database().getUser(userCre.user!.uid);
    }catch(error){
      Get.snackbar(
          "Login",
          "Login message",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5),
          titleText: const Text(
            "Login failed",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          messageText: const Text(
            "Email or password is wrong",
            style: TextStyle(
              color: Colors.white,
            ),
          )
      );
    }
  }
  void signOut() async {
    try{
      await _auth.signOut();
    }catch(error){
      Get.snackbar(
          "Logout",
          "Logout",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3),
          titleText: const Text(
            "Logout failed",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          messageText: Text(
            error.toString(),
            style: const TextStyle(
              color: Colors.white,
            ),
          )
      );
    }
  }
}