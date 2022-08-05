import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  late var id;
  late var name;
  late var email;

  UserModel({this.id, this.name, this.email});

  UserModel.fromDocumentSnapshot({DocumentSnapshot? doc}) {
  id = doc?.id;
  name = doc?["name"];
  email = doc?["email"];
  }

}