
import 'dart:convert';

import 'package:http/http.dart' as http;
class ApiServices{

get(String baseUrl)async {
  var url = Uri.parse(baseUrl);
  var response = await http.get(
      url);
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
return jsonDecode(response.body) ;
}
}