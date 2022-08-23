class SpecializesModel {
  int? id;
  String? name;
  String? description;

  SpecializesModel({this.id, this.name, this.description});

  factory SpecializesModel.fromJson(Map<String, dynamic> json) =>
      SpecializesModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
      };
}
