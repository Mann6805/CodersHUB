import 'package:codershub/providers/userProvider.dart';
import 'package:codershub/screens/dashboard_screen.dart';
import 'package:codershub/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  var user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();

    // Check for user login status
    Future.delayed(
      const Duration(seconds: 1),
      () {
        if (user==null){
          openLogin();
        }
        else {
          openDashboard();
        }
      }  
    );
  
  }

  void openDashboard(){

    Provider.of<UserProvider>(context, listen: false).getUserData();
    Navigator.pushReplacement(
      context, 
      MaterialPageRoute(
          builder: (context) {
            return const DashboardScreen();
          }
        )
    );
  }

  void openLogin(){
    Navigator.pushReplacement(
      context, 
      MaterialPageRoute(
          builder: (context) {
            return const LoginScreen();
          }
        )
    );
  } 

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Image(image: AssetImage("assets/images/logo.png"))
      ),
    );
  }
  
}