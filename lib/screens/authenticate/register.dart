import 'package:first_flutter_brew/screens/style.dart';
import 'package:first_flutter_brew/services/auth.dart';
import 'package:first_flutter_brew/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String email = "";
  String name = "";
  String password = "";
  String error = "";
  bool goBack = false;
  bool loading = false;

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.green[500],
        elevation: 1.0,
        title: Text("Register"),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () {
                widget
                    .toggleView(); // widget refers to self widget i.e Register
              },
              icon: Icon(
                Icons.person_pin,
                color: Colors.deepPurple[100],
              ),
              label: Text(
                "Sign in",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                "Sign up to Brew Crew",
                style: TextStyle(
                    fontSize: 35.0,
                    fontFamily: 'Indies',
                    color: Colors.deepPurple[300],
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: "Email"),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Enter an email address";
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: "Full Name"),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Enter your full name.";
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: "Password"),
                validator: (value) {
                  if (value.length < 6) {
                    return "Enter a password 6+ characters long.";
                  }
                  return null;
                },
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    color: Colors.green[400],
                    child: Text(" Sign Up "),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        setState(() {
                          loading = true;
                        });
                        dynamic result = await _auth
                            .registerWithEmailAndPassword(email, name, password);
                        if (result != null) {
                          setState(() {
                            loading = false;
                          });
                          print("Register success.");
                          print(result.toString());
                        } else {
                          setState(() {
                            loading = false;
                          });
                          print(result);
                          setState(() {
                            error = "Register fails.";
                          });
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
                        goBack = true;
                      });
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
