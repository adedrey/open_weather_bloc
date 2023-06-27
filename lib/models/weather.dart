// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final String name;
  final String country;
  final String description;
  final String icon;
  final DateTime lastUpdated;
  final double temp;
  final double tempMax;
  final double tempMin;
  Weather({
    required this.name,
    required this.country,
    required this.description,
    required this.icon,
    required this.lastUpdated,
    required this.temp,
    required this.tempMax,
    required this.tempMin,
  });

  factory Weather.initial() => Weather(
        name: '',
        country: '',
        description: '',
        icon: '',
        lastUpdated: DateTime(1970),
        temp: 100.0,
        tempMax: 100.0,
        tempMin: 100.0,
      );

  @override
  String toString() {
    return 'Weather(name: $name, country: $country, description: $description, icon: $icon, lastUpdated: $lastUpdated, temp: $temp, tempMax: $tempMax, tempMin: $tempMin)';
  }

  @override
  List<Object> get props {
    return [
      name,
      country,
      description,
      icon,
      lastUpdated,
      temp,
      tempMax,
      tempMin,
    ];
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'country': country,
      'description': description,
      'icon': icon,
      'lastUpdated': lastUpdated.millisecondsSinceEpoch,
      'temp': temp,
      'tempMax': tempMax,
      'tempMin': tempMin,
    };
  }

  factory Weather.fromJson(Map<String, dynamic> json) {
    final weather = json["weather"][0];
    final main = json["main"];
    return Weather(
      name: '',
      country: '',
      description: weather['description'],
      icon: weather['icon'],
      lastUpdated: DateTime.now(),
      temp: main['temp'] ?? 0,
      tempMax: main['temp_max'] ?? 0,
      tempMin: main['temp_min'] ?? 0,
    );
  }

  Weather copyWith({
    String? name,
    String? country,
    String? description,
    String? icon,
    DateTime? lastUpdated,
    double? temp,
    double? tempMax,
    double? tempMin,
  }) {
    return Weather(
      name: name ?? this.name,
      country: country ?? this.country,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      temp: temp ?? this.temp,
      tempMax: tempMax ?? this.tempMax,
      tempMin: tempMin ?? this.tempMin,
    );
  }
}
