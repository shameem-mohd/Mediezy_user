class GetFavouritesModel {
  bool? success;
  List<FavoriteDoctors>? favoriteDoctors;
  String? code;
  String? message;

  GetFavouritesModel(
      {this.success, this.favoriteDoctors, this.code, this.message});

  GetFavouritesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['Favorite Doctors'] != null) {
      favoriteDoctors = <FavoriteDoctors>[];
      json['Favorite Doctors'].forEach((v) {
        favoriteDoctors!.add(FavoriteDoctors.fromJson(v));
      });
    }
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (favoriteDoctors != null) {
      data['Favorite Doctors'] =
          favoriteDoctors!.map((v) => v.toJson()).toList();
    }
    data['code'] = code;
    data['message'] = message;
    return data;
  }
}

class FavoriteDoctors {
  int? id;
  int? userId;
  String? firstname;
  String? secondname;
  String? specialization;
  String? docterImage;
  String? location;
  String? mainHospital;

  FavoriteDoctors(
      {this.id,
      this.userId,
      this.firstname,
      this.secondname,
      this.specialization,
      this.docterImage,
      this.location,
      this.mainHospital});

  FavoriteDoctors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['UserId'];
    firstname = json['firstname'];
    secondname = json['secondname'];
    specialization = json['Specialization'];
    docterImage = json['DocterImage'];
    location = json['Location'];
    mainHospital = json['MainHospital'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['UserId'] = userId;
    data['firstname'] = firstname;
    data['secondname'] = secondname;
    data['Specialization'] = specialization;
    data['DocterImage'] = docterImage;
    data['Location'] = location;
    data['MainHospital'] = mainHospital;
    return data;
  }
}
