class GetUserModel {
  bool? success;
  Userdetails? userdetails;
  String? code;
  String? message;

  GetUserModel({this.success, this.userdetails, this.code, this.message});

  GetUserModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    userdetails = json['Userdetails'] != null
        ? Userdetails.fromJson(json['Userdetails'])
        : null;
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (userdetails != null) {
      data['Userdetails'] = userdetails!.toJson();
    }
    data['code'] = code;
    data['message'] = message;
    return data;
  }
}

class Userdetails {
  int? id;
  String? firstname;
  String? lastname;
  int? age;
  String? userImage;
  String? mobileNo;
  String? gender;
  String? location;
  String? email;
  int? userId;
  String? createdAt;
  String? updatedAt;
  int? userType;
  String? userProfile;

  Userdetails(
      {this.id,
      this.firstname,
      this.lastname,
      this.age,
      this.userImage,
      this.mobileNo,
      this.gender,
      this.location,
      this.email,
      this.userId,
      this.createdAt,
      this.updatedAt,
      this.userType,
      this.userProfile});

  Userdetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    age = json['age'];
    userImage = json['user_image'];
    mobileNo = json['mobileNo'];
    gender = json['gender'];
    location = json['location'];
    email = json['email'];
    userId = json['UserId'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userType = json['user_type'];
    userProfile = json['UserProfile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['age'] = age;
    data['user_image'] = userImage;
    data['mobileNo'] = mobileNo;
    data['gender'] = gender;
    data['location'] = location;
    data['email'] = email;
    data['UserId'] = userId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['user_type'] = userType;
    data['UserProfile'] = userProfile;
    return data;
  }
}
