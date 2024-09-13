import 'package:flutter/material.dart';

class Posttextfield extends StatelessWidget {
  String hinttext;
  TextEditingController controller;
  final bool isDescriptionField;
  Posttextfield(
      {required this.controller,
      required this.isDescriptionField,
      required this.hinttext,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
      child: TextField(
        keyboardType:
            isDescriptionField ? TextInputType.multiline : TextInputType.text,
        maxLines: isDescriptionField ? null : 1,
        minLines: isDescriptionField ? 5 : 1,
        controller: controller,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
              ),
            ),
            fillColor: Colors.white,
            filled: true,
            hintText: hinttext,
            hintStyle: TextStyle(color: Colors.grey[400])),
      ),
    );
  }
}
