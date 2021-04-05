import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class FireStoreUser {
  final CollectionReference _userCollectionRef =
  FirebaseFirestore.instance.collection("Users");

  Future<void> addUsertoFireStore(UserModel userModel) async {
    return await _userCollectionRef
        .doc(userModel.userid)
        .set(userModel.toJson());
  }
}