import 'package:codershub/providers/userProvider.dart';
import 'package:codershub/screens/editprofile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  Widget build(BuildContext context) {

    var userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Center(
        child: Column(
          children: [
            CircleAvatar(
              radius: 35,
              backgroundColor: Colors.black87,
              foregroundColor: Colors.white,
              child: Text(userProvider.userName[0]),
            ),
            const SizedBox(height: 25,),
            Text(
              userProvider.userName,
              style: const TextStyle(
                fontWeight: FontWeight.bold
              ),
            ),
            Text(userProvider.userEmail),
            Text(userProvider.userRole),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) {
                      return const EditprofileScreen();
                    }
                  )
                ); 
              }, 
              child: const Text("Edit Profile")
            )
          ],
        ),
      ),
    );
  }
} 