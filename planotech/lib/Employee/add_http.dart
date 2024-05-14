import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:planotech/Employee/add_service.dart';

class AddCommService {
  static Future<void> saveDataToDatabase(Contact contact) async {
        final Uri uri = Uri.parse('http://3.6.109.119:4040/admin/addEmployee');
    // Log the request details
    print('Sending request to: $uri');
    print('Request body: ${jsonEncode(contact.toJson())}');

    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(contact.toJson()),
    );

    // Log the response details
    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    // Parse the response JSON
    final responseBody = jsonDecode(response.body);
    final bool status = responseBody['status'];

    if (status) {
      print('Data saved to database:');
      print(' - UserName: ${contact.userName}');
      print(' - UserPosition: ${contact.userPosition}');
    } else {
      final String message = responseBody['message'];
      print('Failed to save data to database: $message');
    }
  }
}

