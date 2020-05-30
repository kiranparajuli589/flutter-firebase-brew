import 'package:first_flutter_brew/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.green[500],
        elevation: 0.0,
        title: Text("Sign in to Brew Crew"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: RaisedButton(
            child: Text("Sign in anon"),
            onPressed: () async {
              dynamic result = await _auth.signInAnonymously();
              if (result == null) {
                print("error signing in");
              } else {
                print("signed in");
                print(result);
              }
            }),
      ),
    );
  }
}