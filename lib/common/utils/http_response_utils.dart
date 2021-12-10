import 'dart:convert';

import 'package:http/http.dart';

class HttpResponseUtils {
  static Map<String, dynamic> parseHttpResponse(Response response) {
    final decodedString = utf8.decode(response.bodyBytes);
    return jsonDecode(decodedString) as Map<String, dynamic>;
  }

  static List<Map<String, dynamic>> parseHttpResponseAsList(Response response) {
    final decodedString = utf8.decode(response.bodyBytes);
    final dynamicList = jsonDecode(decodedString) as List<dynamic>;
    return dynamicList.map((e) => e as Map<String, dynamic>).toList();
  }
}
