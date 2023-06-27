import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:open_weather_bloc/repositories/weather_Repo.dart';

import '../../models/custom_error.dart';
import '../../models/weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherBloc({required this.weatherRepository})
      : super(WeatherState.initial()) {
    on<FetchWeatherEvent>(_fetchWeather);
  }

  Future<void> _fetchWeather(
      FetchWeatherEvent event, Emitter<WeatherState> emit) async {
    emit(
      state.copyWith(
        weatherStatus: WeatherStatus.loading,
      ),
    );
    print("state: $state");
    try {
      final weather = await weatherRepository.fetchWeather(event.city);
      emit(
        state.copyWith(
          weather: weather,
          weatherStatus: WeatherStatus.loaded,
        ),
      );
      print("state: $state");
    } on CustomeError catch (e) {
      emit(
        state.copyWith(
          error: e,
          weatherStatus: WeatherStatus.error,
        ),
      );
      print("state: $state");
    }
  }
}
