import 'dart:convert';
import 'package:http/http.dart';
import 'package:mediezy_user/Model/GetSymptoms/get_symptoms_model.dart';
import 'package:mediezy_user/Model/GetTokens/GetTokenModel.dart';
import 'package:mediezy_user/Repository/Api/ApiClient.dart';

class GetTokenApi {
  ApiClient apiClient = ApiClient();

  Future<GetTokenModel> getTokens({
    required String doctorId,
    required String hospitalId,
    required String date,
  }) async {
    String basePath = "user/get_docter_tokens";
    final body={
      "doctor_id":doctorId,
      "hospital_id":hospitalId,
      "date":date,
    };
    Response response =
    await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
    print("<<<<<<<<<<Get Symtoms Successfully>>>>>>>>>>");
    return GetTokenModel.fromJson(json.decode(response.body));
  }

  //Get Symptoms api

  Future<GetSymptomsModel> getSymptoms({required String doctorId}) async {
    String basePath = "symptoms/$doctorId";

    Response response =
        await apiClient.invokeAPI(path: basePath, method: "GET", body: null);
    print("<<<<<<<<<<Get Symtoms Successfully>>>>>>>>>>");
    return GetSymptomsModel.fromJson(json.decode(response.body));
  }
}
