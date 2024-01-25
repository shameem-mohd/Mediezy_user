import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:mediezy_user/Model/auth/login_model.dart';
import 'package:mediezy_user/Model/auth/sign_up_model.dart';
import 'package:mediezy_user/Repository/Api/ApiClient.dart';
import 'package:mediezy_user/Repository/Api/MultiApiClientForRegister.dart';

class LoginAndSignUpApi {
  ApiClient apiClient = ApiClient();
  MultiFileApiClientRegister multiFileApiClientRegister =
      MultiFileApiClientRegister();
  //* login
  Future<LoginModel> login(
      {required String email, required String password}) async {
    String basePath = "auth/login";
    final body = {"email": email, "password": password};
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
    print(body);
    print("Login response worked");
    return LoginModel.fromJson(json.decode(response.body));
  }

  Future<SignUpModel> signUp(
    File? userImage, {
    required String firstName,
    required String secondName,
    required String email,
    required String mobileNumber,
    required String password,
    required String location,
    required String age,
    required String gender,
    // Change type to File
  }) async {
    String basePath = "Userregister";
    final body = {
      "firstname": firstName,
      "secondname": secondName,
      "mobileNo": mobileNumber,
      "email": email,
      "password": password,
      "location": location,
      "gender": gender,
      "age": age,
      "user_image": userImage, // Pass the File directly
    };

    Response response = userImage == null
        ? await apiClient.invokeAPI(path: basePath, method: "POST", body: body)
        : await multiFileApiClientRegister.uploadFiles(
            bodyData: body, files: userImage, uploadPath: basePath);

    print(body);
    print("signup response worked");
    return SignUpModel.fromJson(json.decode(response.body));
  }
}
