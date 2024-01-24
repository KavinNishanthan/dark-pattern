// api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://50.17.92.3:5000";

  Future<Map<String, dynamic>> checkWebsite(String url) async {
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'url': url});

    final response = await http.post(
      Uri.parse('$baseUrl/run_python_code'),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON data
      return parseApiResponse(response.body);
    } else {
      // If the server did not return a 200 OK response, throw an exception.
      throw Exception('Failed to check website');
    }
  }

  Map<String, dynamic> parseApiResponse(String responseBody) {
    // Parse the JSON response and return a Map
    try {
      return json.decode(responseBody);
    } catch (e) {
      throw Exception('Failed to parse API response: $e');
    }
  }
}