class HospitalsModel {
  int? id;
  String? name;
  String? location;
  String? description;
  String? phone;

  HospitalsModel(
      {this.id, this.name, this.location, this.description, this.phone});

  factory HospitalsModel.fromJson(Map<String, dynamic> json) => HospitalsModel(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      description: json['description'],
      phone: json['phone']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "location": location,
        "description": description,
        "phone": phone
      };
}
