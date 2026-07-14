class CitySuggestion {
  final String name;
  final String region;
  final String country;

  const CitySuggestion({
    required this.name,
    required this.region,
    required this.country,
  });

  factory CitySuggestion.fromJson(Map<String, dynamic> json) {
    return CitySuggestion(
      name: json["name"] ?? "",
      region: json["region"] ?? "",
      country: json["country"] ?? "",
    );
  }

  String get fullName {
    if (region.isEmpty) {
      return "$name, $country";
    }

    return "$name, $region, $country";
  }
}