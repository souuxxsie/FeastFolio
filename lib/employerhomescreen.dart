import 'package:feastfolio/addjobs.dart';
import 'package:feastfolio/employerhome.dart';
import 'package:feastfolio/profileScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconly/iconly.dart';
class EmployerHomeScreen extends StatefulWidget {
  const EmployerHomeScreen({super.key});

  @override
  State<EmployerHomeScreen> createState() => _EmployerHomeScreenState();
}

class _EmployerHomeScreenState extends State<EmployerHomeScreen> {
  int selectedIndex = 0;
  List<Widget> tabScreens = [
    Employerhome(),
    Addjobs(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GNav(
        selectedIndex: selectedIndex, // Bind state to selected tab
        onTabChange: (index) {
          setState(() {
            selectedIndex = index; // Update selected index when tapped
          });
        },
        tabs: [
          GButton(
            icon: IconlyBold.activity,
            iconSize: 35,
            iconColor: Colors.pinkAccent[100],
            iconActiveColor: Colors.pink[400],
          ),
          GButton(
              icon: IconlyBold.plus,
            iconSize: 35,
            iconColor: Colors.green[200],
            iconActiveColor: Colors.green[400],
          ),
          GButton(
            icon: IconlyBold.profile,
            iconSize: 35,
            iconColor: Colors.orangeAccent[100],
            iconActiveColor: Colors.orange[400],
          )
        ],
      ),
      body: tabScreens[selectedIndex],
    );
  }
}
