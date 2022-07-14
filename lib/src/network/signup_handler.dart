import 'dart:convert';
import 'package:http/http.dart' as http;

class SignUpHandler {
  static signup(var data) async {
    var response = await http.post(
      Uri.parse('https://campergigs-api.azurewebsites.net/users/signup'),
      headers: {"Content-type": "application/json"},
      body: json.encode(data),
    );
    var parse = jsonDecode(response.body);
    return parse;
  }

  static signupSSO(var data) async {
    var response = await http.post(
      Uri.parse('https://campergigs-api.azurewebsites.net/users/signupSSO'),
      headers: {"Content-type": "application/json"},
      body: json.encode(data),
    );
    var parse = jsonDecode(response.body);
    return parse;
  }

  static activation(var data) async {
    var response = await http.patch(
      Uri.parse('https://campergigs-api.azurewebsites.net/users/activate'),
      headers: {"Content-type": "application/json"},
      body: json.encode(data),
    );
    var parse = jsonDecode(response.body);
    return parse;
  }

}
