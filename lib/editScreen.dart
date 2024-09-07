import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Models/Task_model.dart';
import 'Provider/myProvider.dart';
import 'colors.dart';
import 'firebase_functions.dart';

class EditScreen extends StatefulWidget {
  static const String routeName = 'EditScreen';
  EditScreen({super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  DateTime selectedDate = DateTime.now();
  late TextEditingController titleController;
  late TextEditingController subTitleController;
  late TaskModel taskModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Retrieve the task data passed as arguments
    final args = ModalRoute.of(context)!.settings.arguments as TaskModel;
    taskModel = args;
    titleController = TextEditingController(text: taskModel.title);
    subTitleController = TextEditingController(text: taskModel.subtitle);
    selectedDate = DateTime.fromMillisecondsSinceEpoch(taskModel.date);
  }

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    return Scaffold(
      extendBody: true,
      backgroundColor: pro.appTheme == ThemeMode.light
          ? AppColors.secondary
          : AppColors.darkSecondary,
      appBar: AppBar(
        toolbarHeight: 170,
        backgroundColor: AppColors.primary,
        title: Column(
          children: [
            Text(
              "todo app",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: pro.appTheme == ThemeMode.light
                      ? Colors.white
                      : Colors.black),
            ),
            Text(
              " ${pro.userModel?.username}",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: pro.appTheme == ThemeMode.light
                      ? Colors.white
                      : Colors.black),
            ),
          ],
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: pro.appTheme == ThemeMode.light
            ? AppColors.secondary
            : AppColors.darkSecondary,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Card(
              margin: EdgeInsets.only(
                  bottom: 25, right: 18, left: 18, top: 18),
              color: pro.appTheme == ThemeMode.light
                  ? Colors.white
                  : AppColors.darkprimary,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "edit task".tr(),
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: pro.appTheme == ThemeMode.light
                              ? Colors.black
                              : Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    TextFormField(
                      controller: titleController,
                      decoration: InputDecoration(
                        label: Text(
                          "title".tr(),
                          style: TextStyle(
                              color: pro.appTheme == ThemeMode.light
                                  ? Colors.black
                                  : Colors.white),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18)),
                      ),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    TextFormField(
                      controller: subTitleController,
                      decoration: InputDecoration(
                        label: Text(
                          "task details".tr(),
                          style: TextStyle(
                              color: pro.appTheme == ThemeMode.light
                                  ? Colors.black
                                  : Colors.white),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18)),
                      ),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Text(
                      "select Time".tr(),
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: pro.appTheme == ThemeMode.light
                              ? Colors.black
                              : Colors.white),
                    ),
                    InkWell(
                      onTap: () {
                        selectDateFun();
                      },
                      child: Text(
                        selectedDate.toString().substring(0, 10),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                            color: AppColors.primary),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        TaskModel updatedTask = TaskModel(
                          userId: FirebaseAuth.instance.currentUser!.uid,
                          title: titleController.text,
                          subtitle: subTitleController.text,
                          date: DateUtils.dateOnly(selectedDate)
                              .millisecondsSinceEpoch,
                          id: taskModel.id, // Ensure to pass the task ID
                        );
                        FirebaseFunctions.updateTask(updatedTask);
                        Navigator.pop(context);
                      },
                      child: Text(
                        "save changes".tr(),
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  selectDateFun() async {
    DateTime? choosenDate = await showDatePicker(
      context: context,
      builder: (context, child) => Theme(
        data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
                primary: AppColors.primary,
                onPrimary: Colors.white,
                surface: Colors.white,
                onSurface: Colors.black)),
        child: child!,
      ),
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (choosenDate != null) {
      setState(() {
        selectedDate = choosenDate;
      });
    }
  }
}
