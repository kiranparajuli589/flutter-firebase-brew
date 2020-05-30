import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_flutter_brew/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // auth changes user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser); // <--|
    // .map((FirebaseUser user) => _userFromFirebaseUser(user)); same -+
  }

  // sign in Anonymously
  Future signInAnonymously() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email & password

  //  register with email & password

  // signout
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
