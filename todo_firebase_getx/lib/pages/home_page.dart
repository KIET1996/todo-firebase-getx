import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_firebase_getx/controllers/auth_controller.dart';
import 'package:todo_firebase_getx/controllers/user_controller.dart';
import 'package:todo_firebase_getx/controllers/todo_controller.dart';
import 'package:todo_firebase_getx/services/database.dart';
import 'package:todo_firebase_getx/pages/components/todo_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  final TextEditingController _todoController = TextEditingController();
  AuthController controller = Get.put(AuthController());
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();
    return Scaffold(
      appBar: AppBar(
        title: GetX<UserController>(
          initState: (_) async {
            Get.find<UserController>().user =
            await Database().getUser(Get.find<AuthController>().userInfo!.uid);
          },
          builder: (_) {
            if (_.user.name != null) {
              return Text("Welcome " + _.user.name);
            } else {
              return const Text("loading...");
            }
          },
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            onSelected: (item) {
              print("item selected ${item}");
              if(item == "logout"){
                controller.signOut();
              }
              if(item == "darkmode"){
                if (Get.isDarkMode) {
                  setState(() {
                    isDark = false;
                  });
                  Get.changeTheme(ThemeData.light());
                } else {
                  setState(() {
                    isDark = true;
                  });
                  Get.changeTheme(ThemeData.dark());
                }
              }
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Icon(Icons.settings),
            ),
            itemBuilder: (BuildContext bc) {
              return [
                PopupMenuItem(
                  value: "darkmode",
                  child: Row(
                      children: [
                        Icon((!isDark ? Icons.dark_mode : Icons.light_mode), color: Colors.grey,),
                        const SizedBox(width: 8.0,),
                        Text((!isDark ? "Dark" : "Light"), style: TextStyle(fontSize: 16, color: Colors.grey),),                    ]
                  ),
                ),
                PopupMenuItem(
                  value: "logout",
                  child: Row(
                      children: const[
                        Icon(Icons.logout, color: Colors.grey,),
                        SizedBox(width: 8.0,),
                        Text("Logout", style: TextStyle(fontSize: 16, color: Colors.grey),),                    ]
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          GetX<TodoController>(
            init: Get.put<TodoController>(TodoController()),
            builder: (TodoController todoController) {
              if (todoController != null && todoController.todos != null) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: todoController.todos.length,
                    itemBuilder: (_, index) {
                      return TodoCard(
                          uid: controller.userInfo!.uid,
                          todo: todoController.todos[index]);
                    },
                  ),
                );
              } else {
                return const Text("loading...");
              }
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
                  title: const Center(child: Text("New Task")),
                  content: Container(
                    width: 400,
                    height: 100,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _todoController,
                        ),
                      ],
                    ),
                  ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Close"),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.redAccent,
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (_todoController.text != "") {
                          Database()
                              .addTodo(_todoController.text, controller.userInfo!.uid);
                          _todoController.clear();
                        }
                        Navigator.of(context).pop();
                      },
                      child: const Text("Save")
                  ),
                ],
              );
            }
          );
        },
      ),
    );
  }
}
