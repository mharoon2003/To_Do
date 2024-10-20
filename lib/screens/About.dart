import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage>
    with SingleTickerProviderStateMixin {
  bool _isLaunching = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation =
        Tween<double>(begin: 1.0, end: 1.2).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _launchURL(String url) async {
    setState(() => _isLaunching = true);
    try {
      final Uri parsedUri = Uri.parse(url);

      if (!await launchUrl(parsedUri)) {
        throw 'Could not launch $url';
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to open link')),
      );
    } finally {
      setState(() => _isLaunching = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      appBar: AppBar(
        title: Text(
          'Contact Us!',
          style: TextStyle(color: Colors.pink),
        ),
        backgroundColor: Colors.black12,
        iconTheme:
            IconThemeData(color: Colors.pink), // Set back button color to pink
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: CircleAvatar(
                    radius: 100,
                    backgroundImage: AssetImage("assets/images/MH.jpg"),
                  ),
                ),
                SizedBox(height: 40),
                Text(
                  'developer of app',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink),
                ),
                SizedBox(height: 20),
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  child: ElevatedButton(
                    child: _isLaunching
                        ? CircularProgressIndicator()
                        : Text(
                            'Meet me on Telegram',
                            style: TextStyle(color: Colors.pink[300]),
                          ),
                    onPressed: _isLaunching
                        ? null
                        : () => _launchURL('https://t.me/MHN_298'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white12,
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  child: ElevatedButton(
                    child: _isLaunching
                        ? CircularProgressIndicator()
                        : Text(
                            'Call Me',
                            style: TextStyle(color: Colors.pink[300]),
                          ),
                    onPressed: _isLaunching
                        ? null
                        : () => _launchURL('tel:+93765560112'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white12,
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
