import 'package:first_flutter_brew/models/user.dart';
import 'package:first_flutter_brew/screens/authenticate/authenticate.dart';
import 'package:first_flutter_brew/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user =
        Provider.of<User>(context); // what type of data to fetched from context
    // return either Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
