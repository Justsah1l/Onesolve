import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  CustomBottomNavBar({required this.selectedIndex, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.home,
              size: 26,
            ),
            color: selectedIndex == 0
                ? Color.fromARGB(255, 228, 64, 64)
                : Colors.grey,
            onPressed: () => onItemTapped(0),
          ),
          SizedBox(width: 48),
          IconButton(
            icon: Icon(
              Icons.notifications,
              size: 26,
            ),
            color: selectedIndex == 2
                ? Color.fromARGB(255, 228, 64, 64)
                : Colors.grey,
            onPressed: () => onItemTapped(1),
          ),
        ],
      ),
    );
  }
}
