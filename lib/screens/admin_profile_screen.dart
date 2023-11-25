import 'package:arogya_mitra/auth/login_screen.dart';
import 'package:arogya_mitra/screens/chat_screen.dart';
import 'package:arogya_mitra/screens/editUserProfile_screen.dart';
import 'package:arogya_mitra/screens/home_screen.dart';
import 'package:arogya_mitra/screens/map_screen.dart';
import 'package:arogya_mitra/screens/profile_screen.dart';
import 'package:arogya_mitra/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class AdminProfileScreen extends StatefulWidget {
  const AdminProfileScreen({super.key});

  @override
  State<AdminProfileScreen> createState() => _AdminProfileScreenState();
}

class _AdminProfileScreenState extends State<AdminProfileScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  Map<String, dynamic>? userData;
  String? userEmail = FirebaseAuth.instance.currentUser!.email;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // gettingUserData(user.uid);
  }

  // gettingUserData(String id) async {
  //   await DatabaseServices().getUserData(id).then((value) {
  //     setState(() {
  //       userData = value;
  //     });
  //   });
  // }

  int _currentIndex = 3;
  List<Widget> screens = [
    HomeScreen(),
    HealthCenterMap(),
    ChatScreen(),
    ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Screen"),
      ),
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
      body:
          SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    CircleAvatar(
                      radius: 50,
                      child: Center(
                        child: Icon(
                          Icons.person,
                          size: 35,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    itemProfile(
                        'Name',
                        userData != null ? userData!['fullName'] : user.uid,
                        CupertinoIcons.person),
                    const SizedBox(height: 20),
                    itemProfile(
                        'Phone',
                        userData != null ? userData!['phone'] : user.uid,
                        CupertinoIcons.phone),
                    const SizedBox(height: 20),
                    itemProfile(
                        'Address',
                        userData != null ? userData!['address'] : user.uid,
                        CupertinoIcons.location),
                    const SizedBox(height: 20),
                    itemProfile(
                        'Email',
                        userData != null ? userData!['email'] : user.email,
                        CupertinoIcons.mail),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => EditUserProfileScreen()));
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(15),
                          ),
                          child: const Text('Edit Profile')),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () async {
                            await signOut().then((value) {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()),
                                  (route) => false);
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(15),
                          ),
                          child: const Text('Logout')),
                    )
                  ],
                ),
              ),
            ),
    );
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();

      // Sign out from Google (if previously signed in with Google)
      final googleSignIn = GoogleSignIn();
      if (await googleSignIn.isSignedIn()) {
        await googleSignIn.signOut();
      }
    } catch (e) {
      print("Error signing out: $e");
    }
  }

  Widget itemProfile(String title, String subtitle, IconData iconData) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 1,
            offset: Offset(1, 1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Adjust the padding as needed
        child: Row(
          children: [
            Icon(iconData),
            SizedBox(width: 12), // Adjust the spacing between the icon and text
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(subtitle),
              ],
            ),
          ],
        ),
      ),
    );
  }
}