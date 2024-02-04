import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import '../models/dog_model.dart';

class ApiFetch {
  static Future<String> fetchDogImage() async {
    const url = "https://dog.ceo/api/breeds/image/random";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        String imageUrl = jsonDecode(response.body)['message'];

        storeHistory(imageUrl);
        return imageUrl;
      } else {
        throw Exception('Failed to load dog image');
      }
    } catch (e) {
      return "error";
    }
  }

  static void storeHistory(String imageUrl) async {
    var box = await Hive.openBox<DogModel>("dogbox");
    box.values.toList();

    DogModel dog = DogModel(imageUrl: imageUrl);
    box.add(dog);
  }
}
