class TaskModel {
  String title;
  String subtitle;
  String id;
  bool isdone;
  int date;
  String userId;

  TaskModel({required this.title,
    required this.subtitle,
    this.id = "",
    this.isdone = false,
    required this.date,
  required this.userId});

  TaskModel.fromJson(Map<String, dynamic> json) :this(
      title: json['title'],
      subtitle: json['subtitle'],
      date: json['date'],
      id: json['id'],
      userId: json['userId'],
      isdone: json['isdone']
  );

  Map<String, dynamic> toJSon() {
    return {
      "title": title,
      "subtitle": subtitle,
      "date": date,
      "id": id,
      "userId": userId,
      "isdone": isdone
    };
  }
}
