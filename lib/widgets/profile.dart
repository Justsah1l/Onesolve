import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solve/services/auth_service.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  String username = 'Name not available';
  String? photoURL;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    _fetchUsername();
  }

  Future<void> _fetchUsername() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      final data = userDoc.data() as Map<String, dynamic>?;
      setState(() {
        photoURL = data != null && data.containsKey('photoUrl')
            ? data['photoUrl']
            : "";
      });
      setState(() {
        username = data != null && data.containsKey('username')
            ? data['username']
            : 'Name not available';
        isLoading = false;
      });
    }
  }

  final List<String> items = [
    "Update profile",
    "Your posts",
    "Delete profile",
    "Privacy Policy",
    "Logout"
  ];
  final List<IconData> icons = [
    Icons.person_outline,
    Icons.article_sharp,
    Icons.delete,
    Icons.privacy_tip,
    Icons.logout
  ];
  User? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 17),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "PROFILE",
              style: GoogleFonts.bebasNeue(
                  color: const Color.fromARGB(185, 0, 0, 0),
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2,
                  fontSize: 55),
            ),
            SizedBox(
              height: 14,
            ),
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipOval(
                    child: Image.network(
                      photoURL ??
                          'https://via.placeholder.com/150', // Placeholder if no photo URL
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    username,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    user?.email ?? 'Email not available',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      if (items[index] == "Logout") {
                        //AuthService.signOut(context);
                      } else {}
                    },
                    child: Padding(
                      padding: items[index] == "Logout"
                          ? const EdgeInsets.symmetric(vertical: 26.0)
                          : const EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        children: [
                          Icon(
                            icons[index],
                            size: 29,
                            color: Color.fromARGB(255, 225, 87, 87),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            items[index],
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
