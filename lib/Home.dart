import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Provider/myProvider.dart';
import 'package:todo_app/Register/LoginScreen.dart';
import 'package:todo_app/bottom_sheets/addTask_bottomsheet.dart';
import 'package:todo_app/colors.dart';
import 'package:todo_app/tabs/settings_tab.dart';
import 'package:todo_app/tabs/task_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home screen";
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;


  @override
  Widget build(BuildContext context) {
    var pro= Provider.of<MyProvider>(context);
    return Scaffold(
      extendBody: true,
      backgroundColor:
      pro.appTheme==ThemeMode.light?
      AppColors.secondary:
      AppColors.darkSecondary,
      appBar: AppBar(
        // actions: [IconButton(onPressed: (){
        //   FirebaseAuth.instance.signOut();
        //   Navigator.pushNamedAndRemoveUntil(context,LoginScreen.routeName, (route)=>false);
        // }, icon: Icon(Icons.logout))
        // ],
        toolbarHeight: 100,
        backgroundColor: AppColors.primary,
        title: Column(
          children: [
            Text(
              "todo app".tr(),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color:pro.appTheme==ThemeMode.light?
                Colors.white:
                Colors.black),),
            Text(
              " ${pro.userModel?.username}",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color:pro.appTheme==ThemeMode.light?
              Colors.white:
              Colors.black),),
          ],
      ),
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: AddtaskBottomsheet(),
            ),
            isScrollControlled: true
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
            side: BorderSide(color: pro.appTheme==ThemeMode.light?
            Colors.white:
                AppColors.darkprimary, width: 4)),
      ),
      bottomNavigationBar: BottomAppBar(
        color: pro.appTheme==ThemeMode.light?
            Colors.white:
          AppColors.darkprimary,

        shadowColor:AppColors.elevationcolor,
        notchMargin: 8,
        padding: EdgeInsets.zero,
        shape: CircularNotchedRectangle(),
        child: BottomNavigationBar(
            elevation: 0,

            backgroundColor: Colors.transparent,
            selectedItemColor: AppColors.primary,
            unselectedItemColor:pro.appTheme==ThemeMode.light?AppColors.grey:Colors.white,
            showUnselectedLabels: false,
            currentIndex: selectedIndex,
            onTap: (value) {
              selectedIndex = value;
              setState(() {});
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "home".tr()),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: "settings".tr())
            ]),
      ),
      body: tabs[selectedIndex],
    );
  }

  List<Widget> tabs = [TaskTab(), SettingsTab()];
}
