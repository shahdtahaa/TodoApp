import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Provider/myProvider.dart';
import 'package:todo_app/colors.dart';

class MyThemeData {
  static ThemeData LightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.transparent,
      appBarTheme: AppBarTheme(
        centerTitle: false,
        color: AppColors.primary,
        titleTextStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w700,
            fontSize: 22,
            height: 33,
            color: Colors.white),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.white,
        backgroundColor: AppColors.secondary,
        type: BottomNavigationBarType.fixed,
      ),
       textTheme: TextTheme(
         bodyMedium:
        GoogleFonts.inter(fontSize: 25, fontWeight: FontWeight.w400),
      //   bodySmall: GoogleFonts.elMessiri(
      //     fontSize: 20,
      //     fontWeight: FontWeight.w400,
      //   ),
 )
    );

  static ThemeData DarkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.transparent,
  appBarTheme: AppBarTheme(
  centerTitle: false,
  color: AppColors.primary,
  titleTextStyle: GoogleFonts.poppins(
  fontWeight: FontWeight.w700,
  fontSize: 22,
  height: 33,
    ),
  ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: AppColors.primary,
      unselectedItemColor: Colors.white,
      backgroundColor: AppColors.darkprimary,
      type: BottomNavigationBarType.fixed,
    ),
    textTheme: TextTheme(
      bodyMedium: GoogleFonts.inter(
          fontSize: 25, fontWeight: FontWeight.w400, color: Colors.white),
    //   bodySmall: GoogleFonts.elMessiri(
    //       fontSize: 20, fontWeight: FontWeight.w400, color: Colors.white),
 ),
  );
}