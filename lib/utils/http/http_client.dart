import 'dart:convert';
import 'package:http/http.dart' as http;

class KHttpHelper {
  static const String _baseUrl = '';

  static Future<Map<String, dynamic>> getRequest(String endpoint) async {
    final response = await http.get(Uri.parse('$_baseUrl / $endpoint'));
    return _handleException(response);
  }

  static Future<Map<String, dynamic>> postRequest(
      String endpoint, dynamic data) async {
    final response = await http.post(
      Uri.parse('_baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    return _handleException(response);
  }

  static Future<Map<String, dynamic>> deleteRequest(String endpoint) async {
    final response = await http.delete(Uri.parse('$_baseUrl/$endpoint'));
    return _handleException(response);
  }

  static Map<String, dynamic> _handleException(http.Response response) {
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data:${response.statusCode}');
    }
  }
}
