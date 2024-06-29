import 'package:codershub/firebase_options.dart';
import 'package:codershub/providers/userProvider.dart';
import 'package:codershub/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );   

  runApp(ChangeNotifierProvider(
      create : (context) => UserProvider(),
      child: const MyApp()
    )
  );
}

class MyApp extends StatefulWidget {

  const MyApp({super.key});
 
  @override
  State<MyApp> createState() => _MyAppState();

}

class _MyAppState extends State<MyApp>{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}