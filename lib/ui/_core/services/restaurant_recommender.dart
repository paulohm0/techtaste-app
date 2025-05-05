import 'package:flutter/services.dart' show rootBundle;
import 'package:techtaste_app/helpers/open_ai/openai_helper.dart';
import 'package:techtaste_app/helpers/open_ai/prompt_helper.dart';

class RestaurantRecommender {
  static Future<String> recommendRestaurant(String inputUser) async {
    final jsonString = await rootBundle.loadString('assets/data.json');
    final prompt = PromptHelper.generatePromptForOpenAI(inputUser, jsonString);
    final response = await OpenAIHelper.searchRestaurantsByOpenAI(prompt);
    return response;
  }
}
