import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Models/Task_model.dart';
import 'package:todo_app/colors.dart';
import 'package:todo_app/firebase_functions.dart';
import 'package:todo_app/task_item.dart';

import '../Provider/myProvider.dart';

class TaskTab extends StatefulWidget {
   TaskTab({super.key});

  @override
  State<TaskTab> createState() => _TaskTabState();
}

class _TaskTabState extends State<TaskTab> {
   DateTime date=DateTime.now();

  @override
  Widget build(BuildContext context) {
    var pro= Provider.of<MyProvider>(context);
    return Column(
      children: [
        CalendarTimeline(
          initialDate: date,
          firstDate: DateTime.now().subtract(Duration(days: 365)),
          lastDate: DateTime.now().add(Duration(days: 365)),
          onDateSelected: (dateTime) {
            date=dateTime;
            setState(() {

            });
          },
          leftMargin: 20,

          monthColor: Colors.blueGrey,
          dayColor: AppColors.primary,
          activeDayColor: Colors.white,
          activeBackgroundDayColor: AppColors.primary,
          dotColor: Colors.white,
          selectableDayPredicate: (date) => date.day != 23,
          locale: pro.appLocale.languageCode,
        ),
        SizedBox(
          height: 24,
        ),
        StreamBuilder(
          stream: FirebaseFunctions.getTasks(date),
          builder: (context, snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting){
              return CircularProgressIndicator();
            }
            if(snapshot.hasError){
              return Center(
                child: Column(
                  children: [
                    Text("Something went wrong !"),
                    ElevatedButton(onPressed: (){}, child: Text("Try again"))
                  ],
                ),

              );
            }
            var tasks= snapshot.data?.docs.map((doc) => doc.data()).toList()??[];
            if (tasks.isEmpty){
              return Center(child: Text("No tasks"));
            }
            return  Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => SizedBox(height:12)
                ,itemBuilder:(context, index) {
                return TaskItem(taskModel:tasks[index],);
              },
                itemCount: tasks.length,),
            );
          },
        )

      ],
    );
  }
}
