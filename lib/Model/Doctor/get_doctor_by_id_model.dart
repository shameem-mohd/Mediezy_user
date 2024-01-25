

import 'package:mediezy_user/Model/Clinics/clinic_model.dart';

class GetDoctorByIdModel {
  bool? success;
  List<Docter>? docter;
  String? code;
  String? message;

  GetDoctorByIdModel({this.success, this.docter, this.code, this.message});

  GetDoctorByIdModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['Docter'] != null) {
      docter = <Docter>[];
      json['Docter'].forEach((v) {
        docter!.add(Docter.fromJson(v));
      });
    }
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (docter != null) {
      data['Docter'] = docter!.map((v) => v.toJson()).toList();
    }
    data['code'] = code;
    data['message'] = message;
    return data;
  }
}

class Docter {
  int? id;
  int? userId;
  String? firstname;
  String? secondname;
  String? specialization;
  String? docterImage;
  String? about;
  String? location;
  String? gender;
  String? emailID;
  String? mobileNumber;
  String? mainHospital;
  String? subspecificationId;
  String? specificationId;
  List<String>? specifications;
  List<String>? subspecifications;
  List<Clincs>? clincs;
  int? favoriteStatus;

  Docter(
      {this.id,
      this.userId,
      this.firstname,
      this.secondname,
      this.specialization,
      this.docterImage,
      this.about,
      this.location,
      this.gender,
      this.emailID,
      this.mobileNumber,
      this.mainHospital,
      this.subspecificationId,
      this.specificationId,
      this.specifications,
      this.subspecifications,
      this.clincs,
      this.favoriteStatus});

  Docter.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['UserId'];
    firstname = json['firstname'];
    secondname = json['secondname'];
    specialization = json['Specialization'];
    docterImage = json['DocterImage'];
    about = json['About'];
    location = json['Location'];
    gender = json['Gender'];
    emailID = json['emailID'];
    mobileNumber = json['Mobile Number'];
    mainHospital = json['MainHospital'];
    subspecificationId = json['subspecification_id'];
    specificationId = json['specification_id'];
    specifications = json['specifications'].cast<String>();
    subspecifications = json['subspecifications'].cast<String>();
    if (json['clincs'] != null) {
      clincs = <Clincs>[];
      json['clincs'].forEach((v) {
        clincs!.add(Clincs.fromJson(v));
      });
    }
    favoriteStatus = json['favoriteStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['UserId'] = userId;
    data['firstname'] = firstname;
    data['secondname'] = secondname;
    data['Specialization'] = specialization;
    data['DocterImage'] = docterImage;
    data['About'] = about;
    data['Location'] = location;
    data['Gender'] = gender;
    data['emailID'] = emailID;
    data['Mobile Number'] = mobileNumber;
    data['MainHospital'] = mainHospital;
    data['subspecification_id'] = subspecificationId;
    data['specification_id'] = specificationId;
    data['specifications'] = specifications;
    data['subspecifications'] = subspecifications;
    if (clincs != null) {
      data['clincs'] = clincs!.map((v) => v.toJson()).toList();
    }
    data['favoriteStatus'] = favoriteStatus;
    return data;
  }
}
