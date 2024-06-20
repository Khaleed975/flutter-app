import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_app/screens/Home.dart';
import 'package:graduation_app/screens/profile.dart';
import 'package:graduation_app/screens/services/Alzheimer_screen.dart';
import 'package:graduation_app/screens/settings.dart';

class NavBarRoots extends StatefulWidget {
  const NavBarRoots({super.key});

  @override
  State<NavBarRoots> createState() => _NavBarRootsState();
}

class _NavBarRootsState extends State<NavBarRoots> {
  int _selectedIndex = 0;
  final _screens = [
    HomeScreen(),
    AlzheimerDiseseService(),
    profilScreen(),
    SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        height: 60,
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0xff2A1B45),
          unselectedItemColor: Colors.black.withOpacity(0.6),
          selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_filled), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.search,
                ),
                label: "Detection"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
            // BottomNavigationBarItem(
            // icon: Icon(Icons.settings), label: "Settings"),
          ],
        ),
      ),
    );
  }
}
