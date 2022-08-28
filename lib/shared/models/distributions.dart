class DistributionsModel {
  int? id;
  int? hospitalsId;
  int? doctorsId;
  int? userId;
  String? hospitalsName;
  String? doctorsName;
  int? timeFrom;
  int? timeTo;
  String? day;

  DistributionsModel(
      {this.id,
      this.hospitalsId,
      this.doctorsId,
      this.userId,
      this.timeFrom,
      this.timeTo,
      this.hospitalsName,
      this.doctorsName,
      this.day});

  factory DistributionsModel.fromJson(Map<String, dynamic> json) =>
      DistributionsModel(
          id: json['id'],
          hospitalsId: json['hospitalsId'],
          doctorsId: json['doctorsId'],
          hospitalsName: json['hospitalsName'],
          doctorsName: json['doctorsName'],
          userId: json['userId'],
          day: json['day'],
          timeTo: json['timeTo'],
          timeFrom: json['timeFrom']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "hospitalsId": hospitalsId,
        "doctorsId": doctorsId,
        "hospitalsName": hospitalsName,
        "doctorsName": doctorsName,
        "userId": userId,
        "timeFrom": timeFrom,
        "timeTo": timeTo,
        "day": day
      };
}
