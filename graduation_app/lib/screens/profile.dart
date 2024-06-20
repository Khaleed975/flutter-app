import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_app/screens/components/profile_items.dart';

import 'package:graduation_app/screens/components/profile_pic.dart';
import 'package:graduation_app/screens/login.dart';
import 'package:graduation_app/screens/my%20account.dart';

class profilScreen extends StatelessWidget {
  const profilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            const ProfilePic(),
            const SizedBox(height: 20),
            ProfileItems(
              text: "My Account",
              icon: Icons.person,
              press: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyAccountScreen(),
                    ));
              },
            ),
            //ProfileItems(
            //text: "Notifications",
            //icon: Icons.notification_add,
            //press: () {},
            // ),
            ProfileItems(
              text: "Settings",
              icon: Icons.settings,
              press: () {},
            ),
            ProfileItems(
              text: "Help Center",
              icon: Icons.help_center,
              press: () {},
            ),
            ProfileItems(
              text: "Log Out",
              icon: Icons.logout,
              press: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const loginScreen(),
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
