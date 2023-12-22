import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import 'city_search_box.dart';
import 'current_weather.dart';
import 'hourly_weather.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key, required this.city}) : super(key: key);
  final String city;

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late LinearGradient _gradient;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this,
    )..repeat(reverse: true);

    _controller.addListener(() {
      setState(() {
        // Update the colors of the gradient based on the animation value
        _gradient = LinearGradient(
          colors: [
            Color(0xFF8200B0).withOpacity(_controller.value),
            Color(0xFF8200B0).withOpacity(1-_controller.value * 0.2), // Adjust the factor for the slight change
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      });
    });

    _gradient = LinearGradient(
      colors: [Color(0xFF8200B0), Color(0xFF8200B0)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: _gradient,
        ),
        child: const SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: 100,),
              CitySearchBox(),
              SizedBox(height: 80,),
              CurrentWeather(),
              Spacer(),
              HourlyWeather(),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
