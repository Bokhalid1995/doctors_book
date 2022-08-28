class User {
  int? id;
  String? userName;
  String? password;
  String? userType;

  int? createdBy;
  int? hospitalsId;

  User(
      {this.id,
      this.userName,
      this.password,
      this.userType,
      this.createdBy,
      this.hospitalsId});

  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json['id'],
      userName: json['userName'],
      password: json['password'],
      hospitalsId: json['hospitalsId'],
      userType: json['userType']);

  Map<String, dynamic> toJson() => {
        "userName": userName,
        "password": password,
        "userType": userType,
        "hospitalsId": hospitalsId,
        "createdBy": createdBy
      };
}
