import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Home.dart';
import 'package:todo_app/Provider/myProvider.dart';
import 'package:todo_app/colors.dart';
import 'package:todo_app/firebase_functions.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "Login";
  LoginScreen({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    return Scaffold(
      backgroundColor: pro.appTheme == ThemeMode.light
          ? AppColors.secondary
          : AppColors.darkprimary,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 70,
        title: Text(
          "login screen".tr(),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: pro.appTheme == ThemeMode.light
                  ? Colors.white
                  : Colors.black),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(18.0),
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, "sign-up");
          },
          child: Text.rich(
              textAlign: TextAlign.center,
              TextSpan(children: [
                TextSpan(
                    text: "Don't have an account? ",
                    style: TextStyle(
                      fontSize: 14,
                      color: pro.appTheme == ThemeMode.light
                          ? Colors.black
                          : Colors.white,
                    )),
                TextSpan(
                    text: " sign up",
                    style: TextStyle(fontSize: 16, color: Colors.blue))
              ])),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.white), // Change text color to white
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue), // Change border color to blue
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.white), // Change text color to white
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue), // Change border color to blue
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                FirebaseFunctions.Login(
                    emailController.text, passController.text,
                    onSuccess: () async {
                  pro.initUser().then((value) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      HomeScreen.routeName,
                      (route) => false,
                    );
                  });
                }, onError: (error) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Error"),
                      content: Text(error),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Ok"))
                      ],
                    ),
                  );
                });
              },
              child: const Text(
                'Login',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
