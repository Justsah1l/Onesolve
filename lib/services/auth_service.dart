/*
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = "http://localhost:8080";

  Future<String?> loginWithGoogle() async {
    // Initiate the login request to your backend
    final response = await http.get(Uri.parse("$baseUrl/auth/login"));

    if (response.statusCode == 302) {
      // Extract the redirect URL for Google's OAuth consent screen
      final redirectUrl = response.headers['location'];

      if (redirectUrl != null) {
        // Here you would normally open a webview or external browser for the user to log in.
        // For simplicity, we'll just simulate it by directly sending the user to the callback.

        // Normally, you'd capture the redirect after Google login
        final code = await _simulateGoogleLoginAndReturnCode(redirectUrl);

        // Send the code back to your backend to complete the login
        final callbackResponse = await http.get(
            Uri.parse("$baseUrl/auth/callback?state=state-token&code=$code"));

        if (callbackResponse.statusCode == 200) {
          final data = json.decode(callbackResponse.body);
          return data['email'];  // or whatever data you want to use
        }
      }
    }

    return null;
  }

  Future<String> _simulateGoogleLoginAndReturnCode(String redirectUrl) async {
    // Simulate a successful Google login
    return "simulated-auth-code";
  }
}

*/
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:solve/widgets/splashscreen.dart';

class AuthService {
  Future<User?> signinwithgoogle() async {
    await GoogleSignIn().signOut();
    final GoogleSignInAccount? guser = await GoogleSignIn().signIn();
    if (guser == null) {
      // User canceled the sign-in
      return null;
    }

    final GoogleSignInAuthentication gauth = await guser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: gauth.accessToken,
      idToken: gauth.idToken,
    );

    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    return userCredential.user;
  }

  static Future<void> signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      print("User signed out successfully.");
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Splashscreen(),
          ));
    } catch (e) {
      print("Error signing out: $e");
    }
  }
}
