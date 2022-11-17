import 'dart:convert';

import 'package:http/http.dart';
import 'package:pixbayimages/Model/Images/get_images_model.dart';
import 'package:pixbayimages/Repositories/api_client.dart';

class ImagesApi {
  ApiClient apiClient = ApiClient();

  Future<GetImagesModel> getImages({required String query}) async {
    String path = '$query&image_type=photo';

    Response response =
        await apiClient.invokeAPI(path: path, method: 'GET', body: null);
    return GetImagesModel.fromJson(jsonDecode(response.body));
  }
}
