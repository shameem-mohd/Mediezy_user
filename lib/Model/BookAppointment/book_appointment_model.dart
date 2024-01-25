class BookAppointmentModel {
  bool? success;
  TokenBooking? tokenBooking;
  String? code;
  String? message;

  BookAppointmentModel(
      {this.success, this.tokenBooking, this.code, this.message});

  BookAppointmentModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    tokenBooking = json['TokenBooking'] != null
        ? new TokenBooking.fromJson(json['TokenBooking'])
        : null;
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.tokenBooking != null) {
      data['TokenBooking'] = this.tokenBooking!.toJson();
    }
    data['code'] = this.code;
    data['message'] = this.message;
    return data;
  }
}

class TokenBooking {
  String? bookedPersonId;
  String? patientName;
  String? gender;
  String? age;
  String? mobileNo;
  String? appoinmentforId;
  String? date;
  String? tokenNumber;
  String? tokenTime;
  String? endTokenTime;
  String? doctorId;
  String? whenitstart;
  String? whenitcomes;
  String? regularmedicine;
  String? bookingtime;
  String? clinicId;
  String? updatedAt;
  String? createdAt;
  int? id;

  TokenBooking(
      {this.bookedPersonId,
      this.patientName,
      this.gender,
      this.age,
      this.mobileNo,
      this.appoinmentforId,
      this.date,
      this.tokenNumber,
      this.tokenTime,
      this.endTokenTime,
      this.doctorId,
      this.whenitstart,
      this.whenitcomes,
      this.regularmedicine,
      this.bookingtime,
      this.clinicId,
      this.updatedAt,
      this.createdAt,
      this.id});

  TokenBooking.fromJson(Map<String, dynamic> json) {
    bookedPersonId = json['BookedPerson_id'];
    patientName = json['PatientName'];
    gender = json['gender'];
    age = json['age'];
    mobileNo = json['MobileNo'];
    appoinmentforId = json['Appoinmentfor_id'];
    date = json['date'];
    tokenNumber = json['TokenNumber'];
    tokenTime = json['TokenTime'];
    endTokenTime = json['EndTokenTime'];
    doctorId = json['doctor_id'];
    whenitstart = json['whenitstart'];
    whenitcomes = json['whenitcomes'];
    regularmedicine = json['regularmedicine'];
    bookingtime = json['Bookingtime'];
    clinicId = json['clinic_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BookedPerson_id'] = this.bookedPersonId;
    data['PatientName'] = this.patientName;
    data['gender'] = this.gender;
    data['age'] = this.age;
    data['MobileNo'] = this.mobileNo;
    data['Appoinmentfor_id'] = this.appoinmentforId;
    data['date'] = this.date;
    data['TokenNumber'] = this.tokenNumber;
    data['TokenTime'] = this.tokenTime;
    data['EndTokenTime'] = this.endTokenTime;
    data['doctor_id'] = this.doctorId;
    data['whenitstart'] = this.whenitstart;
    data['whenitcomes'] = this.whenitcomes;
    data['regularmedicine'] = this.regularmedicine;
    data['Bookingtime'] = this.bookingtime;
    data['clinic_id'] = this.clinicId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
