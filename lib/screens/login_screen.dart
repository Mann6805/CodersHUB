import 'package:codershub/controllers/login_controller.dart';
import 'package:codershub/screens/signup_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  bool isLoading = false;
  var userForm = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
        Form(
          key: userForm,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                  width: 100,
                  child: Image(image: AssetImage("assets/images/logo.png"))
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: email,
                  // ignore: body_might_complete_normally_nullable
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return "Email is required";
                    }
                  },
                  decoration: const InputDecoration(label: Text("Email")),
                ),
                const SizedBox(height: 25),
                TextFormField(
                  controller: password,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  // ignore: body_might_complete_normally_nullable
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return "Password is required";
                    }
                  },
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: const InputDecoration(label: Text("Password")),
                ),
                const SizedBox(height: 25),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(

                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(0, 50),
                          backgroundColor: Colors.black87
                        ),  
                        onPressed: () async {
                          
                          if(userForm.currentState!.validate()){
                            isLoading = true;
                            setState(() {});
                            // ignore: use_build_context_synchronously
                            await LoginController.login(email: email.text, password: password.text, context: context);
                            isLoading = false;
                            setState(() {});
                          }
                        
                        }, 
                        child: isLoading ? 
                        const CircularProgressIndicator(
                          color: Colors.white,
                        ) :
                        const Text(
                          "Sign In",
                          style: TextStyle(
                            color: Colors.white
                          ),
                        )
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  children: [
                    const Text("Don't have an account?"),
                    const SizedBox(width: 10,),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const SignupScreen();
                            }
                          )
                        );
                      },
                      child: const Text(
                        "Signup Here !!!",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    )
                  ],
                ),
            ],
          )        
        ),
      ),
    );
  }
} 