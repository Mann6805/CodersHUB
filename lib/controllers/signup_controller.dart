import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codershub/screens/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupController {

  static Future<void> createAccount({required String email, required String password, required String name, required String role, required BuildContext context}) async{
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email, password: password
      );  

      var userId = FirebaseAuth.instance.currentUser!.uid;
      var db = FirebaseFirestore.instance;

      Map<String, dynamic> data = {
        "name": name,
        "role": role,
        "email" : email,
        "id" : userId.toString()
      };

      try{
         await db.collection("users").doc(userId.toString()).set(data);
      }
      // ignore: empty_catches
      catch(e) { }
      

      Navigator.pushAndRemoveUntil(
      // ignore: use_build_context_synchronously
      context, 
      MaterialPageRoute(
          builder: (context) {
            return const SplashScreen();
          }
        ),
      (route) {
        return false;
      }
    );
    }
    catch (e) {
      SnackBar messagesnackbar = SnackBar(
        backgroundColor: Colors.red,
        content: Text(e.toString().substring(37))
      );
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        (messagesnackbar)
      );
    }
  }

}