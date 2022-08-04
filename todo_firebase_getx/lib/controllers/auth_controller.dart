import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_firebase_getx/controllers/user_controller.dart';


class AuthController extends GetxController{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Rxn<User> _firebaseUser = Rxn<User>();
  User? get user => _firebaseUser.value;

  @override
  onInit() {
    _firebaseUser.bindStream(_auth.authStateChanges());
  }


}