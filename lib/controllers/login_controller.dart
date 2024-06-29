import 'package:codershub/screens/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginController {

  static Future<void> login({required String email, required String password, required BuildContext context}) async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email, password: password
      );  
      
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
        content: Text(e.toString().substring(35))
      );
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        (messagesnackbar)
      );
    }
  }

}