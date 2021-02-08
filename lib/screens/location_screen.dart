import 'package:clima/screens/search_screen.dart';

import '../services/weather.dart';
import './search_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen(this.locationWeather);
  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int temperature;
  int condition;
  String cityname;
  String weatherIcon;
  String weatherMsg;

  @override
  void initState() {
    updateUI(widget.locationWeather);
    super.initState();
  }

  WeatherModel weatherModel = WeatherModel();

  void updateUI(dynamic weatherData) {
    if (weatherData == null) {
      temperature = 0;
      cityname = " ";
      weatherIcon = "Error";
      weatherMsg = "Unable to get weather Data";
      return;
    }
    setState(() {
      temperature = (weatherData["main"]["temp"]).toInt();
      condition = weatherData['weather'][0]['id'];
      cityname = weatherData['name'];
      weatherIcon = weatherModel.getWeatherIcon(condition);
      weatherMsg = weatherModel.getMessage(temperature);
    });
  }

  final dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
//after 5pm background image will change to milkyway.jpg
    final currentHour = dateTime.hour;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: currentHour <= 17
                ? AssetImage('images/jellyfish.jpg')
                : AssetImage('images/milky-way.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(children: [
                    FlatButton(
                      onPressed: () async {
                        var weatherData =
                            await weatherModel.getLocationWeather();

                        updateUI(weatherData);
                      },
                      child: Icon(
                        Icons.near_me,
                        size: 50.0,
                      ),
                    ),
                    Text("Update")
                  ]),
                  Column(children: [
                    FlatButton(
                      onPressed: () async {
                        var typedName = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => SearchScreen(),
                          ),
                        );
                        if(typedName !=null){
                        var weatherData = await weatherModel.getWeatherByLocation(typedName);
                        updateUI(weatherData);}

                      },
                      child: Icon(
                        Icons.location_city,
                        size: 50.0,
                      ),
                    ),
                    Text("Search"),
                  ]),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  " ${weatherMsg} in $cityname!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
