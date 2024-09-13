import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:solve/components/custombutton.dart';
import 'package:solve/components/customtextfield.dart';
import 'package:solve/components/posttextfield.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class Addpost extends StatefulWidget {
  const Addpost({super.key});

  @override
  State<Addpost> createState() => _AddpostState();
}

class _AddpostState extends State<Addpost> {
  final ip = dotenv.env['IP'] ?? '';
  TextEditingController titlecontroller = new TextEditingController();
  TextEditingController descriptioncontroller = new TextEditingController();
  File? _selectedimage;
  User? user = FirebaseAuth.instance.currentUser;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedimage = File(image.path);
      });
    }
  }

  Future<void> _uploadPost() async {
    var url = Uri.parse("http://$ip:8080/addposts");
    var request = http.MultipartRequest('POST', url);

    request.fields['userid'] = user?.uid ?? '';
    request.fields['post_type'] = selectedProblemType ?? '';
    request.fields['title'] = titlecontroller.text;
    request.fields['description'] = descriptioncontroller.text;
    request.fields['name'] = 'sahil';

    if (_selectedimage != null) {
      request.files.add(
          await http.MultipartFile.fromPath('image', _selectedimage!.path));
    }

    var response = await request.send();

    if (response.statusCode == 201) {
      print('Post created successfully');
    } else {
      print('Failed to create post');
    }
  }

  final List<String> problemTypes = [
    "Technical Issues",
    "Product Recommendations",
    "Health & Wellness",
    "Career Advice",
    "Education & Learning",
    "Personal Finance",
    "Other"
  ];
  String? selectedProblemType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          "Add a Post",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.close,
              size: 29,
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                "Post type",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 26,
                    color: Colors.black),
              ),
              DropdownButton<String>(
                hint: Text("Choose a problem type"),
                value: selectedProblemType,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedProblemType = newValue;
                  });
                },
                items:
                    problemTypes.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Title",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 26,
                    color: Colors.black),
              ),
              Posttextfield(
                  isDescriptionField: false,
                  controller: titlecontroller,
                  hinttext: "Add title of your post"),
              SizedBox(
                height: 20,
              ),
              Text(
                "Description",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 26,
                    color: Colors.black),
              ),
              Posttextfield(
                isDescriptionField: true,
                controller: descriptioncontroller,
                hinttext: "Add Description about your post",
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  width: 120,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(4)),
                  child: Row(
                    children: [
                      Icon(
                        Icons.camera_enhance,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Upload",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Custombutton(
                  text: "Post",
                  onTap: _uploadPost,
                  color: Color.fromARGB(255, 187, 39, 39),
                  textcolor: Colors.white),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
