import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {

  String userName = "";
  String userEmail = "";
  String userRole = "";
  String userId = "";

  var db = FirebaseFirestore.instance;

  void getUserData() async {
    var authUser = FirebaseAuth.instance.currentUser;
    await db.collection("users").doc(authUser!.uid).get().then(
      (value) {
        userName = value.data()?["name"] ?? "";
        userEmail = value.data()?["email"] ?? "";
        userRole = value.data()?["role"] ?? "";
        userId = value.data()?["id"] ?? "";
        notifyListeners();
      }
    );
  }

}