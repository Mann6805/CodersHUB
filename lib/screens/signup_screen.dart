import 'package:codershub/controllers/signup_controller.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  
  bool isLoading = false;
  var userForm = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController role = TextEditingController();

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: 
        Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
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
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: password,
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
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: name,
                          // ignore: body_might_complete_normally_nullable
                          validator: (value){
                            if(value==null || value.isEmpty){
                              return "Name is required";
                            }
                          },
                          decoration: const InputDecoration(label: Text("Name")),
                        ),
                        const SizedBox(height: 25),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: role,
                          // ignore: body_might_complete_normally_nullable
                          validator: (value){
                            if(value==null || value.isEmpty){
                              return "Role is required";
                            }
                          },
                          decoration: const InputDecoration(label: Text("Role")),
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
                              
                                  if(userForm.currentState!.validate()) {
                                    isLoading = true;
                                    setState(() {});
                                    await SignupController.createAccount(email: email.text, password: password.text, name: name.text, role: role.text, context: context);
                                    isLoading = false;
                                    setState(() {});
                                  }
                                }, 
                                child: isLoading ?
                                const CircularProgressIndicator(
                                  color: Colors.white,
                                )  :
                                const Text(
                                  "Create an account",
                                  style: TextStyle(
                                    color: Colors.white
                                  ),
                                )
                                ),
                            ),
                          ],
                        ),
                      ],          
                    ),
                  ),
                ),
              ),
            ),
          ],
        ), 
      );
  }
}