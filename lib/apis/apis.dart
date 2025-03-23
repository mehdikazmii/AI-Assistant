import 'dart:convert';
import 'dart:developer';

import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:http/http.dart';
import 'package:translator_plus/translator_plus.dart';

class APIs {
  //get answer from google gemini ai
  static Future<String> getAnswer(String question) async {
    try {
      log('api key: AIzaSyDLHyyzjqAqW4-k5FtzL0qRo8zOxrRICgI');

      final model = GenerativeModel(
        model: 'gemini-1.5-flash-latest',
        apiKey: 'AIzaSyDLHyyzjqAqW4-k5FtzL0qRo8zOxrRICgI',
        generationConfig: GenerationConfig(
          temperature: 0.7,
          topK: 40,
          topP: 0.95,
          maxOutputTokens: 2048,
        ),
      );

      log('Model initialized successfully');

      final content = [Content.text(question)];
      log('Content created: $question');

      final response = await model.generateContent(
        content,
        safetySettings: [
          SafetySetting(HarmCategory.dangerousContent, HarmBlockThreshold.none),
          SafetySetting(HarmCategory.sexuallyExplicit, HarmBlockThreshold.none),
          SafetySetting(HarmCategory.harassment, HarmBlockThreshold.none),
          SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.none),
        ],
      );

      log('Response received: ${response.text}');

      if (response.text == null) {
        throw Exception('No response text received from Gemini');
      }

      return response.text!;
    } catch (e, stackTrace) {
      log('getAnswerGeminiE: $e');
      log('Stack trace: $stackTrace');
      if (e.toString().contains('API key')) {
        return 'Invalid API key. Please check your configuration.';
      } else if (e.toString().contains('model')) {
        return 'Model configuration error. Please try again later.';
      }
      return 'Something went wrong. Please try again in a moment.';
    }
  }

  //get answer from chat gpt
  // static Future<String> getAnswer(String question) async {
  //   try {
  //     log('api key: $apiKey');

  //     //
  //     final res =
  //         await post(Uri.parse('https://api.openai.com/v1/chat/completions'),

  //             //headers
  //             headers: {
  //               HttpHeaders.contentTypeHeader: 'application/json',
  //               HttpHeaders.authorizationHeader: 'Bearer $apiKey'
  //             },

  //             //body
  //             body: jsonEncode({
  //               "model": "gpt-3.5-turbo",
  //               "max_tokens": 2000,
  //               "temperature": 0,
  //               "messages": [
  //                 {"role": "user", "content": question},
  //               ]
  //             }));

  //     final data = jsonDecode(res.body);

  //     log('res: $data');
  //     return data['choices'][0]['message']['content'];
  //   } catch (e) {
  //     log('getAnswerGptE: $e');
  //     return 'Something went wrong (Try again in sometime)';
  //   }
  // }

  static Future<List<String>> searchAiImages(String prompt) async {
    try {
      // Using Unsplash API
      final res = await get(
        Uri.parse(
            'https://api.unsplash.com/search/photos?query=$prompt&per_page=30'),
        headers: {
          'Authorization':
              'Client-ID BdmOGX-N-0RqIQTKSymz9F27Io3_sP5Ew9r1lBPq8hE', // You'll need to replace this with your Unsplash API key
        },
      );

      if (res.statusCode != 200) {
        log('searchAiImagesE: Server returned ${res.statusCode}');
        return [];
      }

      final data = jsonDecode(res.body);

      if (data == null || !data.containsKey('results')) {
        log('searchAiImagesE: Invalid response format');
        return [];
      }

      final results = data['results'] as List;
      return results
          .map((e) => e['urls']?['regular']?.toString() ?? '')
          .where((url) => url.isNotEmpty)
          .toList();
    } catch (e) {
      log('searchAiImagesE: $e');
      return [];
    }
  }

  static Future<String> googleTranslate(
      {required String from, required String to, required String text}) async {
    try {
      final res = await GoogleTranslator().translate(text, from: from, to: to);

      return res.text;
    } catch (e) {
      log('googleTranslateE: $e ');
      return 'Something went wrong!';
    }
  }
}
