// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:equatable/equatable.dart';

class DirectGeocoding extends Equatable {
  final String name;
  final String country;
  final double lat;
  final double lon;
  DirectGeocoding({
    required this.name,
    required this.country,
    required this.lat,
    required this.lon,
  });

  @override
  List<Object> get props => [name, country, lat, lon];

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'country': country,
      'lat': lat,
      'lon': lon,
    };
  }

  factory DirectGeocoding.fromJson(List<dynamic> data) {
    final Map<String, dynamic> json = data[0];
    return DirectGeocoding(
      name: json['name'],
      country: json['country'],
      lat: json['lat'] ?? 0,
      lon: json['lon'] ?? 0,
    );
  }

  @override
  String toString() {
    return 'DirectGeocoding(name: $name, country: $country, lat: $lat, lon: $lon)';
  }
}
