import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../application/providers.dart';
import '../domain/weather/weather_data.dart';
import 'weather_icon_image.dart';

class HourlyWeather extends ConsumerWidget {
  const HourlyWeather({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final forecastDataValue = ref.watch(hourlyWeatherProvider);
    return forecastDataValue.when(
      data: (forecastData) {
        // API returns data points in 3-hour intervals -> 1 day = 8 intervals
        final items = [0, 8, 16, 24, 32 ,39];
        return HourlyWeatherRow(
          weatherDataItems: [
            for (var i in items) forecastData.list[i],
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, __) => Text(e.toString()),
    );
  }
}

class HourlyWeatherRow extends StatelessWidget {
  const HourlyWeatherRow({super.key, required this.weatherDataItems});
  final List<WeatherData> weatherDataItems;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: weatherDataItems
          .map((data) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0), // Adjust the horizontal gap as needed
        child: Column(
          children: [
            HourlyWeatherItem(data: data),
          ],
        ),
      ))
          .toList(),
    );
  }
}

class HourlyWeatherItem extends ConsumerWidget {
  const HourlyWeatherItem({super.key, required this.data});

  final WeatherData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme
        .of(context)
        .textTheme;
    const fontWeight = FontWeight.normal;
    final temp = data.temp.celsius.toInt().toString();

    return Container(
      padding: const EdgeInsets.only(top:10.0,left:8.0,right:8.0 ,bottom: 10.0), // Adjust the padding as needed
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 0,
            offset: const Offset(0, 2),
          ),
        ],
        borderRadius: BorderRadius.circular(
            5.0), // Adjust the curve radius as needed
      ),
      child: Stack(
        children: [ // Background image
          Column(
            children: [
              WeatherIconImage(iconUrl: data.iconUrl, size: 48),
              Text(
                DateFormat.E().format(data.date),
                style: textTheme.bodySmall!.copyWith(fontWeight: fontWeight),
              ),
              const SizedBox(height: 3),
              Text(
                '$temp°',
                style: textTheme.bodyLarge!.copyWith(fontWeight: fontWeight),
              ),
            ],
          ),
        ],
      ),
    );
  }
}