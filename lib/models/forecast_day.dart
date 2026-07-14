class ForecastDay {
  final DateTime date;

  final double maxTemp;
  final double minTemp;

  final String condition;
  final String iconUrl;

  final String sunrise;
  final String sunset;

  final String moonrise;
  final String moonset;

  final String moonPhase;
  final int moonIllumination;

  const ForecastDay({
    required this.date,
    required this.maxTemp,
    required this.minTemp,
    required this.condition,
    required this.iconUrl,
    required this.sunrise,
    required this.sunset,
    required this.moonrise,
    required this.moonset,
    required this.moonPhase,
    required this.moonIllumination,
  });

  factory ForecastDay.fromJson(Map<String, dynamic> json) {
    final day = json["day"];
    final astro = json["astro"];

    return ForecastDay(
      date: DateTime.parse(json["date"]),

      maxTemp: (day["maxtemp_c"] as num).toDouble(),
      minTemp: (day["mintemp_c"] as num).toDouble(),

      condition: day["condition"]["text"],
      iconUrl: "https:${day["condition"]["icon"]}",

      sunrise: astro["sunrise"],
      sunset: astro["sunset"],

      moonrise: astro["moonrise"],
      moonset: astro["moonset"],

      moonPhase: astro["moon_phase"],
      moonIllumination: (astro["moon_illumination"] as num).toInt(),
    );
  }
}