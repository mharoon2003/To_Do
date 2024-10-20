import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_mangement_hive/home/Timer.dart';
import 'package:task_mangement_hive/home/time_display.dart';
import 'package:task_mangement_hive/screens/About.dart';
import '../screens/Add_task_type.dart';
import 'Settings_Page.dart';
import 'Task_type_page.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  // Logout function
  void logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushReplacementNamed('/login'); // Navigate to your login screen
    } catch (e) {
      print("Logout error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Logout failed. Please try again.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: context.width * 0.82,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), bottomRight: Radius.circular(20))),
      backgroundColor: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: context.height * 0.065),
              const Row(
                children: [
                  Text(
                    "Manage ",
                    style: TextStyle(
                        color: Color.fromARGB(255, 144, 24, 64),
                        fontSize: 24,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Tasks",
                    style: TextStyle(
                        color: Color.fromARGB(255, 246, 16, 93),
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              DrawerHeader(
                child: TimeDisplay(),
                margin: EdgeInsets.all(4),
                padding: EdgeInsets.all(4),
              ),
              SizedBox(height: context.height * 0.025),
              const Divider(color: Color.fromARGB(255, 61, 61, 61)),
              SizedBox(height: context.height * 0.01),
              DrawerTile(
                function: () {
                  Navigator.of(context).pop();
                },
                text: 'Home',
                icon: Icons.home_outlined,
                isSelected: true,
              ),
              DrawerTile(
                function: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => TimerPage()));
                },
                text: 'Timer',
                icon: Icons.timer_outlined,
                isSelected: false,
              ),
              SizedBox(height: context.height * 0.009),
              const Divider(color: Color.fromARGB(255, 47, 47, 47)),
              SizedBox(height: context.height * 0.009),
              DrawerTile(
                function: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => TaskTypesPage(),
                  ));
                },
                text: 'Task Types',
                icon: Icons.list,
                isSelected: false,
              ),
              DrawerTile(
                function: () {
                  //TODO: just route
                },
                text: 'Customize',
                icon: Icons.draw_outlined,
                isSelected: false,
              ),
              DrawerTile(
                function: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SettingsPage()));
                },
                text: 'Account Settings',
                icon: Icons.account_circle_sharp,
                isSelected: false,
              ),
              SizedBox(height: context.height * 0.009),
              const Divider(color: Color.fromARGB(255, 47, 47, 47)),
              SizedBox(height: context.height * 0.009),
              DrawerTile(
                function: () {},
                text: 'Rate this app',
                icon: Icons.star,
                isSelected: false,
              ),
              DrawerTile(
                function: () {
                  Get.to(() => AboutPage());
                },
                text: 'Contact Us',
                icon: Icons.contact_support_sharp,
                isSelected: false,
              ),
              SizedBox(height: context.height * 0.009),
              const Divider(color: Color.fromARGB(255, 47, 47, 47)),
              SizedBox(height: context.height * 0.009),
              DrawerTile(
                function: () {
                  logout(context); // Call logout function
                },
                text: 'Log Out',
                icon: Icons.logout,
                isSelected: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerTile extends StatelessWidget {
  const DrawerTile({
    super.key,
    required this.text,
    required this.icon,
    required this.isSelected,
    required this.function,
  });
  final Function() function;
  final String text;
  final IconData icon;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(500),
      color: isSelected
          ? const Color.fromARGB(255, 41, 22, 29)
          : Colors.black,
      child: InkWell(
        splashColor: const Color.fromARGB(255, 41, 22, 29),
        borderRadius: BorderRadius.circular(500),
        onTap: function,
        child: Container(
          width: double.infinity,
          height: context.height * 0.07,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(500)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: context.width * 0.05),
              Icon(
                color: isSelected
                    ? const Color.fromARGB(255, 202, 33, 89)
                    : Colors.grey,
                icon,
                size: context.height * 0.039,
              ),
              SizedBox(width: context.width * 0.032),
              Text(
                text,
                style: TextStyle(
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected
                        ? const Color.fromARGB(255, 202, 33, 89)
                        : Colors.grey,
                    fontSize: 17),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
