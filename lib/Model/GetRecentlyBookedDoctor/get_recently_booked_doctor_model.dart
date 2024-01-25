import 'package:mediezy_user/Model/Clinics/clinic_model.dart';

class GetRecentlyBookedDoctorModel {
  bool? status;
  List<DoctorData>? doctorData;
  String? message;

  GetRecentlyBookedDoctorModel({this.status, this.doctorData, this.message});

  GetRecentlyBookedDoctorModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['doctor_data'] != null) {
      doctorData = <DoctorData>[];
      json['doctor_data'].forEach((v) {
        doctorData!.add(DoctorData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (doctorData != null) {
      data['doctor_data'] = doctorData!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class DoctorData {
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

  DoctorData(
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

  DoctorData.fromJson(Map<String, dynamic> json) {
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

// class Clincs {
//   int? id;
//   String? name;
//   String? startingTime;
//   String? endingTime;
//   String? address;
//   String? location;

//   Clincs(
//       {this.id,
//       this.name,
//       this.startingTime,
//       this.endingTime,
//       this.address,
//       this.location});

//   Clincs.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     startingTime = json['StartingTime'];
//     endingTime = json['EndingTime'];
//     address = json['Address'];
//     location = json['Location'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['name'] = name;
//     data['StartingTime'] = startingTime;
//     data['EndingTime'] = endingTime;
//     data['Address'] = address;
//     data['Location'] = location;
//     return data;
//   }
// }
