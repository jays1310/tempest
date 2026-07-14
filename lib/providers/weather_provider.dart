import 'package:flutter/material.dart';
import '../models/city_suggestion.dart';
import '../models/forecast_day.dart';
import '../models/hourly_weather.dart';
import '../models/weather_model.dart';
import '../services/location_service.dart';
import '../services/weather_service.dart';

class WeatherProvider extends ChangeNotifier {
  final WeatherService _weatherService = WeatherService();
  final LocationService _locationService = LocationService();

  bool isLoading = false;

  WeatherModel? weather;
  List<HourlyWeather> hourlyForecast = [];
  List<ForecastDay> weeklyForecast = [];
  List<CitySuggestion> suggestions = [];

  String? error;

  Future<void> fetchWeather({
    required double latitude,
    required double longitude,
  }) async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      final json = await _weatherService.getWeather(
        latitude: latitude,
        longitude: longitude,
      );

      _updateWeatherData(json);
      suggestions.clear();
    } catch (e) {
      final message = e.toString();

      if (message.contains("(400)")) {
        error = "Location not found.";
      } else if (message.contains("(401)")) {
        error = "Invalid API key.";
      } else if (message.contains("(403)")) {
        error = "Access denied.";
      } else if (message.contains("(404)")) {
        error = "Weather service unavailable.";
      } else if (message.contains("(429)")) {
        error = "Daily API limit reached.";
      } else {
        error = "Something went wrong. Please try again.";
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchWeatherByCity(String city) async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      final json = await _weatherService.getWeatherByCity(
        city: city,
      );

      _updateWeatherData(json);
      suggestions.clear();
    } catch (e) {
      final message = e.toString();

      if (message.contains("(400)")) {
        error = "City not found.";
      } else if (message.contains("(401)")) {
        error = "Invalid API key.";
      } else if (message.contains("(403)")) {
        error = "Access denied.";
      } else if (message.contains("(404)")) {
        error = "Weather service unavailable.";
      } else if (message.contains("(429)")) {
        error = "Daily API limit reached.";
      } else {
        error = "Something went wrong. Please try again.";
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> searchCities(String query) async {
    if (query.trim().isEmpty) {
      suggestions = [];
      notifyListeners();
      return;
    }

    try {
      suggestions = await _weatherService.searchCities(query);
    } catch (_) {
      suggestions = [];
    }

    notifyListeners();
  }

  Future<void> fetchCurrentLocationWeather() async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      final position = await _locationService.getCurrentLocation();

      await fetchWeather(
        latitude: position.latitude,
        longitude: position.longitude,
      );
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void _updateWeatherData(Map<String, dynamic> json) {
    weather = WeatherModel.fromJson(json);

    final allHours =
    (json["forecast"]["forecastday"][0]["hour"] as List)
        .map((e) => HourlyWeather.fromJson(e))
        .toList();

    final now = DateTime.now();

    final currentIndex = allHours.indexWhere(
          (hour) =>
      hour.time.hour == now.hour &&
          hour.time.day == now.day,
    );

    if (currentIndex != -1) {
      hourlyForecast =
          allHours.skip(currentIndex).take(12).toList();
    } else {
      hourlyForecast = allHours.take(12).toList();
    }

    weeklyForecast =
        (json["forecast"]["forecastday"] as List)
            .map((e) => ForecastDay.fromJson(e))
            .toList();
  }

  void clearSuggestions() {
    suggestions.clear();
    notifyListeners();
  }
}
