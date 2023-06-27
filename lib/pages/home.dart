import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_weather_bloc/blocs/weather/weather_bloc.dart';
import 'package:open_weather_bloc/pages/search.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String? city;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather"),
        actions: [
          IconButton(
            onPressed: () async {
              city = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchView(),
                ),
              );
              if (city != null) {
                context
                    .read<WeatherBloc>()
                    .add(FetchWeatherEvent(city: city ?? ''));
              }
            },
            icon: Icon(Icons.search),
          ),
          SizedBox(
            width: 5,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: BlocConsumer<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state.weatherStatus == WeatherStatus.initial) {
            return const Center(
              child: Text(
                'Select a city',
                style: TextStyle(fontSize: 20),
              ),
            );
          }
          if (state.weatherStatus == WeatherStatus.error &&
              state.weather.name.isEmpty) {
            return const Center(
              child: Text(
                'Select a city',
                style: TextStyle(fontSize: 20),
              ),
            );
          }
          if (state.weatherStatus == WeatherStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Center(
            child: Text(
              state.weather.name,
              style: TextStyle(fontSize: 20),
            ),
          );
        },
        listener: (context, state) {
          if (state.weatherStatus == WeatherStatus.error) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: Text(state.error.errorMsg),
              ),
            );
          }
        },
      ),
    );
  }
}
