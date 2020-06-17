import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase/auth/database.dart';
import 'package:flutter_firebase/model/user.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create obj user based on firebase user
  User _userfromFireBase(FirebaseUser user){
    return user != null ? User(uid: user.uid): null;
  }

  //auth change detector
  Stream<User> get user{
    return _auth.onAuthStateChanged.map(_userfromFireBase);
}
  //anon sign in
  Future signInAnon() async{
    try{
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userfromFireBase(user);
    }catch(e){
      print(e.toString());
      return null;
    }

  }

  //mail sign in
  Future signIn(String email , String password) async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userfromFireBase(user);
    }

    catch(e){
      print(e.toString());
      return null;
    }
  }

  // register
  Future register(String email , String password) async{
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      await DatabaseService(uid: user.uid).updateUserData('0','aditya', 100);
      return _userfromFireBase(user);
    }

    catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign out
   Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
   }
}