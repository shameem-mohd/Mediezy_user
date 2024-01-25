class SearchDoctorModel {
  bool? success;
  List<Docters>? docters;
  String? code;
  String? message;

  SearchDoctorModel({this.success, this.docters, this.code, this.message});

  SearchDoctorModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['Docters'] != null) {
      docters = <Docters>[];
      json['Docters'].forEach((v) {
        docters!.add(Docters.fromJson(v));
      });
    }
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (docters != null) {
      data['Docters'] = docters!.map((v) => v.toJson()).toList();
    }
    data['code'] = code;
    data['message'] = message;
    return data;
  }
}

class Docters {
  int? id;
  int? userId;
  String? firstname;
  String? secondname;
  String? specialization;
  String? docterImage;
  String? location;
  String? mainHospital;

  Docters(
      {this.id,
      this.userId,
      this.firstname,
      this.secondname,
      this.specialization,
      this.docterImage,
      this.location,
      this.mainHospital});

  Docters.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['UserId'];
    firstname = json['firstname'];
    secondname = json['secondname'];
    specialization = json['Specialization'];
    docterImage = json['DocterImage'];
    location = json['Location'];
    mainHospital = json['MainHospital'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['UserId'] = userId;
    data['firstname'] = firstname;
    data['secondname'] = secondname;
    data['Specialization'] = specialization;
    data['DocterImage'] = docterImage;
    data['Location'] = location;
    data['MainHospital'] = mainHospital;
    return data;
  }
}
