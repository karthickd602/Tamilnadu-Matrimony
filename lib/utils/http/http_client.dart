import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../constants/path_provider.dart';

class THttpHelper {
  static const String _baseUrl = 'https://www.jobsintimate.com/api';
  static final storage = GetStorage();

  // Helper method to make a GET request
  static Future<Map<String, dynamic>> get(String endpoint) async {
    final response = await http.get(Uri.parse('$_baseUrl/$endpoint'));
    return _handleResponse(response);
  }

  static Future<Map<String, dynamic>> multipartPost(
    String endpoint,
    Map<String, dynamic> body, {
    required String filePath,
    String fileFieldName = "file",
  }) async {
    final url = Uri.parse("$_baseUrl/$endpoint");
    final request = http.MultipartRequest("POST", url);

    request.headers.addAll({
      'Accept-Language': storage.read(TTexts.languageCode) ?? "en",
      'x-authorization': 'Bearer ${storage.read(TTexts.barerToken)}',
    });
    debugPrint('Bearer token:Bearer ${storage.read(TTexts.barerToken)}');
    // Convert dynamic body → String fields safely
    body.forEach((key, value) {
      if (value != null) {
        request.fields[key] = value.toString();
      }
    });

    // Add file
    final multipartFile = await http.MultipartFile.fromPath(
      fileFieldName,
      filePath,
    );

    request.files.add(multipartFile);

    debugPrint('Multipart Body Fields: ${request.fields}');
    debugPrint(
      'Multipart Files: ${request.files.map((f) => 'Field: ${f.field}, File: ${f.filename}').toList()}',
    );

    // Send request
    final response = await request.send();
    final responseData = await response.stream.bytesToString();

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return json.decode(responseData);
    }

    if (response.statusCode == 401) {
      debugPrint("multipartPost StatusCode: ${response.statusCode}");
      storage.remove(TTexts.barerToken);
      storage.remove(TTexts.userId);
      Get.offAllNamed(TRoutes.loginPage);
      throw "Unauthorized";
    }

    // If error contains message
    try {
      final decoded = json.decode(responseData);
      throw decoded["message"] ?? "Upload failed";
    } catch (_) {
      throw "Upload failed: ${response.statusCode}";
    }
  }

  // Helper method to make a POST request
  static Future<Map<String, dynamic>> post(
    String endpoint,
    dynamic data,
  ) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Accept-Language': storage.read(TTexts.languageCode) ?? "en",
        'x-authorization': 'Bearer ${storage.read(TTexts.barerToken)}',
      },
      body: json.encode(data),
    );
    debugPrint('Headers: ${response.request?.headers}');
    debugPrint('Bearer ${storage.read(TTexts.barerToken)}');
    return _handleResponse(response);
  }

  static Future<Map<String, dynamic>> postWithFiles(
    String endpoint,
    Map<String, String> data,
    Map<String, File> files,
  ) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$_baseUrl/$endpoint'),
    );
    request.headers.addAll({
      'Accept-Language': storage.read(TTexts.languageCode) ?? "en",
      'x-authorization': 'Bearer ${storage.read(TTexts.barerToken)}',
    });
    request.fields.addAll(data);
    files.forEach((key, value) async {
      request.files.add(await http.MultipartFile.fromPath(key, value.path));
    });

    final response = await request.send();
    final responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      return json.decode(responseBody);
    } else if (response.statusCode == 401) {
      debugPrint("postWithFiles StatusCode: ${response.statusCode}");
      storage.remove(TTexts.barerToken);
      storage.remove(TTexts.userId);
      Get.offAllNamed(TRoutes.languageSelection);
      throw "Unauthorized";
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
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 204) {
      debugPrint("StatusCode: ${response.statusCode}");
      // debugPrint("StatusCode: ${response.body}");

      return json.decode(response.body);
    } else if (response.statusCode == 404 ||
        response.statusCode == 400 ||
        response.statusCode == 409 ||
        response.statusCode == 302) {
      final message = json.decode(response.body)['message'];
      debugPrint("StatusCode: ${response.statusCode}");
      // debugPrint("StatusCode: ${response.body}");

      throw message;
    } else if (response.statusCode == 500) {
      debugPrint("StatusCode 500: ${response.statusCode}");

      // final message = json.decode(response.body)['message'];
      throw "Something went wrong";
    } else if (response.statusCode == 401) {
      debugPrint("StatusCode: ${response.statusCode}");
      storage.remove(TTexts.barerToken);
      storage.remove(TTexts.userId);
      Get.offAllNamed(TRoutes.loginPage);
      throw "Unauthorized";
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
}
