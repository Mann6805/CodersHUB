import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codershub/providers/userProvider.dart';
import 'package:codershub/screens/chatroom_screen.dart';
import 'package:codershub/screens/profile_screen.dart';
import 'package:codershub/screens/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  var user = FirebaseAuth.instance.currentUser;
  var db = FirebaseFirestore.instance;
  List<Map<String, dynamic>> chatroomsList = [];
  final List<IconData> logos = [Icons.laptop,Icons.biotech,Icons.bar_chart,Icons.android];
  List<String> chatroomsId = [];

  void getChatrooms() async{
    await db.collection("chatroom").get().then(
      (value){
        for(var singleData in value.docs){
          chatroomsList.add(singleData.data());
          chatroomsId.add(singleData.id.toString());
        }
      }
    );

    setState(() {});
  }

  @override
  void initState() {
    getChatrooms();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("CodersHUB"),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const SizedBox(height: 23),
            ListTile(
              title: Text(
                userProvider.userName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold
                ),
              ),
              subtitle: Text(userProvider.userEmail),
              leading: CircleAvatar(  
                backgroundColor: Colors.black87,
                foregroundColor: Colors.white,
                child: Text(userProvider.userName[0]),
              ),
            ),
            ListTile(
              title: const Text("Profile"),
              leading: const Icon(Icons.person),
              onTap: () {
                Navigator.push(
                  // ignore: use_build_context_synchronously
                  context, 
                  MaterialPageRoute(
                    builder: (context) {
                      return const ProfileScreen();
                    }
                  ),
                );
              }, 
            ),
            ListTile(
              title: const Text("LogOut"),
              leading: const Icon(Icons.logout),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
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
              }, 
            )
          ]
        ),
      ),
      body: ListView.builder(
        itemCount: chatroomsList.length,
        itemBuilder: (BuildContext context, int index){
      
        return ListTile(
            onTap: (){
              Navigator.push(
                  // ignore: use_build_context_synchronously
                  context, 
                  MaterialPageRoute(
                    builder: (context) {
                      return ChatroomScreen(
                        chatroomId: chatroomsId[index],
                        chatroomName: chatroomsList[index]["chatroom_name"],
                      );
                    }
                  )
              );
            },
            leading: CircleAvatar(
                backgroundColor: Colors.black87,
                foregroundColor: Colors.white,
                child: Icon(logos[index])
              ),
            title: Text(chatroomsList[index]["chatroom_name"]),
            subtitle: Text(chatroomsList[index]["desc"] ?? ""),
          );
        }
      )
    );
  } 
}