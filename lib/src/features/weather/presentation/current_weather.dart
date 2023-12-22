import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../application/providers.dart';
import '../domain/weather/weather_data.dart';
import 'weather_icon_image.dart';

class CurrentWeather extends ConsumerWidget {
  const CurrentWeather({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherDataValue = ref.watch(currentWeatherProvider);
    final city = ref.watch(cityProvider);
    return Container(
      child: Column(
        children: [
          const Text(
            "City name",
            textAlign: TextAlign.left,
          ),
          Text(city, style: Theme.of(context).textTheme.headlineMedium),
          Container(
            child: weatherDataValue.when(
              data: (weatherData) => CurrentWeatherContents(data: weatherData),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, __) => Text(e.toString()),
            ),
          ),
        ],
      ),
    );
  }
}

class CurrentWeatherContents extends ConsumerWidget {
  const CurrentWeatherContents({super.key, required this.data});

  final WeatherData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;

    final temp = data.temp.celsius.toInt().toString();
    final minTemp = data.minTemp.celsius.toInt().toString();
    final maxTemp = data.maxTemp.celsius.toInt().toString();
    final description = data.description.toString();
    final highAndLow =
        'Low : $minTemp°C             High : $maxTemp°C';

    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            child: func(description),
            width: 100,
            height: 100,
          ),
          Container(
            child: Column(
              children: [
                Text('$temp°C', style: textTheme.displayMedium),
                SizedBox(height: 20), // Adjust the height as needed
                Text(highAndLow, style: textTheme.bodyMedium),
                SizedBox(height: 20,),
                Text("$description"),
              ],
            ),
          )
        ],
      ),
    );
  }
}

func(description) {
  if (description == "Rain") {
    return Image.asset(
      'assets/weather 8.png',
    );
  } else if (description == "Clouds")
    return Image.asset(
      'assets/weather 1.png',
    );
  else if (description == "Clear")
    return Image.asset(
      'assets/weather 01.png',
    );
  else if (description == "Haze")
    return Image.asset(
      'assets/weather 2.png',
    );

}
