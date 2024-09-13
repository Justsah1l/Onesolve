import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solve/widgets/addpost.dart';
import 'package:solve/widgets/displaypage.dart';
import 'package:solve/widgets/notification.dart';
import 'package:solve/widgets/profile.dart';
import '../components/custombottomnav.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  PageController _pageController = PageController();
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
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
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Profilepage(),
                  ));
            },
          ),
          SizedBox(
            width: 15,
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: <Widget>[
          Displaypage(),
          Notificationpage(),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
      floatingActionButton: Container(
        width: 65.0,
        height: 65.0,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Addpost(),
                ));
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Color.fromARGB(255, 228, 64, 64),
          shape: CircleBorder(),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
