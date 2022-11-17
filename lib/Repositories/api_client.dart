import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';
//import 'package:voyage/ApiSection/Repository/api_exception.dart';

import 'api_exception.dart';

class ApiClient {
  static const String basePath =
      'https://pixabay.com/api/?key=31411260-708fe0bc2f05c50b364618f26&q=';

  Future<Response> invokeAPI({
    required String path,
    required String method,
    required Object? body,
  }) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = 'token';
    print(token);
    print("Invoke Api worked");
    print(method);

    Map<String, String> headerParams = {};
    if (method == 'POST' || method == 'GET' || method == 'PATCH') {
      print("Methode POST OR GET");
      headerParams = {
        'Cookie':
            '__cf_bm=f5NJ_fRSQCcgr9VbvpJesLOph8N3jgBdOYFPqKbDaPc-1668734695-0-AWN8jROoy9d7boHXhr/55E0/+NaOmGYvHZrv8v05gIiATf5jeZk46tbQRCvRRQsNalOrftHKL9IAmgIakn9OI+Q=; anonymous_user_id=None; csrftoken=eYc4Jcp560TqFlfgVlwcIL3l1iM7JsvKCaINTHOwpJgFy1ozCU8ry2IoxtFjMryS'
      };
    }
    Response response;

    String url = basePath + path;
    // String searchurl =  basePath + 'search/movie'+'?api_key=$token'+ path;
    print('========================================$url');

    // print(searchurl);
    final nullableHeaderParams = (headerParams.isEmpty) ? null : headerParams;

    switch (method) {
      case "POST":
        response = await post(Uri.parse(url),
            headers: headerParams, body: jsonEncode(body));
        break;
      case "LOGIN":
        response =
            await post(Uri.parse(url), headers: headerParams, body: body);
        break;
      case "PUT":
        response = await put(Uri.parse(url), headers: headerParams, body: body);
        break;
      case "PATCH":
        response = await patch(Uri.parse(url),
            headers: headerParams, body: jsonEncode(body));
        break;
      case "DELETE":
        response = await delete(Uri.parse(url), headers: nullableHeaderParams);
        break;
      case "POST_":
        response = await post(
          Uri.parse(url),
          headers: headerParams,
          body: body,
        );
        break;
      case "GET_":
        response = await post(
          Uri.parse(url),
          headers: {},
          body: body,
        );
        break;

      default:
        response = await get(Uri.parse(url), headers: headerParams);
    }

    print('status of $path =>${response.statusCode}');
    print(response.body);
    if (response.statusCode >= 400) {
      // print("if)()");
      log('$path : ${response.statusCode} : ${response.body}');

      throw ApiException(
          message: _decodeBodyBytes(response), statusCode: response.statusCode);
    }
    ;
    return response;
  }

  String _decodeBodyBytes(Response response) {
    var contentType = response.headers['content-type'];
    if (contentType != null && contentType.contains("application/json")) {
      return jsonDecode(response.body)['message'];
    } else {
      return response.body;
    }
  }
}
