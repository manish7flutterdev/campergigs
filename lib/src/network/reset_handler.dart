import 'dart:convert';
import 'package:http/http.dart' as http;

class ResetHandler {
  static resetEmail(var data) async {
    var response = await http.patch(
      Uri.parse('https://campergigs-api.azurewebsites.net/users/forgot'),
      headers: {"Content-type": "application/json"},
      body: json.encode(data),
    );
    var parse = jsonDecode(response.body);
    return parse;
  }

  static resetPassword(var data) async {
    var response = await http.patch(
      Uri.parse('https://campergigs-api.azurewebsites.net/users/reset'),
      headers: {"Content-type": "application/json"},
      body: json.encode(data),
    );
    var parse = jsonDecode(response.body);
    return parse;
  }

}
