import 'dart:convert';

import 'package:http/http.dart';
import 'package:mediezy_user/Model/GetSymptomAndDoctor/get_doctor_as_per_health_symptoms_model.dart';
import 'package:mediezy_user/Model/GetSymptomAndDoctor/get_health_symptoms_model.dart';
import 'package:mediezy_user/Repository/Api/ApiClient.dart';

class GetHealthSympyomsApi{
  ApiClient apiClient = ApiClient();
  Future<GetHealthSymptomsModel> getAllHealthSymptoms() async {
    String basePath = "Showsymptoms";
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "GET", body: null);
    print("<<<<<<GET HEALTH SYMPTOMS WORKED>>>>>");
    return GetHealthSymptomsModel.fromJson(json.decode(response.body));
  }


   Future<GetDoctorAsPerHealthSymptomsModel> getDoctorsAsPerHealthSymptoms(
    {required String id}
  ) async {
    String basePath = "ShowCategoriessymptoms/$id";
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "GET", body: null);
    print("<<<<GET DOCTORS AS PER HEALTH SYMPTOMS WORKED>>>");
    return GetDoctorAsPerHealthSymptomsModel.fromJson(json.decode(response.body));
  }
}