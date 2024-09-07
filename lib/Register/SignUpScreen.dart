import 'package:flutter/material.dart';
import 'package:todo_app/Register/LoginScreen.dart';
import 'package:todo_app/firebase_functions.dart';

class Signupscreen extends StatelessWidget {
  static const String routeName = "sign-up";
  Signupscreen({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var userNameController = TextEditingController();
  var ageController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey= GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('SignUp Screen'),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text.rich(
              textAlign: TextAlign.center,
              TextSpan(children: [
                TextSpan(
                    text: "Already have an account? ",
                    style: TextStyle(fontSize: 14, color: Colors.black)),
                TextSpan(
                    text: " Login",
                    style: TextStyle(fontSize: 16, color: Colors.blue))
              ])),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
             key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  validator: (value) {
                    if(value==null || value.isEmpty){
                      return "Please enter your Email";
                    }
                    final bool emailValid =
                    RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[gmail]+\.[com]+")
                        .hasMatch(value);
                    if(!emailValid){
                      return "Please enter valid email";
                    }
                    return null;
                  },
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  validator: (value) {
                    if(value==null || value.isEmpty){
                      return "Please enter your Password";
                    }
                    RegExp regex =
                    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                    if(!regex.hasMatch(value)){
                      return "Please enter valid password";
                    }
                  },
                  controller: passController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    if(value==null || value.isEmpty){
                      return "Please enter your username";
                    }
                    return null;
                  },
                  controller: userNameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'UserName',
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return "Please enter your Age";
                    }
                    if(int.parse(value)<18){
                      return "Age must be above 18";
                    }
                  },
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Age',
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                  ),
                ),
                const SizedBox(height: 16),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if(formKey.currentState!.validate()){
                      FirebaseFunctions.createAccount(
                          emailController.text, passController.text,phone: phoneController.text,age:int.parse(ageController.text) ,username: userNameController.text,
                          onSuccess: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Account created successfully"),
                                backgroundColor: Colors.green,
                              ),
                            );
                            Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName, (route) => false,);

                          },
                          onError: (message){
                            showDialog(context: context, builder: (context) => AlertDialog(title: Text("Error"),content: Text(message),actions: [
                              ElevatedButton(onPressed: (){
                                Navigator.pop(context);
                              }, child: Text("Ok"))
                            ],),);
                          });
                    }

                  },
                  child: const Text('Sign up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
