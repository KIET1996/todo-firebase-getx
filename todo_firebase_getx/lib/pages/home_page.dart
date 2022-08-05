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
          IconButton(
              onPressed: (){
                controller.signOut();
              },
              icon: const Icon(Icons.logout)
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              if (Get.isDarkMode) {
                Get.changeTheme(ThemeData.light());
              } else {
                Get.changeTheme(ThemeData.dark());
              }
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Add Todo Here:",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Card(
            margin: const EdgeInsets.all(20),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _todoController,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      if (_todoController.text != "") {
                        Database()
                            .addTodo(_todoController.text, controller.userInfo!.uid);
                        _todoController.clear();
                      }
                    },
                  )
                ],
              ),
            ),
          ),
          const Text(
            "Your Todos",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
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
        backgroundColor: Colors.amber,
        child: const Icon(Icons.add),
        onPressed: (){
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
                  title: const Center(child: Text("Add Todo")),
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
                    child: const Text("Close")
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
                      child: const Text("Add")
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
