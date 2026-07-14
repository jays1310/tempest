import 'dart:convert';
import '../models/city_suggestion.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  final String _apiKey = dotenv.env['WEATHER_API_KEY']!;

  Future<Map<String, dynamic>> getWeather({
    required double latitude,
    required double longitude,
  })
  async {
    final uri = Uri.parse(
      "https://api.weatherapi.com/v1/forecast.json"
          "?key=$_apiKey"
          "&q=$latitude,$longitude"
          "&days=7"
          "&aqi=yes"
          "&alerts=yes",
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    throw Exception(
      "Failed to fetch weather (${response.statusCode})",
    );
  }

  Future<Map<String, dynamic>> getWeatherByCity({
    required String city,
  }) async {
    final uri = Uri.parse(
      "https://api.weatherapi.com/v1/forecast.json"
          "?key=$_apiKey"
          "&q=$city"
          "&days=7"
          "&aqi=yes"
          "&alerts=yes",
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    throw Exception(
      "Failed to fetch weather (${response.statusCode})",
    );
  }

  Future<List<CitySuggestion>> searchCities(String query) async {
    if (query.trim().isEmpty) return [];

    final uri = Uri.parse(
      "https://api.weatherapi.com/v1/search.json"
          "?key=$_apiKey"
          "&q=$query",
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);

      return data
          .map((e) => CitySuggestion.fromJson(e))
          .toList();
    }

    return [];
  }
}