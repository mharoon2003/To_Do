//Sign in page of the app

import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:native_shared_preferences/original_shared_preferences/original_shared_preferences.dart';
import '../home/Home_Page.dart';
import 'SignUp_Page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14)
                  )),
            ),
            TextField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)
                    )),
                obscureText: true),
            ElevatedButton(
              onPressed: login,
              child: Text('Log In'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => SignUpPage())),
              child: Text('Create new account'),
            ),
            TextButton(
              child: Text('Continue with Google'),
              onPressed: () => signInWithGoogle(),
            ),
            TextButton(
              child: Text('Continue with Facebook'),
              onPressed: () => signInWithFacebook(),
            ),
          ],
        ),
      ),
    );
  }

  void login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('logged_in', true);
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => HomeView()));
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
