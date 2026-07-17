import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get lightTheme{
    return ThemeData(
      appBarTheme: AppBarTheme(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.lightBlueAccent,
          size: 30,
        ),
        titleTextStyle: GoogleFonts.blackOpsOne(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.lightBlueAccent),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.lightBlueAccent),
        ),
        hintStyle: TextStyle(color: Colors.blueGrey),
        suffixIconColor: Colors.blueAccent,
        prefixIconColor: Colors.blueAccent,
      ),

    //   Elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.lightBlueAccent,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 15),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: CupertinoColors.activeBlue
        )
      )
    );
  }
}