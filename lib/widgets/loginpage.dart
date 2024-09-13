import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solve/services/auth_service.dart';
import 'package:solve/widgets/addnameandphoto.dart';
import 'package:solve/widgets/homepage.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 155,
            ),
            Text(
              "LOGIN",
              style: GoogleFonts.bebasNeue(
                  letterSpacing: 2.0,
                  color: Color.fromARGB(185, 0, 0, 0),
                  fontWeight: FontWeight.w600,
                  fontSize: 55),
            ),
            Text(
              " Let’s get you logged In!",
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(
              height: 55,
            ),
            GestureDetector(
              onTap: () async {
                final User? user = await AuthService().signinwithgoogle();

                if (user != null) {
                  // Reference to the user's document in Firestore
                  DocumentSnapshot userDoc = await FirebaseFirestore.instance
                      .collection('users')
                      .doc(user.uid)
                      .get();

                  // Ensure userDoc exists and data is not null
                  final data = userDoc.data() as Map<String, dynamic>?;

                  if (userDoc.exists &&
                      data != null &&
                      data.containsKey('username')) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Homepage(),
                      ),
                    );
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Addnameandphoto(), // Page to complete profile
                      ),
                    );
                  }
                }
              },
              child: Container(
                height: 90,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.grey,
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4.0, vertical: 0),
                      child: ClipOval(
                        child: Image.asset(
                          "assets/google.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "LOGIN WITH GOOGLE ",
                      style: GoogleFonts.bebasNeue(
                          letterSpacing: 2.0,
                          color: Color.fromARGB(185, 0, 0, 0),
                          fontWeight: FontWeight.w600,
                          fontSize: 26),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
