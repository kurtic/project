import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stream_games/domain/user.dart';

class AuthService{
  final FirebaseAuth _fAuth = FirebaseAuth.instance;
  Future <User>signInWithEmailAndPassword(String email, String password) async{
    try{
      AuthResult result = await _fAuth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return User.fromFirebase(user);
    } catch(e){
      Fluttertoast.showToast(
          msg: e.toString().split(',')[1],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      return null;}


  }
  Future <User>registerWithEmailAndPassword(String email, String password) async{
    try{
      AuthResult result = await _fAuth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return User.fromFirebase(user);
    } catch(e){
      Fluttertoast.showToast(
          msg: e.toString().split(',')[1],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      return null;
    }
  }

  Future logOut() async {
    await _fAuth.signOut();
  }
  Stream<User> get currentUser{
    return _fAuth.onAuthStateChanged.map((FirebaseUser user) => user != null ? User.fromFirebase(user):null);
  }
}