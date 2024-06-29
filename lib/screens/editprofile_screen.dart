import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codershub/providers/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditprofileScreen extends StatefulWidget {
  const EditprofileScreen({super.key});

  @override
  State<EditprofileScreen> createState() => _EditprofileScreenState();
}

class _EditprofileScreenState extends State<EditprofileScreen> {

  TextEditingController name = TextEditingController();
  TextEditingController role = TextEditingController();
  var editProfileForm = GlobalKey<FormState>();
  var db = FirebaseFirestore.instance;

  @override
  void initState() {
    name.text = Provider.of<UserProvider>(context, listen: false).userName;
    role.text = Provider.of<UserProvider>(context, listen: false).userRole;
    super.initState();
  }

  void updateProfile() async {
    
    Map<String, dynamic> dataToUpdate = {
      "name" : name.text,
      "role" : role.text
    };
    await db.collection("users").doc(Provider.of<UserProvider>(context, listen: false).userId).update(dataToUpdate);
  
    // ignore: use_build_context_synchronously
    Provider.of<UserProvider>(context, listen: false).getUserData();
    // ignore: use_build_context_synchronously
    Navigator.pop(context);

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        actions: [
          InkWell(
            onTap: () {
              if (editProfileForm.currentState!.validate()){
                updateProfile();
              }
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.check),
            ),
          )
        ],
      ),
      // ignore: sized_box_for_whitespace
      body: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: editProfileForm,
            child: Column(
              children: [
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  // ignore: body_might_complete_normally_nullable
                  validator: (value) {
                    if(value==null || value.isEmpty){
                      return "Cannot Be Empty";
                    }
                  },
                  controller: name,
                  decoration: const InputDecoration(
                    label: Text("Name")
                  ),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  // ignore: body_might_complete_normally_nullable
                  validator: (value) {
                    if(value==null || value.isEmpty){
                      return "Cannot Be Empty";
                    }
                  },
                  controller: role,
                  decoration: const InputDecoration(
                    label: Text("Role")
                  ),
                )
              ],
            ),
          ),
        ),
      )
    );
  }
} 