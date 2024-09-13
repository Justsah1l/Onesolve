import 'package:flutter/material.dart';

class Notificationpage extends StatefulWidget {
  const Notificationpage({super.key});

  @override
  State<Notificationpage> createState() => _NotificationpageState();
}

class _NotificationpageState extends State<Notificationpage> {
  bool torender = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: torender
          ? Column(
              children: [],
            )
          : Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
                child: Text("No notification for now"),
              ),
            ),
    );
  }
}
