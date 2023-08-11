import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'display.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {

  googleLogin() async {
    GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      var result = await _googleSignIn.signIn();
      if (result == null) {
        return;
      }

      final userData = await result.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: userData.accessToken, idToken: userData.idToken);
      var finalResult =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (finalResult.user != null) {
      print("Google login successful");
      print("Display Name: ${finalResult.user!.displayName}");
      print("Email: ${finalResult.user!.email}");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Display()),
        );
      }
    } catch (error) {
      print(error);
    }
  }


  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (usernameController.text.isNotEmpty && passwordController.text.isNotEmpty) {
                  login().then((_) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Display()),
                    );
                  });
                }
              },
              child: Text('Login'),
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                googleLogin();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
              ),
              icon: Image.asset(
                'img/google.png',
                width: 24.0,
                height: 24.0,
              ),
              label: Text('Login with Google'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> login() async {
    if (usernameController.text == "username" && passwordController.text == "password") {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLoggedIn', true);
    }
  }
}
