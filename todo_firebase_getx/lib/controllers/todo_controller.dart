import 'package:get/get.dart';
import 'package:todo_firebase_getx/models/todo_model.dart';
import 'package:todo_firebase_getx/services/database.dart';
import 'package:todo_firebase_getx/controllers/auth_controller.dart';

class TodoController extends GetxController {
  Rx<List<TodoModel>> todoList = Rx<List<TodoModel>>([]);

  List<TodoModel> get todos => todoList.value;

  @override
  void onInit() {
    String uid = Get.find<AuthController>().userInfo!.uid;
    todoList
        .bindStream(Database().todoStream(uid)); //stream coming from firebase
  }
}