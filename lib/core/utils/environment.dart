import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String get baseUrl => dotenv.get("BASE_URL");
  static String get apiKey => dotenv.get("API_KEY");
}