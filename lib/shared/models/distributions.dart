class DistributionsModel {
  int? id;
  int? hospitalsId;
  int? doctorsId;
  int? userId;
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
      this.day});

  factory DistributionsModel.fromJson(Map<String, dynamic> json) =>
      DistributionsModel(
          id: json['id'],
          hospitalsId: json['hospitalsId'],
          doctorsId: json['doctorsId'],
          userId: json['userId'],
          day: json['day'],
          timeTo: json['timeTo'],
          timeFrom: json['timeFrom']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "hospitalsId": hospitalsId,
        "doctorsId": doctorsId,
        "userId": userId,
        "timeFrom": timeFrom,
        "timeTo": timeTo,
        "day": day
      };
}
