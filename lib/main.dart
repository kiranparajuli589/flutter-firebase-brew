import 'package:first_flutter_brew/models/user.dart';
import 'package:first_flutter_brew/screens/wrapper.dart';
import 'package:first_flutter_brew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user, // accessing user stream from auth service
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
