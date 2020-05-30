import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  // collection reference
  final CollectionReference brewCollection =
      Firestore.instance.collection("brews_cloud");

  Future updateUserData(String sugar, String name, int strength) async {
    return await brewCollection
        .document(uid)
        .setData({'sugars': sugar, 'name': name, 'strength': strength});
  }
}
