import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_flutter_brew/models/user.dart';
import 'package:first_flutter_brew/services/database.dart';

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
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //  register with email & password
  Future registerWithEmailAndPassword(
      String email, String name, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;

      // create a nrw document for the user with the uid and name
      await DatabaseService(uid: user.uid).updateUserData("sugar", name, 10);

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

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
