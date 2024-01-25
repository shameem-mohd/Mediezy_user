class GetAllMembersModel {
  bool? status;
  List<PatientsData>? patientsData;

  GetAllMembersModel({this.status, this.patientsData});

  GetAllMembersModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['patients_data'] != null) {
      patientsData = <PatientsData>[];
      json['patients_data'].forEach((v) {
        patientsData!.add(PatientsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (patientsData != null) {
      data['patients_data'] =
          patientsData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PatientsData {
  int? id;
  String? firstname;
  int? age;
  String? gender;
  String? email;

  PatientsData({this.id, this.firstname, this.age, this.gender, this.email});

  PatientsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    age = json['age'];
    gender = json['gender'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstname'] = firstname;
    data['age'] = age;
    data['gender'] = gender;
    data['email'] = email;
    return data;
  }
}
