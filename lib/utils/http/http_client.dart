
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class THttpHelper {
  static const String _baseUrl =
      'https://www.jobsintimate.com/api';

  // Helper method to make a GET request
  static Future<Map<String, dynamic>> get(String endpoint) async {
    final response = await http.get(Uri.parse('$_baseUrl/$endpoint'));
    return _handleResponse(response);
  }

  // Helper method to make a POST request
  static Future<Map<String, dynamic>> post(
      String endpoint, dynamic data) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    return _handleResponse(response);
  }

  static Future<Map<String, dynamic>> postWithFiles(String endpoint, Map<String, String> data, Map<String, File> files) async {
    final request = http.MultipartRequest('POST', Uri.parse('$_baseUrl/$endpoint'));
    request.fields.addAll(data);
    files.forEach((key, value) async {
      request.files.add(await http.MultipartFile.fromPath(key, value.path));
    });

    final response = await request.send();
    final responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      return json.decode(responseBody);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  // Helper method to make a PUT request
  static Future<Map<String, dynamic>> put(String endpoint, dynamic data) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    return _handleResponse(response);
  }

  // Helper method to make a DELETE request
  static Future<Map<String, dynamic>> delete(String endpoint) async {
    final response = await http.delete(Uri.parse('$_baseUrl/$endpoint'));
    return _handleResponse(response);
  }

  // Handle the HTTP response
  static Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    if(response.statusCode == 404||response.statusCode == 400){
      final message = json.decode(response.body)['message'];
      throw message;
    }else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
}
