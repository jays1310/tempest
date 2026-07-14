import 'package:flutter/material.dart';

class WeatherBackground {
  static LinearGradient gradient(
      String? condition,
      bool isDay,
      ) {
    switch (condition?.toLowerCase()) {
    // =========================
    // CLEAR
    // =========================
      case "sunny":
      case "clear":
        if (isDay) {
          return const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF69A8FF),
              Color(0xFF3B73FF),
              Color(0xFF13294B),
            ],
          );
        }

        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF0D1B3A),
            Color(0xFF09142A),
            Color(0xFF030712),
          ],
        );

    // =========================
    // CLOUDY
    // =========================
      case "partly cloudy":
      case "overcast":
      case "clouds":
        if (isDay) {
          return const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF6F8DB6),
              Color(0xFF435B7D),
              Color(0xFF1E293B),
            ],
          );
        }

        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF334155),
            Color(0xFF1E293B),
            Color(0xFF0F172A),
          ],
        );

    // =========================
    // RAIN
    // =========================
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
        if (isDay) {
          return const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF4B6CB7),
              Color(0xFF2C3E70),
              Color(0xFF111827),
            ],
          );
        }

        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF1A2746),
            Color(0xFF111827),
            Color(0xFF040812),
          ],
        );

    // =========================
    // THUNDERSTORM
    // =========================
      case "thundery outbreaks in nearby":

      case "patchy light rain with thunder":
      case "moderate or heavy rain with thunder":

      case "patchy light snow with thunder":
      case "moderate or heavy snow with thunder":
      case "thunderstorm":
        if (isDay) {
          return const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF5C5470),
              Color(0xFF352F44),
              Color(0xFF111827),
            ],
          );
        }

        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF231942),
            Color(0xFF111827),
            Color(0xFF020617),
          ],
        );

    // =========================
    // SNOW
    // =========================
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
        if (isDay) {
          return const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE3F2FD),
              Color(0xFFB3E5FC),
              Color(0xFF78909C),
            ],
          );
        }

        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF455A64),
            Color(0xFF263238),
            Color(0xFF111827),
          ],
        );

    // =========================
    // MIST / FOG / HAZE
    // =========================
      case "mist":
      case "fog":
      case "freezing fog":
      case "haze":
      case "smoky haze":
        if (isDay) {
          return const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF8FA3BF),
              Color(0xFF607D8B),
              Color(0xFF37474F),
            ],
          );
        }

        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF4B5563),
            Color(0xFF374151),
            Color(0xFF111827),
          ],
        );

    // =========================
    // DEFAULT
    // =========================
      default:
        if (isDay) {
          return const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF5B9DFF),
              Color(0xFF2D5BFF),
              Color(0xFF0B1020),
            ],
          );
        }

        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF16213E),
            Color(0xFF0F172A),
            Color(0xFF020617),
          ],
        );
    }
  }
}