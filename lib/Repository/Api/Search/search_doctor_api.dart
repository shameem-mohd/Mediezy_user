import 'dart:convert';

import 'package:http/http.dart';
import 'package:mediezy_user/Model/Search/search_doctor_model.dart';
import 'package:mediezy_user/Repository/Api/ApiClient.dart';

class SearchApi {
  ApiClient apiClient = ApiClient();
  Future<SearchDoctorModel> getSearchDoctors(
      {required String searchQuery}) async {
    String basePath = "searchdoctor?name=$searchQuery";
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "GET", body: null);
    print("<<<<<SEARCH DOCTOR GET RESPONSE WORKED>>>>>");
    return SearchDoctorModel.fromJson(json.decode(response.body));
  }
}
