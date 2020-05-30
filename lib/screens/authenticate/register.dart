import 'package:first_flutter_brew/services/auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String email = "";
  String name = "";
  String password = "";
  bool goBack = false;

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 1.0,
        title: Text("Register")
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: Form(
          child: Column(
            children: [
              Text(
                "Sign up to Brew Crew",
                style: TextStyle(fontSize: 35.0, fontFamily: 'Indies', color: Colors.deepPurple[300], fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
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
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
              Row(
                children: [
                  SizedBox(width: 20.0, height: 20.0),
                  RaisedButton(
                    color: Colors.green[400],
                    child: Text(" Sign Up "),
                    onPressed: () async {
                      print(email);
                      print(name);
                      print(password);
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
