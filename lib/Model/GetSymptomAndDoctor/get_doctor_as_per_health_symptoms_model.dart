class GetDoctorAsPerHealthSymptomsModel {
  bool? status;
  List<Data>? data;
  String? message;

  GetDoctorAsPerHealthSymptomsModel({this.status, this.data, this.message});

  GetDoctorAsPerHealthSymptomsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class Data {
  int? id;
  int? userid;
  String? firstname;
  String? secondname;
  String? location;
  String? mainHospital;
  String? docterImage;
  String? specialization;

  Data(
      {this.id,
      this.userid,
      this.firstname,
      this.secondname,
      this.location,
      this.mainHospital,
      this.docterImage,
      this.specialization});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userid = json['userid'];
    firstname = json['firstname'];
    secondname = json['secondname'];
    location = json['location'];
    mainHospital = json['MainHospital'];
    docterImage = json['docter_image'];
    specialization = json['Specialization'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userid'] = userid;
    data['firstname'] = firstname;
    data['secondname'] = secondname;
    data['location'] = location;
    data['MainHospital'] = mainHospital;
    data['docter_image'] = docterImage;
    data['Specialization'] = specialization;
    return data;
  }
}
