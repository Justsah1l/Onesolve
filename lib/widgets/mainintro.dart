import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solve/components/custombutton.dart';
import 'package:solve/widgets/loginpage.dart';

class Intro extends StatelessWidget {
  const Intro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "ALL YOUR",
                        style: GoogleFonts.bebasNeue(
                            color: const Color.fromARGB(185, 0, 0, 0),
                            fontWeight: FontWeight.bold,
                            fontSize: 55),
                      ),
                      Row(
                        children: [
                          Text(
                            "PROBLEMS",
                            style: GoogleFonts.bebasNeue(
                                letterSpacing: 2.0,
                                color: Color.fromARGB(255, 225, 87, 87),
                                fontWeight: FontWeight.w600,
                                fontSize: 55),
                          ),
                          Text(
                            " ARE",
                            style: GoogleFonts.bebasNeue(
                                color: const Color.fromARGB(185, 0, 0, 0),
                                fontWeight: FontWeight.bold,
                                fontSize: 55),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "SOLVED",
                            style: GoogleFonts.bebasNeue(
                                letterSpacing: 2.0,
                                color: Color.fromARGB(255, 225, 87, 87),
                                fontWeight: FontWeight.w600,
                                fontSize: 55),
                          ),
                          Text(
                            " HERE",
                            style: GoogleFonts.bebasNeue(
                                color: const Color.fromARGB(185, 0, 0, 0),
                                fontWeight: FontWeight.bold,
                                fontSize: 55),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Don't carry the burden of your problems alone. Let OneSolve assist you in resolving them.",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Custombutton(
                    text: "Login",
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Loginpage(),
                          ));
                    },
                    color: Color.fromARGB(255, 225, 87, 87),
                    textcolor: Colors.white),
                SizedBox(
                  height: 17,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
