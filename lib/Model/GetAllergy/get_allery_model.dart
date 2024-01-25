class GetAllergyModel {
  bool? status;
  List<Allergies>? allergies;
  String? message;

  GetAllergyModel({this.status, this.allergies, this.message});

  GetAllergyModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['Allergies'] != null) {
      allergies = <Allergies>[];
      json['Allergies'].forEach((v) {
        allergies!.add(Allergies.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (allergies != null) {
      data['Allergies'] = allergies!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class Allergies {
  int? id;
  String? allergy;
  String? createdAt;
  String? updatedAt;

  Allergies({this.id, this.allergy, this.createdAt, this.updatedAt});

  Allergies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    allergy = json['allergy'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['allergy'] = allergy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
