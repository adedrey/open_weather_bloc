import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:open_weather_bloc/models/custom_error.dart';
import 'package:open_weather_bloc/models/weather.dart';
import 'package:open_weather_bloc/repositories/weather_Repo.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherCubit({required this.weatherRepository})
      : super(WeatherState.initial());

  Future<void> fetchWeather(String city) async {
    emit(
      state.copyWith(
        weatherStatus: WeatherStatus.loading,
      ),
    );
    print("state: $state");
    try {
      final weather = await weatherRepository.fetchWeather(city);
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
