import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:waterhero/core/presentation/design/atoms/atoms.dart';
import 'package:waterhero/core/presentation/utils/date_extension.dart';
import 'package:waterhero/localization/generated/lang.dart';
import 'package:weather/weather.dart';

class WeatherWidget extends StatefulWidget {
  const WeatherWidget({super.key});

  @override
  State<WeatherWidget> createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  //initialize
  static Weather? weather;
  @override
  void initState() {
    Future.delayed(
      Duration.zero,
      getWeather,
    );
    super.initState();
  }

  Future getWeather() async {
    try {
      final wf = WeatherFactory('f80dc3829e798b5fdc198a4e0b98065e');
      //get current location
      final permission = await Geolocator.checkPermission();
      final status = permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse;

      if (!status) {
        await Geolocator.requestPermission();
        await getWeather();
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      ).timeout(const Duration(seconds: 5));

      weather = await wf.currentWeatherByLocation(
        position.latitude,
        position.longitude,
      );
      print(weather);
    } catch (e) {
      print('error $e');
      weather = await WeatherFactory('f80dc3829e798b5fdc198a4e0b98065e')
          .currentWeatherByCityName('Bogota');
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return weather == null
        ? Container(
            //getting data
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  child: const CircularProgressIndicator(),
                ),
                const SizedBox(width: 10),
                CustomText(
                  Lang.of(context).loadingWeather,
                  textColor: Colors.white,
                ),
              ],
            ),
          )
        : Row(
            children: [
              Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Image.network(
                  scale: 1.2,
                  'https://openweathermap.org/img/w/${weather?.weatherIcon}.png',
                ),
              ),
              const SizedBox(width: 10),
              //dot separator
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CustomText(
                        "${weather?.temperature?.celsius.toString().split('.')[0]}°" ??
                            '',
                        textColor: Colors.white,
                        fontSize: 20,
                      ),
                      const SizedBox(width: 3),
                      CustomText(
                        DateTime.now().onlyHoutAMPM(),
                        textColor: Colors.white.withOpacity(.5),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      CustomText(
                        '${weather?.areaName}, ${weather?.country}',
                        textColor: Colors.white.withOpacity(.5),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          );
  }
}
