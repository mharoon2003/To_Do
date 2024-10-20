import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_mangement_hive/home/Home_Page.dart';
import 'package:task_mangement_hive/login_signup/SignUp_Page.dart';

class SigninPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign In')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Implement sign-in logic here, then save logged-in status
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool('logged_in', true);
                // Navigate to Home
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => HomeView()));
              },
              child: Text('Sign In'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SignupPage()));
              },
              child: Text("Don't you have an account? Sign up"),
            ),
          ],
        ),
      ),
    );
  }
}
