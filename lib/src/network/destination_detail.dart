import 'dart:convert';
import 'package:http/http.dart' as http;

class DestinationDetailApi {
  static searchProject(String token,String id) async {
    var response = await http.get(
      Uri.parse('https://campergigs-api.azurewebsites.net/projects/$id'),
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
