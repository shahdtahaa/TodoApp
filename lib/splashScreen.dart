import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Register/LoginScreen.dart';

import 'Home.dart';
import 'Provider/myProvider.dart';

class Splashscreen extends StatefulWidget {
  static const String routeName ='splashScreen';
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();

    // Using WidgetsBinding to ensure the context is available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(seconds: 3), () {
        var pro = Provider.of<MyProvider>(context, listen: false);
        Navigator.pushReplacementNamed(
          context,
          pro.firebaseUser != null
              ? HomeScreen.routeName
              : LoginScreen.routeName,
        );
      });
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
            children: [
              Spacer(),
              Center(child: Image.asset(
                  'assets/images/logo.png'
              ),
              ),
              Spacer(),
              Center(child: Image.asset(
                  'assets/images/route blue.png'
              )),
            ]
        )
    );
  }
}
