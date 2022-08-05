import 'package:flutter/material.dart';
import 'package:todo_firebase_getx/models/todo_model.dart';
import 'package:todo_firebase_getx/services/database.dart';

class TodoCard extends StatelessWidget {
  late String? uid;
  late TodoModel? todo;

  TodoCard({Key? key, this.uid, this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                todo!.content,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Checkbox(
              value: todo!.done,
              onChanged: (newValue) {
                Database().updateTodo(newValue!, uid!, todo!.todoId);
              },
            ),
          ],
        ),
      ),
    );
  }
}