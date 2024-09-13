import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:solve/widgets/homepage.dart';
import 'package:solve/widgets/splashscreen.dart';

class Authgate extends StatefulWidget {
  const Authgate({super.key});

  @override
  _AuthgateState createState() => _AuthgateState();
}

class _AuthgateState extends State<Authgate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return const Homepage();
          } else {
            return const Splashscreen();
          }
        },
      ),
    );
  }
}
