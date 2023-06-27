// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:open_weather_bloc/exceptions/weather_exception.dart';
import 'package:open_weather_bloc/models/custom_error.dart';
import 'package:open_weather_bloc/models/direct_geocoding.dart';
import 'package:open_weather_bloc/services/weather_api_services.dart';

import '../models/weather.dart';

class WeatherRepository {
  final WeatherApiServices weatherApiServices;
  WeatherRepository({
    required this.weatherApiServices,
  });

  Future<Weather> fetchWeather(String city) async {
    try {
      final DirectGeocoding directGeocoding =
          await weatherApiServices.getDiretGeocoding(city: city);
      print('directGeocoding: $directGeocoding');
      final Weather tempWeather =
          await weatherApiServices.getWeather(directGeocoding);
      print('tempWeather: $tempWeather');
      final Weather weather = tempWeather.copyWith(
        name: directGeocoding.name,
        country: directGeocoding.country,
      );
      return weather;
    } on WeatherException catch (e) {
      throw CustomeError(errorMsg: e.message);
    } catch (e) {
      throw CustomeError(errorMsg: e.toString());
    }
  }

  @override
  String toString() =>
      'WeatherRepository(weatherApiServices: $weatherApiServices)';
}
