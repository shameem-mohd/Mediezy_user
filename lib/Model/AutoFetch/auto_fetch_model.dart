class AutoFetchModel {
  bool? status;
  List<Details>? details;
  String? message;

  AutoFetchModel({this.status, this.details, this.message});

  AutoFetchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details!.add(new Details.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.details != null) {
      data['details'] = this.details!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Details {
  String? firstname;
  int? age;
  String? mobileNo;
  String? gender;

  Details({this.firstname, this.age, this.mobileNo, this.gender});

  Details.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    age = json['age'];
    mobileNo = json['mobileNo'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstname'] = this.firstname;
    data['age'] = this.age;
    data['mobileNo'] = this.mobileNo;
    data['gender'] = this.gender;
    return data;
  }
}
