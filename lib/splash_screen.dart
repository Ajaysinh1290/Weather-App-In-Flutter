import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/weather.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  Weather weather=Weather();
  Future<void> setUpData() async{

    await weather.getWeather();
    Navigator.pushReplacementNamed(context, '/home',arguments:
    {
      'city':weather.city,
      'wind':weather.wind,
      'temp':weather.temp,
      'cloud':weather.cloud,
      'weatherType':weather.weatherType,
      'humidity':weather.humidity,
      'icon':weather.icon,
      'time':weather.time,
      'timeHour':weather.timeHour,
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setUpData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(

        children: [

          Image.asset(''
              'assets/rainy.jpg',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Container(
            color: Colors.grey[900],
          ),
          Center(

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  CupertinoIcons.cloud_sun_rain,
                  size: 150,
                  color: Colors.grey[500],

                ),
                SizedBox(height: 10,),
                Text(
                  'Weather App',
                  style: GoogleFonts.lato(
                    fontSize: 40,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),

          )
        ],
      ),
    );
  }
}
