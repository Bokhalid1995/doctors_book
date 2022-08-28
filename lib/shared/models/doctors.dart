class DoctorsModel {
  int? id;
  String? doctorName;
  int? specializeId;
  String? qualifiedCert;
  String? specializeName;

  DoctorsModel(
      {this.id,
      this.doctorName,
      this.specializeId,
      this.qualifiedCert,
      this.specializeName});

  factory DoctorsModel.fromJson(Map<String, dynamic> json) => DoctorsModel(
        id: json['id'],
        doctorName: json['doctorName'],
        specializeId: json['specializeId'],
        specializeName: json['specializeName'],
        qualifiedCert: json['qualifiedCert'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "doctorName": doctorName,
        "specializeId": specializeId,
        "specializeName": specializeName,
        "qualifiedCert": qualifiedCert,
      };
}
