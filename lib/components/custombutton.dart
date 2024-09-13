import 'package:flutter/material.dart';

class Custombutton extends StatelessWidget {
  void Function()? onTap;
  String text;
  Color? color;
  Color? textcolor;
  Custombutton(
      {required this.text,
      required this.onTap,
      required this.color,
      required this.textcolor,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Center(
            child: Text(
          text,
          style: TextStyle(
            color: textcolor,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        )),
      ),
    );
  }
}
