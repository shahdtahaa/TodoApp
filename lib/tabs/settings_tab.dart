import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Provider/myProvider.dart';
import 'package:todo_app/Register/LoginScreen.dart';

import '../bottom_sheets/Language_BottomSheet.dart';
import '../bottom_sheets/Theme_BottomShee.dart';
import '../colors.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(39.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("theme".tr(),
              style: TextStyle(
                  color: pro.appTheme == ThemeMode.light
                      ? Colors.black
                      : Colors.white)),
          SizedBox(height: 24),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return ThemeBottomSheet();
                },
              );
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: pro.appTheme == ThemeMode.light
                      ? Colors.white
                      : AppColors.darkprimary,
                  border: Border.all(color: AppColors.primary)),
              child: Text(
                "light".tr(),
                style: TextStyle(
                    color: pro.appTheme == ThemeMode.light
                        ? Colors.black
                        : Colors.white),
              ),
            ),
          ),
          SizedBox(height: 12),
          Text("language".tr(),
              style: TextStyle(
                  color: pro.appTheme == ThemeMode.light
                      ? Colors.black
                      : Colors.white)),
          SizedBox(height: 24),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                //isDismissible: false ,
                builder: (context) {
                  return LanguageBottomSheet();
                },
              );
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration:
                  BoxDecoration(border: Border.all(color: AppColors.primary)),
              child: Text(
                "arabic".tr(),
                style: TextStyle(
                    color: pro.appTheme == ThemeMode.light
                        ? Colors.black
                        : Colors.white),
              ),
            ),
          ),
          SizedBox(height: 50,),
          ElevatedButton(onPressed: (){
            FirebaseAuth.instance.signOut();
            Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName,(route) => false);
          }, child: Text("logout".tr(), style: TextStyle(color:Colors.white),),
    style: ElevatedButton.styleFrom(backgroundColor:pro.appTheme==ThemeMode.light?AppColors.primary:AppColors.darkprimary,shape: RoundedRectangleBorder(borderRadius:BorderRadius.zero)),
          )
        ],
      ),
    );
  }
}
