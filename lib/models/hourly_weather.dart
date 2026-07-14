class HourlyWeather {
  final DateTime time;
  final double temperature;
  final String condition;
  final String iconUrl;

  const HourlyWeather({
    required this.time,
    required this.temperature,
    required this.condition,
    required this.iconUrl,
  });

  factory HourlyWeather.fromJson(Map<String, dynamic> json) {
    return HourlyWeather(
      time: DateTime.parse(json["time"]),
      temperature: (json["temp_c"] as num).toDouble(),
      condition: json["condition"]["text"],
      iconUrl: "https:${json["condition"]["icon"]}",
    );
  }
}