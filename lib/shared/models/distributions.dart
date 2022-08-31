class DistributionsModel {
  int? id;
  int? hospitalsId;
  int? doctorsId;
  int? userId;
  String? hospitalsName;
  String? specializeName;
  int? specializeId;
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
      this.specializeId,
      this.specializeName,
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
          specializeName: json['specializeName'],
          specializeId: json['specializeId'],
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
        "specializeName": specializeName,
        "specializeId": specializeId,
        "day": day
      };
}
