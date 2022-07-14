import 'dart:convert';
import 'package:campergigs/src/controller/maincontroller.dart';
import 'package:http/http.dart' as http;

class SearchProjectApi {
   MainController _mainController = MainController();
  static searchProject(String token) async {
    var response = await http.get(
      Uri.parse('https://campergigs-api.azurewebsites.net/projects'),
      headers: {
        "Content-type": "application/json",
        'Accept': 'application/json',
        'Authorization': "Bearer $token"
      },
    );
    var parse = jsonDecode(response.body);
    return parse;
  }

}
