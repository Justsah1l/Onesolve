import 'package:flutter/material.dart';

class Customtextfield extends StatelessWidget {
  String hinttext;
  bool obsure;
  TextEditingController controller;
  Customtextfield(
      {required this.controller,
      required this.obsure,
      required this.hinttext,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
      child: TextField(
        controller: controller,
        obscureText: obsure,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          //fillColor: Theme.of(context).colorScheme.secondary,
          filled: true,
          hintText: hinttext,
        ),
      ),
    );
  }
}
