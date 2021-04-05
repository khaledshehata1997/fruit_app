import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/fire_store_user.dart';
import '../models/user_model.dart';
class AuthViewModel extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  String email, password, name;




  void signInWithEmailAndPassword() async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e.message);
    }
  }

  void createAccountWithEmailAndPassword() async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((user) async {
        saveUser(user);
      });

    } catch (e) {
      print(e.message);

    }
  }

  void saveUser(UserCredential user) async {
    await FireStoreUser().addUsertoFireStore(UserModel(
      userid: user.user.uid,
      email: user.user.email,
      name: name == null ? user.user.displayName : name,
      pic: '',
      isAdmin: false
    ));
  }
}
