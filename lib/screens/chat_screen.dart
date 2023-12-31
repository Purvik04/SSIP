// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:arogya_mitra/screens/admin_profile_screen.dart';
import 'package:arogya_mitra/screens/home_screen.dart';
import 'package:arogya_mitra/screens/map_screen.dart';
import 'package:arogya_mitra/screens/profile_screen.dart';
import 'package:arogya_mitra/screens/search_screen.dart';
import 'package:arogya_mitra/services/auth_service.dart';
import 'package:arogya_mitra/services/db_services.dart';
import 'package:arogya_mitra/widgets/chat_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  int _currentIndex = 2;
  List<Widget> screens = [
    HomeScreen(),
    HealthCenterMap(),
    ChatScreen(),
    ProfileScreen()
  ];
  String userId = FirebaseAuth.instance.currentUser!.uid;
  String? userEmail = FirebaseAuth.instance.currentUser!.email;
  bool? isAdmin;
  Stream<List<HealthCenter>>? healthCenters;
  Stream<List<UserofAPP>>? users;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();  
    getChatStatus();
  }

  getChatStatus() async {
    setState(() {
      isAdmin = userEmail!.substring(0, 3) == "phc" ||
          userEmail!.substring(0, 3) == "uhc" ||
          userEmail!.substring(0, 3) == "chc";
    });
    if (isAdmin!) {
      final chatStream = DatabaseServices().getConversationsForHC(userId);
      setState(() {
        users = chatStream;
      });
    } else {
      final chatStream = DatabaseServices().getConversationsForUser(userId);
      setState(() {
        healthCenters = chatStream;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        automaticallyImplyLeading: false,
        title: Text(
          'Chats',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          SizedBox(
            width: 10,
          ),
        ],
        elevation: 0,
      ),
      body: chatList(),
      floatingActionButton: isAdmin == false
          ? FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SearchScreen(
                          userId: userId,
                        )));
              },
              child: Icon(
                Icons.add,
                size: 30,
              ),
              backgroundColor: Theme.of(context).primaryColor,
              elevation: 0,
            )
          : FloatingActionButton(onPressed: () {}),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (i) async {
          if (i == 3) {
            bool isAdmin = AuthServices().isAdminUser();

            if (isAdmin) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AdminProfileScreen()));
            } else {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ProfileScreen()));
            }
          } else {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => screens[i]));
          }
        },
        selectedItemColor: Color(0xFF0856DE),
        itemPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        items: [
          SalomonBottomBarItem(
            icon: const Icon(
              Icons.home,
            ),
            title: const Text("Home"),
          ),
          SalomonBottomBarItem(
            icon: const Icon(
              Icons.local_hospital,
            ),
            title: const Text("Hospital"),
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.message),
            title: const Text("Chat"),
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.person),
            title: const Text("Profile"),
          ),
        ],
      ),
    );
  }

  chatList() {
    if (isAdmin!) {
      return StreamBuilder<List<UserofAPP>>(
        stream: users,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final users = snapshot.data;
            if (users != null && users.isNotEmpty) {
              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return ChatTile(
                    user_id: user.id,
                    hc_id: userId,
                    hc_name: user.name,
                    lastmsg: "heelo doctor",
                  );
                },
              );
            } else {
              return noChatWidget();
            }
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            );
          }
        },
      );
    } else {
      return StreamBuilder<List<HealthCenter>>(
        stream: healthCenters,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final healthCenters = snapshot.data;
            if (healthCenters != null && healthCenters.isNotEmpty) {
              return ListView.builder(
                itemCount: healthCenters.length,
                itemBuilder: (context, index) {
                  final healthCenter = healthCenters[index];
                  return ChatTile(
                    user_id: userId,
                    hc_id: healthCenter.id,
                    hc_name: healthCenter.name,
                    lastmsg: "doctor",
                  );
                },
              );
            } else {
              return noChatWidget();
            }
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            );
          }
        },
      );
    }
  }

  noChatWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "If you have questions or need assistance, feel free to start a new chat. We're here to help you with any health-related inquiries or concerns. Just click the 'Start a New Chat' button below to get in touch with our health center. ",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 17,
                height: 1.5,
                fontWeight: FontWeight.bold,
                color: Colors.grey.withOpacity(0.8)),
          ),
        ],
      ),
    );
  }
}
