
import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class Weather{
  String time='';
  var timeHour=0;
  var temp=0.0;
  var city='Ahmedabad';
  var wind=0.0;
  var rain=0.0;
  var humidity=0.0;
  var weatherType='';
  var cloud=0.0;
  var icon="http://openweathermap.org/img/wn/10d@2x.png";
  bool available=false;

  Future<void> getWeather() async {

    print(city);
    try {
      Response response = await get("https://api.openweathermap.org/data/2.5/weather?q=$city&appid=0c9076be4a12928bce182fc6e65bf9ba&units=metric");
      Map<String,dynamic> data=jsonDecode(response.body);


      dynamic main=data['main'];
      this.temp=checkDouble(main['temp']);
      this.humidity=checkDouble(main['humidity']);
      print(temp);
      print(humidity);

      dynamic windData=data['wind'];
      print(windData);
      this.wind=checkDouble(windData['speed']);
      print(this.wind);

      dynamic wt=data['weather'];
      dynamic wtType=wt[0];
      this.weatherType=wtType['main'];
      print(weatherType);
      var iconValue=wtType['icon'];
      icon="https://openweathermap.org/img/wn/$iconValue@2x.png";

      dynamic cloudData=data['clouds'];
      this.cloud=checkDouble(cloudData['all']);
      print(cloud);
      available=true;

      var timeZone=data['timezone'];
      var dateTime=DateTime.now().add(Duration(seconds: timeZone - DateTime.now().timeZoneOffset.inSeconds));
      time=DateFormat("hh:mm aaa - EEEE,d MMM''yy").format(dateTime).toString();
      timeHour=int.parse(DateFormat("HH").format(dateTime));

    }

    catch(e){

    print(e);
      available=false;
    }

  }

  static double checkDouble(dynamic value) {
    if (value is String) {
      return double.parse(value);
    } else {
      return value+0.0;
    }
  }

}

