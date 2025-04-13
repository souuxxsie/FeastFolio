import 'package:feastfolio/employeeNoti.dart';
import 'package:feastfolio/employeehome.dart';
import 'package:feastfolio/profileScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconly/iconly.dart';

class Employeehomescreen extends StatefulWidget {
  const Employeehomescreen({super.key});

  @override
  State<Employeehomescreen> createState() => _EmployeehomescreenState();
}

class _EmployeehomescreenState extends State<Employeehomescreen> {
  @override
  int selectedIndex = 0;
  List<Widget> tabScreens = [
    Employeehome(),
    Employeenoti(),
    Profilescreen(),
  ];
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
            icon: IconlyBold.notification,
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
