import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/sky_cycle_card.dart';
import '../providers/weather_provider.dart';
import '../utils/weather_background.dart';
import '../widgets/background/weather_scene.dart';
import '../widgets/custom_search.dart';
import '../widgets/forecast_card.dart';
import '../widgets/hourly_forecast.dart';
import '../widgets/weather_card.dart';
import '../widgets/weather_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      context.read<WeatherProvider>().fetchWeather(
        latitude: 19.0760,
        longitude: 72.8777,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<WeatherProvider>();

    final weeklyMin = provider.weeklyForecast.isEmpty
        ? 0.0
        : provider.weeklyForecast
        .map((e) => e.minTemp)
        .reduce((a, b) => a < b ? a : b);

    final weeklyMax = provider.weeklyForecast.isEmpty
        ? 0.0
        : provider.weeklyForecast
        .map((e) => e.maxTemp)
        .reduce((a, b) => a > b ? a : b);

    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 1200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          gradient: WeatherBackground.gradient(
            provider.weather?.condition,
            provider.weather?.isDay ?? true,
          ),
        ),
        child: Stack(
          children: [
            WeatherScene(
              condition: provider.weather?.condition,
              isDay: provider.weather?.isDay ?? true,
            ),

            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (provider.error != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Text(
                          provider.error!,
                          style: const TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                    CustomSearch(
                      onLocationTap: () async {
                        await provider.fetchCurrentLocationWeather();
                      },
                      onSearch: (city) async {
                        await provider.fetchWeatherByCity(city);
                      },
                    ),

                    const SizedBox(height: 25),

                    WeatherHeader(
                      city: provider.weather?.city ?? "Loading...",
                      temperature: provider.weather != null
                          ? "${provider.weather!.temperature.round()}°"
                          : "--°",
                      condition: provider.weather != null
                          ? _formatDescription(
                        provider.weather!.description,
                      )
                          : "Loading...",
                      high: provider.weather != null
                          ? "${provider.weather!.maxTemperature.round()}°"
                          : "--",
                      low: provider.weather != null
                          ? "${provider.weather!.minTemperature.round()}°"
                          : "--",
                      aqi: provider.weather?.aqi ?? "Unknown",
                      icon: _getWeatherIcon(
                        provider.weather?.condition,
                      ),
                    ),

                    const SizedBox(height: 30),

                    if (provider.weather != null &&
                        provider.weeklyForecast.isNotEmpty) ...[
                      SkyCycleCard(
                        sunrise: provider.weeklyForecast.first.sunrise,
                        sunset: provider.weeklyForecast.first.sunset,
                        moonrise: provider.weeklyForecast.first.moonrise,
                        moonset: provider.weeklyForecast.first.moonset,
                        localTime: provider.weather!.localTime,
                      ),

                      const SizedBox(height: 35),
                    ],

                    const Text(
                      "Today's Highlights",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: 1.18,
                      children: [
                        WeatherCard(
                          icon: Icons.thermostat,
                          title: "Feels Like",
                          value: provider.weather != null
                              ? "${provider.weather!.feelsLike.round()}°"
                              : "--",
                          subtitle: "Feels Like",
                          iconColor: Colors.orange,
                        ),

                        WeatherCard(
                          icon: Icons.water_drop,
                          title: "Humidity",
                          value: provider.weather != null
                              ? "${provider.weather!.humidity}%"
                              : "--",
                          subtitle: "Relative Humidity",
                          iconColor: Colors.lightBlueAccent,
                        ),

                        WeatherCard(
                          icon: Icons.air,
                          title: "Wind",
                          value: provider.weather != null
                              ? "${(provider.weather!.windSpeed * 3.6).round()} km/h"
                              : "--",
                          subtitle: "Current Wind",
                          iconColor: Colors.greenAccent,
                        ),

                        WeatherCard(
                          icon: Icons.speed,
                          title: "Pressure",
                          value: provider.weather != null
                              ? "${provider.weather!.pressure} hPa"
                              : "--",
                          subtitle: "Atmospheric",
                          iconColor: Colors.purpleAccent,
                        ),
                      ],
                    ),

                    const SizedBox(height: 35),

                    const Text(
                      "Hourly Forecast",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),

                    const SizedBox(height: 15),

                    HourlyForecast(
                      hourlyData: provider.hourlyForecast,
                    ),

                    const SizedBox(height: 35),

                    const Text(
                      "7-Day Forecast",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),

                    const SizedBox(height: 20),

                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: provider.weeklyForecast.length,
                      itemBuilder: (context, index) {
                        return ForecastCard(
                          forecast: provider.weeklyForecast[index],
                          weeklyMin: weeklyMin,
                          weeklyMax: weeklyMax,
                          currentTemp: index == 0
                              ? provider.weather?.temperature
                              : null,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDescription(String description) {
    return description
        .split(' ')
        .map(
          (word) =>
      word.isEmpty
          ? word
          : word[0].toUpperCase() + word.substring(1),
    )
        .join(' ');
  }

  IconData _getWeatherIcon(String? condition) {
    switch (condition?.toLowerCase()) {

    // ☀ Clear
      case "sunny":
      case "clear":
        return Icons.wb_sunny_rounded;

    // ☁ Cloudy
      case "partly cloudy":
      case "cloudy":
      case "overcast":
        return Icons.cloud_rounded;

    // 🌫 Mist / Fog
      case "mist":
      case "fog":
      case "freezing fog":
      case "haze":
        return Icons.cloud;

    // 🌦 Drizzle / Light Rain
      case "patchy rain nearby":
      case "patchy light drizzle":
      case "light drizzle":
      case "freezing drizzle":
      case "heavy freezing drizzle":
        return Icons.grain;

    // 🌧 Rain
      case "patchy light rain":
      case "light rain":
      case "moderate rain at times":
      case "moderate rain":
      case "heavy rain at times":
      case "heavy rain":
      case "light rain shower":
      case "moderate or heavy rain shower":
      case "torrential rain shower":
        return Icons.water_drop_rounded;

    // ❄ Snow / Sleet / Ice
      case "patchy snow nearby":
      case "patchy light snow":
      case "light snow":
      case "patchy moderate snow":
      case "moderate snow":
      case "patchy heavy snow":
      case "heavy snow":
      case "light snow showers":
      case "moderate or heavy snow showers":

      case "light sleet":
      case "moderate or heavy sleet":
      case "light sleet showers":
      case "moderate or heavy sleet showers":

      case "ice pellets":
      case "light showers of ice pellets":
      case "moderate or heavy showers of ice pellets":
        return Icons.ac_unit;

    // ⛈ Thunder
      case "thundery outbreaks nearby":
      case "patchy light rain with thunder":
      case "moderate or heavy rain with thunder":
      case "patchy light snow with thunder":
      case "moderate or heavy snow with thunder":
        return Icons.thunderstorm_rounded;

      default:
        return Icons.cloud;
    }
  }
}