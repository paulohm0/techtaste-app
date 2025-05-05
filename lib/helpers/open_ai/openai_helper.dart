import 'dart:convert';

import 'package:http/http.dart' as http;

class OpenAIHelper {
  static const _apiKey = String.fromEnvironment('OPENAI_API_KEY');
  static const _endpoint = 'https://api.openai.com/v1/responses';

  static Future<String> searchRestaurantsByOpenAI(String prompt) async {
    final response = await http.post(
      Uri.parse(_endpoint),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_apiKey',
      },
      body: jsonEncode({
        "model": "gpt-4.1",
        "input": prompt,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['output'][0]['content'][0]['text'];
    } else {
      throw Exception('Erro ao consultar o ChatGPT');
    }
  }
}
