class WeatherModel {
  final String city;
  final double temperature;
  final double feelsLike;
  final int humidity;
  final int pressure;
  final String aqi;
  final double windSpeed;
  final String condition;
  final String description;
  final double maxTemperature;
  final double minTemperature;
  final bool isDay;
  final DateTime localTime;

  const WeatherModel({
    required this.city,
    required this.temperature,
    required this.feelsLike,
    required this.humidity,
    required this.pressure,
    required this.aqi,
    required this.windSpeed,
    required this.condition,
    required this.description,
    required this.maxTemperature,
    required this.minTemperature,
    required this.isDay,
    required this.localTime,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final current = json["current"];
    final location = json["location"];
    final today = json["forecast"]["forecastday"][0]["day"];

    return WeatherModel(
      city: location["name"],
      temperature: (current["temp_c"] as num).toDouble(),
      feelsLike: (current["feelslike_c"] as num).toDouble(),
      humidity: current["humidity"],
      pressure: (current["pressure_mb"] as num).round(),
      aqi: _getAqiCategory(
        (current["air_quality"]["us-epa-index"] as num).toInt(),
      ),
      windSpeed: (current["wind_kph"] as num).toDouble(),
      condition: current["condition"]["text"],
      description: current["condition"]["text"],
      maxTemperature: (today["maxtemp_c"] as num).toDouble(),
      minTemperature: (today["mintemp_c"] as num).toDouble(),
      localTime: DateTime.parse(location["localtime"]),
      isDay: current["is_day"] == 1,
    );
  }

  static String _getAqiCategory(int index) {
    switch (index) {
      case 1:
        return "Good";
      case 2:
        return "Moderate";
      case 3:
        return "USG";
      case 4:
        return "Unhealthy";
      case 5:
        return "Very Unhealthy";
      case 6:
        return "Hazardous";
      default:
        return "Unknown";
    }
  }
}