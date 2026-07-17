import 'package:flutter/material.dart';
import 'package:my_notes/auth/forget_password_screen.dart';
import 'package:my_notes/auth/login_screen.dart';
import 'package:my_notes/auth/register_screen.dart';
import 'package:my_notes/models/note/note_model.dart';
import 'package:my_notes/screen/add_note/add_note_screen.dart';
import 'package:my_notes/screen/home/home_screen.dart';
import 'package:my_notes/screen/splash_screen/splash_screen.dart';
import 'package:my_notes/screen/update_note/update_note_screen.dart';

class RouteHelper {
  static String initial='/';
  static String loginScreen ='/loginScreen';
  static String registerScreen ='/registerScreen';
  static String forgetScreen ='/forgetScreen';
  static String homeScreen='/homeScreen';
  static String addNote='addNote';
  static const String updateNote='/updateNote';
  static myRoute() =>{
    initial: (context) => SplashScreen(),
    loginScreen : (context) => LoginScreen(),
    registerScreen : (context) => RegisterScreen(),
    forgetScreen : (context) => ForgetPasswordScreen(),
    homeScreen : (context) => HomeScreen(),
    addNote : (context) => AddNoteScreen(),
  };

  static onGenarateRoute(RouteSettings settings){
    switch(settings.name){
      case updateNote: {
        final note=settings.arguments as NoteModel;
        return MaterialPageRoute(
          builder: (context) => UpdateNoteScreen(note: note,)
        );
      }
    }
  }
}