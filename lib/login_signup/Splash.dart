import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_mangement_hive/home/Home_Page.dart';
import 'package:task_mangement_hive/login_signup/Signin_page.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () async {
      bool isLoggedIn = await checkLoginStatus();
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => isLoggedIn ? HomeView() : SigninPage()));
    });

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.lightBlueAccent,
              Colors.blue.shade300,
              Colors.blue.shade200,
              Colors.blue.shade100
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Text(
            'Manage Your Tasks with This App',
            style: TextStyle(fontSize: 24, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Future<bool> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('logged_in') ?? false;
  }
}
