import 'dart:convert';
import 'package:http/http.dart' as http;

class SigninHandler {
  static signin(var data) async {
    var response = await http.post(
      Uri.parse('https://campergigs-api.azurewebsites.net/users/login'),
      headers: {"Content-type": "application/json"},
      body: json.encode(data),
    );
    var parse = jsonDecode(response.body);
    return parse;
  }

  static signinSSO(var data) async {
    var response = await http.post(
      Uri.parse('https://campergigs-api.azurewebsites.net/users/loginSSO'),
      headers: {"Content-type": "application/json"},
      body: json.encode(data),
    );
    var parse = jsonDecode(response.body);
    return parse;
  }

}
