import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solve/widgets/mainintro.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const Intro()),
        (Route<dynamic> route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "ONE",
                        style: GoogleFonts.bebasNeue(
                            fontWeight: FontWeight.bold, fontSize: 29),
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Text("SOLVE",
                          style: GoogleFonts.bebasNeue(
                              color: Color.fromARGB(255, 228, 64, 64),
                              fontWeight: FontWeight.bold,
                              fontSize: 29))
                    ],
                  ),
                ],
              ),
            ),
            Text(
              "The only app you'll ever need.",
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
