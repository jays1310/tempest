import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'providers/weather_provider.dart';
import 'screens/splash_screen.dart';
import 'utils/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  runApp(
    ChangeNotifierProvider(
      create: (_) => WeatherProvider(),
      child: const Tempest(),
    ),
  );
}

class Tempest extends StatelessWidget {
  const Tempest({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tempest',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        fontFamily: 'Poppins',
      ),
      home: const SplashScreen(),
    );
  }
}