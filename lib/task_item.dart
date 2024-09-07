import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Models/Task_model.dart';
import 'package:todo_app/Provider/myProvider.dart';
import 'package:todo_app/colors.dart';
import 'package:todo_app/editScreen.dart';
import 'package:todo_app/firebase_functions.dart';

class TaskItem extends StatelessWidget {
  TaskModel taskModel;
  TaskItem({required this.taskModel, super.key});

  @override
  Widget build(BuildContext context) {
    var pro= Provider.of<MyProvider>(context);
    return Container(
        height: 115,
        margin: EdgeInsets.symmetric(horizontal: 12),
        width: double.infinity,
        decoration: BoxDecoration(
            color: pro.appTheme==ThemeMode.light?Colors.white:AppColors.darkprimary, borderRadius: BorderRadius.circular(25)),
        child: Slidable(
          startActionPane:
              ActionPane(motion: DrawerMotion(), extentRatio: .6, children: [
            SlidableAction(
              onPressed: (context) {
                FirebaseFunctions.deleteTask(taskModel.id);
              },
              label: "Delete",
              backgroundColor: Colors.red,
              icon: Icons.delete,
              spacing: 8,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  bottomLeft: Radius.circular(25)),
            ),
            SlidableAction(
              onPressed: (context) {
                Navigator.pushNamed(context, EditScreen.routeName,  arguments: taskModel);
              },
              label: "Edit",
              backgroundColor: Colors.blue,
              icon: Icons.edit,
              spacing: 8,
              padding: EdgeInsets.zero,
              borderRadius: BorderRadius.only(
                  // topRight: Radius.circular(25),
                  // bottomRight: Radius.circular(25)
                  ),
            ),
          ]),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  height: 80,
                  width: 4,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color:
                      taskModel.isdone?Colors.green:AppColors.primary),
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                       taskModel.title,
                        style:
                            TextStyle(fontSize: 18, color: taskModel.isdone?Colors.green:AppColors.primary),
                      ),
                      Text(
                        taskModel.subtitle,
                        style: TextStyle(fontSize: 14, color: AppColors.grey),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                taskModel.isdone?Text("Done", style: TextStyle(fontSize: 22, color: Colors.green),): ElevatedButton(

                  onPressed: () {
                    taskModel.isdone=true;
                    FirebaseFunctions.updateTask(taskModel);

                  },
                  child: Icon(
                    Icons.done,
                    size: 21,
                    color: taskModel.isdone?Colors.green:Colors.white,
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                )
              ],
            ),
          ),
        ));
  }
}
