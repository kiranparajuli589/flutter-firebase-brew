import 'package:first_flutter_brew/screens/style.dart';
import 'package:first_flutter_brew/services/auth.dart';
import 'package:first_flutter_brew/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool showSignInForm = false;
  bool loading = false;
  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    Widget signInForm = Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Regular Sign In Form:",
            style: TextStyle(fontSize: 40.0, fontFamily: 'Indies'),
          ),
          SizedBox(height: 20.0),
          TextFormField(
            decoration: textInputDecoration.copyWith(hintText: "Email"),
            onChanged: (value) {
              setState(() {
                email = value;
              });
            },
            validator: (value) {
              if (value.isEmpty) {
                return "Enter an email address.";
              }
              return null;
            },
          ),
          SizedBox(height: 20.0),
          TextFormField(
            decoration: textInputDecoration.copyWith(hintText: "Password"),
            validator: (value) {
              if (value.length < 6) {
                return "Enter a password 6+ chars long.";
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                password = value;
              });
            },
            obscureText: true,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            error,
            style: TextStyle(color: Colors.red, fontSize: 14.0),
          ),
          Row(
            children: [
              SizedBox(width: 20.0, height: 20.0),
              RaisedButton(
                color: Colors.green[400],
                child: Text(" Sign In "),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    setState(() {
                      loading = true;
                    });
                    dynamic result =
                        await _auth.signInWithEmailAndPassword(email, password);
                    if (result == null) {
                      setState(() {
                        error = "Couldn't signin with given credentials.";
                        loading = false;
                      });
                    } else {
                      setState(() {
                        loading = false;
                      });
                      print("SignIn(email/password) success");
                    }
                  }
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
          setState(() {
            loading = true;
          });
          dynamic result = await _auth.signInAnonymously();
          if (result == null) {
            setState(() {
              error = "Error signing in.";
              loading = false;
            });
          } else {
            setState(() {
              loading = false;
            });
            print("SignIn(anonymous) success");
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

    return loading ? Loading() : Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          backgroundColor: Colors.green[500],
          elevation: 0.0,
          title: Text("Sign in to Brew Crew"),
          actions: <Widget>[
            FlatButton.icon(
                onPressed: () {
                  widget
                      .toggleView(); // widget refers to self widget i.e Register
                },
                icon: Icon(
                  Icons.person_add,
                  color: Colors.deepPurple[100],
                ),
                label: Text(
                  "Register",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              showSignInForm ? signInForm : signInRegularButton,
              SizedBox(
                width: 20.0,
              ),
              signInAnonymouslyButton,
            ],
          ),
        ));
  }
}
