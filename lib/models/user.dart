import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';

class User {
  String uid;
  String pseudo;

  User({
    @required this.uid,
    this.pseudo,
  });

  factory User.fromJson(Map<String, dynamic> json) => new User(
        uid: json["uid"],
        pseudo: json["pseudo"] ?? null,
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "pseudo": pseudo ?? null,
      };

  factory User.fromDocument(DocumentSnapshot doc) {
    return User.fromJson(doc.data);
  }
}

User userFromJson(String str) {
  final jsonData = json.decode(str);
  return User.fromJson(jsonData);
}

String userToJson(User data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}
