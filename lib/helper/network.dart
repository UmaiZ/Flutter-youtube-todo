import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiProvider {
  final String _baseURL =
      "https://crudcrud.com/api/9a0288ae825c455aa6d8305fea4199a5";

  get(String url) async {
    try {
      final response = await http.get(Uri.parse(_baseURL + url));

      if (response.statusCode == 200) {
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      }
    } catch (e) {
      //bad practice to print error use logger
      // print(e);
      rethrow;
    }
  }

  post(String url, Map<String, dynamic> data) async {
    try {
      String jsondata = json.encode(data);
      final response =
          await http.post(Uri.parse(_baseURL + url), body: jsondata, headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 201) {
        return true;
      }
    } catch (e) {
      //bad practice to print error use logger
      // print(e);
      rethrow;
    }
  }

  put(String url, Map<String, dynamic> data) async {
    try {
      String jsondata = json.encode(data);
      final response =
          await http.put(Uri.parse(_baseURL + url), body: jsondata, headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      //bad practice to print error use logger
      // print(e);
      rethrow;
    }
  }

  delete(String url) async {
    try {
      final response = await http.delete(Uri.parse(_baseURL + url));

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      //bad practice to print error use logger
      // print(e);
      rethrow;
    }
  }
}
