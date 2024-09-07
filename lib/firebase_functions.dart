import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/Models/Task_model.dart';
import 'package:todo_app/Models/User_Modle.dart';

class FirebaseFunctions {
  static CollectionReference<TaskModel> getTasksCollection() {
    return FirebaseFirestore.instance
        .collection("Tasks")
        .withConverter<TaskModel>(
      fromFirestore: (snapshot, _) {
        return TaskModel.fromJson(snapshot.data()!);
      },
      toFirestore: (task, _) {
        return task.toJSon();
      },
    );
  }
  static CollectionReference<UserModel> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection("Users")
        .withConverter<UserModel>(
      fromFirestore: (snapshot, _) {
        return UserModel.fromjson(snapshot.data()!);
      },
      toFirestore: (user, _) {
        return user.tojson();
      },
    );
  }

  static addUser(UserModel usermodel){
    var collection=getUsersCollection();
    var docRef=collection.doc(usermodel.id);
    docRef.set(usermodel);
  }
  static Future<UserModel?> readUserData()async{
var collection=getUsersCollection();
DocumentSnapshot<UserModel> docUser= await collection.doc(FirebaseAuth.instance.currentUser!.uid).get();
return docUser.data();
  }
  static Future<void> addTask(TaskModel task) {
    var collection = getTasksCollection(); //to create a collection
    var docRef = collection.doc(); //to create a doc
    task.id = docRef.id; //to set the auto id generated to the task
    return docRef.set(task); //to add attributes
  }

  static Stream<QuerySnapshot<TaskModel>> getTasks(DateTime date) {
    var collection = getTasksCollection();
    return collection.where("userId",isEqualTo:FirebaseAuth.instance.currentUser!.uid)
        .where("date",
            isEqualTo: DateUtils.dateOnly(date).millisecondsSinceEpoch)
        .snapshots();
  }

  static Future<void> deleteTask(String id) {
    return getTasksCollection().doc(id).delete();
  }

  static Future<void> updateTask(TaskModel taskModel) {
    return getTasksCollection().doc(taskModel.id).update(taskModel.toJSon());
  }

  static createAccount(String emailAddress, String password,
      {required Function onSuccess, required Function onError,required String username, required String phone ,  required int age}) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      credential.user?.sendEmailVerification();
      UserModel userModel= UserModel(id:credential.user!.uid,username:username , phone:phone , email: emailAddress, age:age );
      addUser(userModel);
      onSuccess();
    } on FirebaseAuthException catch (e) {
      onError(e.message);
    } catch (e) {
      onError(e.toString());
    }
  }

  static Login(String emailAddress, String password,
      {required Function onSuccess, required Function onError}) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      onSuccess();
      // if(credential.user?.emailVerified==true){
      //   onSuccess();
      // }
      // else{
      //   onError("Please check your Mail and Verify");
      // }

    } on FirebaseAuthException catch (e) {
onError(e.message);
    }
  }
}
