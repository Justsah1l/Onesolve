import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:solve/components/custombutton.dart';
import 'package:solve/components/posttextfield.dart';
import 'package:solve/widgets/homepage.dart';

class Addnameandphoto extends StatefulWidget {
  const Addnameandphoto({super.key});

  @override
  State<Addnameandphoto> createState() => _AddnameandphotoState();
}

class _AddnameandphotoState extends State<Addnameandphoto> {
  TextEditingController uname = new TextEditingController();
  bool isLoading = false;
  String? usernameError;
  File? _image;
  // Pick image from gallery
  Future<void> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  // Check if username exists in Firestore
  Future<bool> usernameExists(String username) async {
    final result = await FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: username)
        .get();

    return result.docs.isNotEmpty;
  }

  // Submit username and photo
  Future<void> submit() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    String username = uname.text.trim();

    setState(() {
      isLoading = true;
      usernameError = null;
    });

    // Check if username exists
    bool exists = await usernameExists(username);
    if (exists) {
      setState(() {
        usernameError = 'Username already exists';
        isLoading = false;
      });
      return;
    }

    String? imageUrl;

    // If an image is selected, upload it to Firebase Storage
    if (_image != null) {
      final storageRef =
          FirebaseStorage.instance.ref().child('profile_pics/${user.uid}');
      await storageRef.putFile(_image!);
      imageUrl = await storageRef.getDownloadURL();
    }

    // Update Firestore user profile
    await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      'username': username,
      'photoUrl': imageUrl,
    }, SetOptions(merge: true));

    setState(() {
      isLoading = false;
    });

    // Navigate to the Homepage or relevant page after submission
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Homepage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 17),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 70,
            ),
            Text(
              "Add a profile picture (optional)",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.black),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: ClipOval(
                child: _image != null
                    ? Image.file(_image!,
                        width: 100, height: 100, fit: BoxFit.cover)
                    : const Icon(Icons.person, size: 100),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Custombutton(
              text: "Select photo",
              onTap: pickImage,
              color: Color.fromARGB(255, 0, 0, 0),
              textcolor: Colors.white,
            ),
            SizedBox(
              height: 70,
            ),
            Text(
              "Add a username",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 26,
                  color: Colors.black),
            ),
            SizedBox(
              height: 10,
            ),
            Posttextfield(
                isDescriptionField: false,
                controller: uname,
                hinttext: "example - sillycat90"),
            Spacer(),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : Custombutton(
                    text: "Submit",
                    onTap: submit,
                    color: const Color.fromARGB(255, 187, 39, 39),
                    textcolor: Colors.white,
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
