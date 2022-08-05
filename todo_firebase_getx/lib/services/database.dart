import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import 'package:todo_firebase_getx/models/todo_model.dart';

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> createNewUser(String? id, String name, String? email) async {
    try {
      await _firestore.collection("users").doc(id).set({
        "name": name,
        "email": email,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<UserModel> getUser(String uid) async {
    try {
      DocumentSnapshot _doc =
      await _firestore.collection("users").doc(uid).get();

      return UserModel.fromDocumentSnapshot(doc: _doc);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> addTodo(String content, String uid) async {
    try {
      await _firestore
          .collection("users")
          .doc(uid)
          .collection("todos")
          .add({
        'dateCreated': Timestamp.now(),
        'content': content,
        'done': false,
      });
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Stream<List<TodoModel>> todoStream(String uid) {
    return _firestore
        .collection("users")
        .doc(uid)
        .collection("todos")
        .orderBy("dateCreated", descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      List<TodoModel> retVal = [];
      query.docs.forEach((element) {
        retVal.add(TodoModel.fromDocumentSnapshot(element));
      });
      return retVal;
    });
  }

  Future<void> updateTodo(bool newValue, String uid, String todoId) async {
    try {
      _firestore
          .collection("users")
          .doc(uid)
          .collection("todos")
          .doc(todoId)
          .update({"done": newValue});
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
