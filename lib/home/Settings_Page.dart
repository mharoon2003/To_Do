import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeAccountSettings extends StatefulWidget {
  @override
  State<ChangeAccountSettings> createState() => _ChangeAccountSettingsState();
}

class _ChangeAccountSettingsState extends State<ChangeAccountSettings> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController lastNameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    nameController.text = prefs.getString('name') ?? '';
    lastNameController.text = prefs.getString('last_name') ?? '';
    emailController.text = prefs.getString('email') ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Change Account Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            TextField(
              controller: lastNameController,
              decoration: InputDecoration(labelText: 'Last Name'),
            ),
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
                SharedPreferences prefs = await SharedPreferences.getInstance();
                // Update user data
                prefs.setString('name', nameController.text);
                prefs.setString('last_name', lastNameController.text);
                prefs.setString('email', emailController.text);
                // Optionally handle password update
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
