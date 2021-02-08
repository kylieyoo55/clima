import 'package:clima/utilities/constants.dart';
import '../services/weather.dart';
import 'package:flutter/material.dart';

import './location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';



class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  void getLocationData  () async{

    //getting url from weather.dart

var weatherData= await WeatherModel().getLocationWeather();

Navigator.push(context, MaterialPageRoute(builder: (ctx)=>LocationScreen(weatherData)) );


 }

  @override
  void initState() {
   
    super.initState();
    
     getLocationData();
  }

  @override
  Widget build(BuildContext context) {

  const spinkit = SpinKitRotatingCircle(
  color: Colors.white,
  size: 80.0,
);


    return Scaffold(
      body: Center(child: Column
      (mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Text("Loading......",
        style: kButtonTextStyle,),
        SizedBox(height:20),
        spinkit,
      ],),),
    );
  }
}
