import 'dart:convert';

import 'package:bard_flutter/BardModel.dart';
import 'package:bard_flutter/data.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class BardAIController extends GetxController {
  RxList historyList = RxList<BardModel>([
    BardModel(system: "bard", message: "Olá tudo bem? no momento só consigo lhe atender em ingles, francês ou espanhol!!!"),
  ]);

  RxBool isLoading = false.obs;

  void sendPrompt({String? prompt, String? firtPrompt}) async {
    isLoading.value = true;
    var newHistory = BardModel(system: "user", message: prompt);
    firtPrompt == null ? historyList.add(newHistory) : prompt = firtPrompt;

    final body = {
      'prompt': {
        'text': prompt,
      },
    };

    try {
      final request = await http.post(
        Uri.parse(
            'https://generativelanguage.googleapis.com/v1beta3/models/text-bison-001:generateText?key=$APIKEY'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      final response = jsonDecode(request.body);

      // Check if the response contains the expected structure
      if (response.containsKey("candidates") &&
          response["candidates"] is List &&
          response["candidates"].isNotEmpty) {
        final bardReplay = response["candidates"][0]["output"];
        var newHistory2 = BardModel(system: "bard", message: bardReplay);
        historyList.add(newHistory2);
        print(bardReplay.toString());
      } else {
        // Handle the case when the response structure is unexpected
        handleUnexpectedResponse();
      }
    } catch (e) {
      // Handle the case when an exception occurs (e.g., network error)
      handleUnexpectedResponse();
    }

    isLoading.value = false;
  }

  void handleUnexpectedResponse() {
    var errorMessage =
        "Não consegui entender sua resposta. Por favor, tente novamente. Se o problema persistir, reinicie o app.";
    var errorHistory = BardModel(system: "bard", message: errorMessage);
    historyList.add(errorHistory);
    print(errorMessage);
  }
}
