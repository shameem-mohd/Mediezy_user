class GetMemberAsPerIdModel {
  bool? status;
  PatientData? patientData;

  GetMemberAsPerIdModel({this.status, this.patientData});

  GetMemberAsPerIdModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    patientData = json['patient_data'] != null
        ? PatientData.fromJson(json['patient_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (patientData != null) {
      data['patient_data'] = patientData!.toJson();
    }
    return data;
  }
}

class PatientData {
  int? id;
  String? firstname;
  String? mobileNo;
  String? gender;
  String? email;
  int? age;

  PatientData(
      {this.id,
      this.firstname,
      this.mobileNo,
      this.gender,
      this.email,
      this.age});

  PatientData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    mobileNo = json['mobileNo'];
    gender = json['gender'];
    email = json['email'];
    age = json['age'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstname'] = firstname;
    data['mobileNo'] = mobileNo;
    data['gender'] = gender;
    data['email'] = email;
    data['age'] = age;
    return data;
  }
}
