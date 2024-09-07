import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Models/Task_model.dart';
import 'package:todo_app/Provider/myProvider.dart';
import 'package:todo_app/colors.dart';

import '../firebase_functions.dart';

class AddtaskBottomsheet extends StatefulWidget {
  const AddtaskBottomsheet({super.key});

  @override
  State<AddtaskBottomsheet> createState() => _AddtaskBottomsheetState();
}

class _AddtaskBottomsheetState extends State<AddtaskBottomsheet> {
  DateTime SelectedDate = DateTime.now();
  var titleController = TextEditingController();
  var subTitleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var pro=Provider.of<MyProvider>(context);
    return Container(
        padding: const EdgeInsets.all(16),
        //height: MediaQuery.of(context).size.height* 0.5,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft:Radius.circular(25) , topRight:Radius.circular(25)),
          color: pro.appTheme==ThemeMode.light?
          Colors.white
              :
          AppColors.darkprimary
        ),

          child: Column(

          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "add New Task".tr(),
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: pro.appTheme==ThemeMode.light?Colors.black:Colors.white),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 24,
            ),
            TextFormField(
              style: TextStyle(color: pro.appTheme==ThemeMode.light? Colors.black: Colors.white),
              controller: titleController,
              decoration: InputDecoration(
                  label: Text("title".tr(), style: TextStyle(color: pro.appTheme==ThemeMode.light?Colors.black:Colors.white),),
                  border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18))),
            ),
            SizedBox(
              height: 18,
            ),
            TextFormField(
              style: TextStyle(color: pro.appTheme==ThemeMode.light? Colors.black: Colors.white),
              controller: subTitleController,
              decoration: InputDecoration(
                  label: Text("task details".tr(), style: TextStyle(color: pro.appTheme==ThemeMode.light?Colors.black:Colors.white),),
                  border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18))),
            ),
            SizedBox(
              height: 18,
            ),
            Text(
              "select Time".tr(),
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: pro.appTheme==ThemeMode.light?Colors.black:Colors.white),
            ),
            InkWell(
              onTap: () {
                SelectDateFun();
              },
              child: Text(
                SelectedDate.toString().substring(0, 10),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    color: AppColors.primary),
              ),
            ),
            ElevatedButton(
              onPressed: ()  {
                TaskModel task = TaskModel(
                  userId: FirebaseAuth.instance.currentUser!.uid,
                    title: titleController.text,
                    subtitle: subTitleController.text,
                    date: DateUtils.dateOnly(SelectedDate).millisecondsSinceEpoch);
         FirebaseFunctions.addTask(task);
          Navigator.pop(context);
              },
              child: Text("add task".tr(),
                  style: TextStyle(color: Colors.white, fontSize: 20)),
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            )
          ],
        )
    );
  }

  SelectDateFun() async {
    DateTime? choosenDate = await showDatePicker(
        context: context,
        builder: (context, child) => Theme(
              data: ThemeData.dark().copyWith(
                  colorScheme: ColorScheme.dark(
                      primary: AppColors.primary,
                      onPrimary: Colors.white,
                      surface:  Colors.white,
                      onSurface: Colors.black)),
              child: child!,
            ),
        initialDate: SelectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (choosenDate != null) {
      SelectedDate = choosenDate;
      setState(() {});
    }
  }
}
