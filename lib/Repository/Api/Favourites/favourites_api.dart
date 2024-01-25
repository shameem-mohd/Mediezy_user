import 'dart:convert';

import 'package:http/http.dart';
import 'package:mediezy_user/Model/GetFavourites/get_favourites_model.dart';
import 'package:mediezy_user/Repository/Api/ApiClient.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouritesApi {
  ApiClient apiClient = ApiClient();
  Future<String> addFavourites({
    required String doctorId,
  }) async {
    String basePath = "user/addtofavourites";
    final preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userId');
    final body = {"docter_id": doctorId, "user_id": userId};

    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
    print(body);
    print("<<<<<<<<<<Favourites Added  Successfully>>>>>>>>>>");
    return response.body;
  }

//* get all favourites
  Future<GetFavouritesModel> getAllFavourites() async {
    final preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userId');

    String basePath = "user/getallfavourites/$userId";

    Response response =
        await apiClient.invokeAPI(path: basePath, method: "GET", body: null);
    print("<<<<<<<<<<GET ALL FAVOURITES SUCCESSFULY>>>>>>>>>>");
    return GetFavouritesModel.fromJson(json.decode(response.body));
  }
}