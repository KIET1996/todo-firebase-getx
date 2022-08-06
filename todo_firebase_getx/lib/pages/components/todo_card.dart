import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_firebase_getx/models/todo_model.dart';
import 'package:todo_firebase_getx/services/database.dart';
import 'package:intl/intl.dart';

class TodoCard extends StatelessWidget {
  late String? uid;
  late TodoModel? todo;

  TodoCard({Key? key, this.uid, this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.grey,
          width: 1.0,
        ),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Checkbox(
              value: todo!.done,
              onChanged: (newValue) {
                Database().updateTodo(newValue!, uid!, todo!.todoId);
              },
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Text(
                    todo!.content,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    DateFormat('HH:mm - dd/MM/yyyy').format(todo!.dateCreated.toDate()),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey
                    ),
                  ),
               ]
              ),
            ),
            IconButton(
                onPressed: (){},
                icon: const Icon(Icons.clear)
            )
          ],
        ),
      ),
    );
  }
}