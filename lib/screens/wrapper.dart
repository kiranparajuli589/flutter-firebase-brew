import 'package:first_flutter_brew/screens/authenticate/authenticate.dart';
import 'package:first_flutter_brew/screens/home/home.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return either Home or Authenticate widget
    return Authenticate();
  }
}