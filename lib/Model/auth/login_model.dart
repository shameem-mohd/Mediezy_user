class LoginModel {
  User? user;
  String? token;
  String? role;

  LoginModel({this.user, this.token, this.role});

  LoginModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    token = json['token'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['token'] = token;
    data['role'] = role;
    return data;
  }
}

class User {
  int? id;
  String? firstname;
  String? email;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  String? userRole;
  String? mobileNo;
  String? secondname;

  User(
      {this.id,
      this.firstname,
      this.email,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt,
      this.userRole,
      this.mobileNo,
      this.secondname});

  User.fromJson(Map<String, dynamic> json) {
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstname'] = firstname;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['user_role'] = userRole;
    data['mobileNo'] = mobileNo;
    data['secondname'] = secondname;
    return data;
  }
}
