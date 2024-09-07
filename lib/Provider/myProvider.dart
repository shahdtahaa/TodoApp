import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_app/Models/User_Modle.dart';
import 'package:todo_app/firebase_functions.dart';

class MyProvider extends ChangeNotifier {
  UserModel? userModel;
  User? firebaseUser;
  Locale _appLocale = Locale('en'); // Default locale

  Locale get appLocale => _appLocale;

  MyProvider(){

    firebaseUser=FirebaseAuth.instance.currentUser;
    if(firebaseUser!=null){
      initUser();
    }
  }
  Future<void>initUser()async {
    userModel = await FirebaseFunctions.readUserData();
    notifyListeners();
  }
  ThemeMode appTheme = ThemeMode.light;

  changeTheme(ThemeMode themeMode) {
    appTheme = themeMode;
    notifyListeners();
  }
  void setLocale(Locale locale) {
    _appLocale = locale;
    notifyListeners();
  }

  void changeLocale(String locale) {
    if (locale == 'ar') {
      _appLocale = Locale('ar');
    } else {
      _appLocale = Locale('en');
    }
    notifyListeners();
  }
}
