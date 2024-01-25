class EditUserModel {
  EditUserModel({
      this.success, 
      this.users, 
      this.code, 
      this.message,});

  EditUserModel.fromJson(dynamic json) {
    success = json['success'];
    users = json['users'] != null ? Users.fromJson(json['users']) : null;
    code = json['code'];
    message = json['message'];
  }
  bool? success;
  Users? users;
  String? code;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (users != null) {
      map['users'] = users?.toJson();
    }
    map['code'] = code;
    map['message'] = message;
    return map;
  }

}

class Users {
  Users({
      this.id, 
      this.firstname, 
      this.email, 
      this.emailVerifiedAt, 
      this.createdAt, 
      this.updatedAt, 
      this.userRole, 
      this.mobileNo, 
      this.secondname,});

  Users.fromJson(dynamic json) {
    id = json['id'];
    firstname = json['firstname'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userRole = json['user_role'];
    mobileNo = json['mobileNo'];
    secondname = json['secondname'];
  }
  int? id;
  String? firstname;
  String? email;
  dynamic emailVerifiedAt;
  dynamic createdAt;
  String? updatedAt;
  String? userRole;
  String? mobileNo;
  String? secondname;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['firstname'] = firstname;
    map['email'] = email;
    map['email_verified_at'] = emailVerifiedAt;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['user_role'] = userRole;
    map['mobileNo'] = mobileNo;
    map['secondname'] = secondname;
    return map;
  }

}