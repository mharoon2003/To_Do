
//Sign up page of the app

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:native_shared_preferences/original_shared_preferences/original_shared_preferences.dart';
import 'package:task_mangement_hive/home/Home_Page.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      labelText: 'Name'),
                ),
                TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      labelText: 'Last Name'),
                ),
              ],
            ),
            SizedBox(
              width: 6,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            SizedBox(
              width: 6,
            ),
            TextField(
                decoration: InputDecoration(

                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                obscureText: true),
            SizedBox(
              width: 6,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomeView()));
              },
              child: Text('Sign Up'),
            ),
            SizedBox(
              width: 6,
            ),
            TextButton(
                child: Text('Continue with Google'),
                onPressed: () {
                  signInWithGoogle();
                }),
            SizedBox(
              width: 6,
            ),
            TextButton(
                child: Text('Continue with Facebook'),
                onPressed: () {
                  signInWithFacebook();
                }),
          ],
        ),
      ),
    );
  }

  void signInWithGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signIn();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('logged_in', true);
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => HomeView()));
  }

  void signInWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('logged_in', true);
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => HomeView()));
    } else {
      // Handle login error
      print("Facebook login failed: ${result.status}");
    }
  }
}
