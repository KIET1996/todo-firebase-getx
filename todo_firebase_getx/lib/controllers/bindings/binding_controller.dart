import 'package:get/get.dart';
import 'package:todo_firebase_getx/controllers/user_controller.dart';

import '../auth_controller.dart';

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController(), permanent: true);
    Get.put(UserController());

  }
}