import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> fetchCalories(String productName) async {
  final response = await http.get(Uri.parse('https://caloriasporalimentoapi.herokuapp.com/api/calorias/?descricao=$productName'));
  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    final calories = jsonResponse[0]['calorias'];
    return calories;
  } else {
    throw Exception('Failed to load calories');
  }
}
