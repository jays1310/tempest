import 'package:flutter/material.dart';
import 'mist_layer.dart';
import 'rain_layer.dart';
import 'lightning_layer.dart';
import 'cloud_layer.dart';
import 'sun_glow.dart';
import 'snow_layer.dart';
import 'night_sky_layer.dart';

class WeatherScene extends StatelessWidget {
  final String? condition;
  final bool isDay;

  const WeatherScene({
    super.key,
    required this.condition,
    required this.isDay,
  });

  @override
  Widget build(BuildContext context) {
    switch (condition?.toLowerCase()) {
      case "clear":
      case "sunny":
        return isDay
          ? const SunGlow()
          : const NightSkyLayer();

      case "partly cloudy":
      case "overcast":
      case "clouds":
        return isDay
            ? const CloudLayer()
            : const Stack(
          children: [
            NightSkyLayer(),
            CloudLayer(),
          ],
        );

      case "mist":
      case "fog":
      case "freezing fog":
      case "haze":
      case "smoky haze":
        return isDay
            ? const MistLayer()
            : const Stack(
          children: [
            NightSkyLayer(),
            MistLayer(),
          ],
        );

      case "patchy rain nearby":
      case "patchy light drizzle":
      case "light drizzle":
      case "freezing drizzle":
      case "heavy freezing drizzle":

      case "patchy light rain":
      case "light rain":
      case "light rain shower":

      case "moderate rain at times":
      case "moderate rain":
      case "heavy rain at times":
      case "heavy rain":
      case "moderate or heavy rain shower":
      case "torrential rain shower":
        return isDay
            ? const RainLayer()
            : const Stack(
          children: [
            NightSkyLayer(),
            RainLayer(),
          ],
        );

      case "thundery outbreaks in nearby":

      case "patchy light rain with thunder":
      case "moderate or heavy rain with thunder":

      case "patchy light snow with thunder":
      case "moderate or heavy snow with thunder":
      case "thunderstorm":
        return isDay
            ? const Stack(
          children: [
            RainLayer(),
            LightningLayer(),
          ],
        )
            : const Stack(
          children: [
            NightSkyLayer(),
            RainLayer(),
            LightningLayer(),
          ],
        );

      case "light sleet":
      case "moderate or heavy sleet":

      case "light sleet showers":
      case "moderate or heavy sleet showers":

      case "ice pellets":
      case "light showers of ice pellets":
      case "moderate or heavy showers of ice pellets":
      case "snow":
      case "patchy snow nearby":
      case "patchy light snow":
      case "light snow":

      case "patchy moderate snow":
      case "moderate snow":

      case "patchy heavy snow":
      case "heavy snow":

      case "light snow showers":
      case "moderate or heavy snow showers":
        return isDay
            ? const SnowLayer()
            : const Stack(
          children: [
            NightSkyLayer(),
            SnowLayer(),
          ],
        );

      default:
        return const SizedBox();
    }
  }
}