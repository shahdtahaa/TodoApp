import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Provider/myProvider.dart';
import 'package:todo_app/Register/LoginScreen.dart';
import 'package:todo_app/Register/SignUpScreen.dart';
import 'package:todo_app/splashScreen.dart';
import 'MyTheme.dart';
import 'editScreen.dart';
import 'firebase_options.dart';
import 'Home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseFirestore.instance.enableNetwork();

  runApp(ChangeNotifierProvider(
      create: (context) => MyProvider(),
      child: EasyLocalization(
        supportedLocales: [Locale('en'), Locale('ar')],
        path: 'assets/translations',
        saveLocale: true,
        startLocale: Locale('en'),
        // fallbackLocale: Locale(provider.langCode),
        child: MyApp(),
      )
  ));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale:context.locale,

      themeMode: pro.appTheme,
      theme: MyThemeData.LightTheme,
      darkTheme: MyThemeData.DarkTheme,
      initialRoute:Splashscreen.routeName,
      routes:{
        Splashscreen.routeName:(context)=>Splashscreen(),
        EditScreen.routeName:(context)=>EditScreen(),
        HomeScreen.routeName:(context)=>HomeScreen(),
        LoginScreen.routeName:(context)=>LoginScreen(),
        Signupscreen.routeName:(context)=>Signupscreen()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
