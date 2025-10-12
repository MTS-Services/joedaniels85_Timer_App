import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:joedaniels85_timer_app/core/constants/urls.dart';

class NetworkCaller {
  // GET request
  Future<Map<String, dynamic>?> getRequest(String url, {String? token}) async {
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };

      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
      }

      print("GET Request to: $url");
      print("Headers: $headers");

      final response = await http.get(Uri.parse(url), headers: headers);

      print("GET Status: ${response.statusCode}");
      print("GET Body: ${response.body}");

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized: Invalid token');
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print("GET Request Error: $e");
      rethrow;
    }
  }

  // POST request
  Future<dynamic> postRequest(
      String endpoint, Map<String, dynamic> body, {String? token}) async {
    final headers = {
      'Content-Type': 'application/json',
    };

    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    final response = await http.post(
      Uri.parse(endpoint),
      headers: headers,
      body: jsonEncode(body),
    );

    print("POST Status: ${response.statusCode}");
    print("POST Response: ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
          "Failed to post data: ${response.statusCode} - ${response.body}");
    }
  }

  // PUT request
  Future<dynamic> putRequest(
      String endpoint, Map<String, dynamic> body, {String? token}) async {
    final headers = {
      'Content-Type': 'application/json',
    };

    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    final response = await http.put(
      Uri.parse("${Urls.baseUrl}/$endpoint"),
      headers: headers,
      body: jsonEncode(body),
    );

    print("PUT Status: ${response.statusCode}");
    print("PUT Response: ${response.body}");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to update data: ${response.statusCode}");
    }
  }

  // DELETE request
  Future<void> deleteRequest(String endpoint, {String? token}) async {
    final headers = {
      'Content-Type': 'application/json',
    };

    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    final response = await http.delete(
      Uri.parse("${Urls.baseUrl}/$endpoint"),
      headers: headers,
    );

    print("DELETE Status: ${response.statusCode}");
    print("DELETE Response: ${response.body}");

    if (response.statusCode != 200) {
      throw Exception("Failed to delete data: ${response.statusCode}");
    }
  }
}
