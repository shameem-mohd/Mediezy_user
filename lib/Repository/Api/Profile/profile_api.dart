import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:mediezy_user/Model/Profile/edit_user_model.dart';
import 'package:mediezy_user/Model/Profile/get_user_model.dart';
import 'package:mediezy_user/Repository/Api/ApiClient.dart';
import 'package:mediezy_user/Repository/Api/MultiFileApiClient.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileApi {
  ApiClient apiClient = ApiClient();
  MultiFileApiClient multiFileApiClient = MultiFileApiClient();

  //* get user details
  Future<GetUserModel> getUserDetails() async {
    final preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userId');
    String basePath = "Useredit/$userId";
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "GET", body: null);
    print("<<<<<<<<Get User WORKED>>>>>>");
    return GetUserModel.fromJson(
      json.decode(response.body),
    );
  }

  //* edit user details
  Future<EditUserModel> editUserDetails({
    // Future<EditProfileModel> getEditProfile({
    required String firstName,
    required String secondName,
    required String email,
    required String mobileNo,
    required String location,
    required String gender,
  }) async {
    final preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userId');
    String basePath = "Userupdate/$userId";
    final body = {
      "firstname": firstName,
      "secondname": secondName,
      "email": email,
      "mobileNo": mobileNo,
      "location": location,
      "gender": gender,
    };

    Response response =
        await apiClient.invokeAPI(path: basePath, method: "PUT", body: body);
    print(body);
    return EditUserModel.fromJson(json.decode(response.body));
  }

  // Future<String> uploadUserImage({required File userImage}) async {
  //   String? userId;
  //   final preference = await SharedPreferences.getInstance();
  //   userId = preference.getString('userId').toString();
  //   String basePath = "UserDP/$userId";
  //   final body = {"user_image": userImage};
  //   print(body);
  //   Response response = await multiFileApiClient.uploadFiles(
  //       uploadPath: basePath, bodyData: body, files: userImage);
  //   print("<<<<<< UPLOAD USER IMAGE WORKED >>>>>>");
  //   return response.body;
  // }
  Future<String> uploadUserImage({required File userImage}) async {
    String? userId;
    final preference = await SharedPreferences.getInstance();
    userId = preference.getString('userId').toString();
    String basePath = "UserDP/$userId";
    final body = {"user_image": userImage};
    print(body);
    try {
      Response response = await multiFileApiClient.uploadFiles(
        uploadPath: basePath,
        bodyData: body,
        files: userImage,
      );
      print("<<<<<< UPLOAD USER IMAGE WORKED >>>>>>");
      return response.body;
    } catch (error) {
      print("<<<<<<<<<<UploadUserImageError>>>>>>>>>>" + error.toString());
      throw error; // Rethrow the error to handle it in the Bloc
    }
  }
}
