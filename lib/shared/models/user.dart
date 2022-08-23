class User {
  int? id;
  String? userName;
  String? password;
  String? userType;

  int? createdBy;

  User({this.id, this.userName, this.password, this.userType, this.createdBy});

  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json['id'],
      userName: json['userName'],
      password: json['password'],
      userType: json['userType']);

  Map<String, dynamic> toJson() => {
        "userName": userName,
        "password": password,
        "userType": userType,
        "createdBy": createdBy
      };
}
