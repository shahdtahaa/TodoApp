class UserModel {
  String id;
  String username;
  String phone;
  String email;
  int age;

  UserModel({
    this.id="",
    required this.username,
    required this.phone,
    required this.email,
    required this.age});

 UserModel.fromjson(Map<String, dynamic>json):this(
    username: json['username'],
    phone: json['phone'],
    email: json['email'],
    id: json['id'],
    age: json['age']
);

  Map<String, dynamic> tojson(){
    return{
      "username": username,
      "phone": phone,
      "email": email,
      "id": id,
      "age": age
    };
  }
}