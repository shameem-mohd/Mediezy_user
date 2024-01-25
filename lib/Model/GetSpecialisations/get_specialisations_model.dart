class GetSpecialisationsModel {
  bool? success;
  List<Specializations>? specializations;
  String? code;
  String? message;

  GetSpecialisationsModel(
      {this.success, this.specializations, this.code, this.message});

  GetSpecialisationsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['specializations'] != null) {
      specializations = <Specializations>[];
      json['specializations'].forEach((v) {
        specializations!.add(Specializations.fromJson(v));
      });
    }
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (specializations != null) {
      data['specializations'] =
          specializations!.map((v) => v.toJson()).toList();
    }
    data['code'] = code;
    data['message'] = message;
    return data;
  }
}

class Specializations {
  int? id;
  String? specialization;
  String? specializeimage;

  Specializations({this.id, this.specialization, this.specializeimage});

  Specializations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    specialization = json['specialization'];
    specializeimage = json['specializeimage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['specialization'] = specialization;
    data['specializeimage'] = specializeimage;
    return data;
  }
}
