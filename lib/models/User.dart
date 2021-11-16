class User {
  int id;
  String name;
  String userName;
  String email;
  String phone;

  User({this.id, this.name, this.userName, this.email, this.phone});

  factory User.fromJson(dynamic json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      userName: json['username'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
    );
  }
}
