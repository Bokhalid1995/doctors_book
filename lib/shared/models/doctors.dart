class DoctorsModel {
  int? id;
  String? doctorName;
  int? specializeId;
  String? qualifiedCert;

  DoctorsModel(
      {this.id, this.doctorName, this.specializeId, this.qualifiedCert});

  factory DoctorsModel.fromJson(Map<String, dynamic> json) => DoctorsModel(
        id: json['id'],
        doctorName: json['doctorName'],
        specializeId: json['specializeId'],
        qualifiedCert: json['qualifiedCert'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "doctorName": doctorName,
        "specializeId": specializeId,
        "qualifiedCert": qualifiedCert,
      };
}
