// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:open_weather_bloc/constants/constants.dart';
import 'package:open_weather_bloc/exceptions/weather_exception.dart';
import 'package:open_weather_bloc/models/direct_geocoding.dart';
import 'package:open_weather_bloc/models/weather.dart';
import 'package:open_weather_bloc/services/http_error_handler.dart';

class WeatherApiServices {
  final http.Client httpClient;
  WeatherApiServices({
    required this.httpClient,
  });

  Future<DirectGeocoding> getDiretGeocoding({required String city}) async {
    final Uri url = Uri(
      scheme: 'https',
      host: kApiHost,
      path: 'geo/1.0/direct',
      queryParameters: {
        'q': city,
        'limit': kLimit,
        'appid': dotenv.env['APPID'],
      },
    );
    try {
      final http.Response response = await httpClient.get(url);
      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        if (responseBody.isEmpty) {
          throw WeatherException('Can not get the location of the $city');
        }
        final directGeocoding = DirectGeocoding.fromJson(responseBody);
        return directGeocoding;
      } else {
        throw httpErrorHandler(response);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Weather> getWeather(DirectGeocoding directGeocoding) async {
    final Uri url = Uri(
      scheme: 'https',
      host: kApiHost,
      path: '/data/2.5/weather',
      queryParameters: {
        'lat': '${directGeocoding.lat}',
        'lon': '${directGeocoding.lon}',
        'units': kUnit,
        'appid': dotenv.env['APPID'],
      },
    );

    try {
      final http.Response response = await httpClient.get(url);
      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        final weather = Weather.fromJson(responseBody);
        return weather;
      } else {
        throw httpErrorHandler(response);
      }
    } catch (e) {
      rethrow;
    }
  }
}
