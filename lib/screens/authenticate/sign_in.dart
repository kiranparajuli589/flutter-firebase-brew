import 'package:first_flutter_brew/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  bool showSignInForm = false;
  String email = "";
  String password = "";

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Widget signInForm = Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Sign Up Form:",
            style: TextStyle(fontSize: 40.0, fontFamily: 'Indies'),
          ),
          SizedBox(height: 20.0),
          TextFormField(
            onChanged: (value) {
              setState(() {
                email = value;
              });
            },
            validator: (value) {
              if (value.isEmpty) {
                return "Please enter email";
              }
              return null;
            },
          ),
          SizedBox(height: 20.0),
          TextFormField(
            onChanged: (value) {
              setState(() {
                password = value;
              });
            },
            obscureText: true,
          ),
          Row(
            children: [
              SizedBox(width: 20.0, height: 20.0),
              RaisedButton(
                color: Colors.green[400],
                child: Text(" Sign In "),
                onPressed: () async {
                  print(email);
                  print(password);
                },
              ),
              SizedBox(width: 20.0, height: 20.0),
              RaisedButton(
                color: Colors.deepOrange[300],
                child: Text(" Cancel "),
                onPressed: () {
                  setState(() {
                    showSignInForm = false;
                  });
                },
              )
            ],
          )
        ],
      ),
    );

    Widget signInAnonymouslyButton = RaisedButton(
        color: Colors.indigo[300],
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Text("   Anonymous Sign In   "),
        onPressed: () async {
          dynamic result = await _auth.signInAnonymously();
          if (result == null) {
            print("error signing in");
          } else {
            print("signed in");
            print(result.uid);
          }
        });

    Widget signInRegularButton = RaisedButton(
      color: Colors.deepPurple[300],
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Text("       Regular Sign In      "),
      onPressed: () async {
        setState(() {
          showSignInForm = true;
        });
        print("object");
      },
    );

    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.green[500],
        elevation: 0.0,
        title: Text("Sign in to Brew Crew"),
      ),
      body: ListView(
        children: <Widget>[
          showSignInForm ? signInForm : signInRegularButton,
          signInAnonymouslyButton,
        ],
      ),
    );
  }
}
