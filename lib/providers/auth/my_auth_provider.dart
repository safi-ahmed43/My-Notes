import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_notes/main.dart';
import 'package:my_notes/models/auth/user_model.dart';
import 'package:my_notes/utils/Route/route_helper.dart';
import 'package:my_notes/utils/widgets/show_message.dart';

class MyAuthProvider with ChangeNotifier{
  bool obSecurePassword=true;
  bool isLoading=false;

  FirebaseAuth auth=FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  void passwordVisibility(){
    obSecurePassword = !obSecurePassword;
    notifyListeners();
  }
  MyAuthProvider(){
    nextScreen();
  }
  void nextScreen() async {
    await Future.delayed(Duration(seconds: 3));
    if(auth.currentUser == null){
      Navigator.pushReplacementNamed(navigatorKeys.currentContext!, RouteHelper.loginScreen);
    }else{
      Navigator.pushNamedAndRemoveUntil(navigatorKeys.currentContext!, RouteHelper.homeScreen, (value) => false);
    }

  }

  void authLogin(String email, String password) async {
    _loading(true);
    try{
      await auth.signInWithEmailAndPassword(email: email.trim(), password: password.trim());
      Navigator.pushNamedAndRemoveUntil(navigatorKeys.currentContext!, RouteHelper.homeScreen, (value) => false);
    }on FirebaseAuthException catch(e){
      showMessage(e.message);
    }
    catch(e){
      showMessage(e.toString());
    }finally{
      _loading(false);
    }
    notifyListeners();

  }
  void authRegister(String name, String email, String password) async {
    _loading(true);
    try{
      final result = await auth.createUserWithEmailAndPassword(email: email.trim(), password: password.trim());
      UserModel user=UserModel(
          result.user!.uid,
          email,
          password,
          DateTime.now(),
          name
      );
      await db.collection('user').doc(result.user!.uid).set(user.toMap());
      Navigator.pushNamedAndRemoveUntil(navigatorKeys.currentContext!, RouteHelper.homeScreen, (value) => false);

    }on FirebaseAuthException catch(e){
      showMessage(e.message);
    }
    catch(e){
      showMessage(e.toString());
    }finally{
      _loading(false);
    }
    notifyListeners();

  }
  void authForgotPassword(String email) async {
    _loading(true);
    try{
      await auth.sendPasswordResetEmail(email: email.trim());
      showMessage('Password reset please check your email');

      Navigator.pushReplacementNamed(navigatorKeys.currentContext!, RouteHelper.loginScreen);

    }on FirebaseAuthException catch(e){
      showMessage(e.message);
    }
    catch(e){
      showMessage(e.toString());
    }finally{
      _loading(false);
    }
    notifyListeners();

  }
  void authLogOut() async {
    _loading(true);
    try{
      await auth.signOut();
      Navigator.pushNamedAndRemoveUntil(navigatorKeys.currentContext!, RouteHelper.loginScreen, (value) => false);
    }on FirebaseAuthException catch(e){
      showMessage(e.message);
    }
    catch(e){
      showMessage(e.toString());
    }finally{
      _loading(false);
    }
    notifyListeners();

  }
  void _loading(bool value){
    isLoading=value;
    notifyListeners();
  }

}