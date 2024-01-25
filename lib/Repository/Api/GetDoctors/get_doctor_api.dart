import 'dart:convert';
import 'package:http/http.dart';
import 'package:mediezy_user/Model/Doctor/doctor_model.dart';
import 'package:mediezy_user/Model/Doctor/get_doctor_by_id_model.dart';

import 'package:mediezy_user/Repository/Api/ApiClient.dart';

class GetDoctorsApi {
  ApiClient apiClient = ApiClient();

  //* get all doctors
  Future<DoctorModel> getDoctor() async {
    String basePath = "docter";
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "GET", body: null);

    print("Doctor get response worked");
    return DoctorModel.fromJson(json.decode(response.body));
  }

  //* get doctor by id
  Future<GetDoctorByIdModel> getDoctorById(String id) async {
    String basePath = "docter/$id";
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "GET", body: null);
    print("Doctor get by ID response worked");
    return GetDoctorByIdModel.fromJson(json.decode(response.body));
  }
}
