
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/search_city.dart';
import 'package:weather_app/weather.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  GlobalKey<RefreshIndicatorState> refreshKey;
 Map data={};
 Map<String,String> bgImages= {
   'Clouds':'cloudy.jpeg',
   'Sunny':'sunny.jpg',
   'Rain': 'rainy.jpg',
   'Snow': 'snowy.jpg',
   'Default':'night.jpg',
   "Windy":'windy.jpg'
 };

 Weather weather=Weather();
  String defaultBgImage='';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refreshKey=new GlobalKey<RefreshIndicatorState>();

  }
  Future<Null> refreshWeather() async {

    await Future.delayed(Duration(seconds: 2));
    await weather.getWeather();
    setState(() {
      print(weather.city);
    });

    return null;

  }
  @override
  Widget build(BuildContext context) {
    if(data.isEmpty) {
    data=ModalRoute.of(context).settings.arguments;
    weather.city=data['city'];
    weather.wind=data['wind'];
    weather.cloud=data['cloud'];
    weather.humidity=data['humidity'];
    weather.weatherType=data['weatherType'];
    weather.temp=data['temp'];
    weather.icon=data['icon'];
    weather.time=data['time'];
    weather.timeHour=data['timeHour'];
    }
    print(weather.timeHour);
   defaultBgImage=weather.timeHour>6&&weather.timeHour<18?'sunny.jpg':'night.jpg';



    return Scaffold(

      extendBodyBehindAppBar: true,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.search,
            size: 30,
            color: Colors.white,
          ), onPressed: () async{

            var city=await showSearch(
              delegate: CitySearchDelegate(),
              context: context,
            );
            if(city!=null&&city.isNotEmpty&&city!=weather.city) {
            weather.city=city;
            refreshKey.currentState.show();
            refreshWeather();
            }

        },
        ),
        actions: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: SvgPicture.asset(

              'assets/menu.svg',
              height: 30,
              width: 30,
              color: Colors.white,
              matchTextDirection: true,
            ),
          ),

        ],
      ),
      body: RefreshIndicator(


        key: refreshKey,
        backgroundColor: Colors.black38,
        color: Colors.white,
        onRefresh: () async {
         await refreshWeather();
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),


          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Stack(

              children: [
                Image.asset('assets/${bgImages.containsKey(weather.weatherType)?bgImages[weather.weatherType]:defaultBgImage}',
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                ),

                Container(
                  color: Colors.black38,
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Column(

                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 120,),
                                Text(
                                  ' ${weather.city}',

                                  style: GoogleFonts.lato(

                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold
                                  ),

                                ),
                                SizedBox(height: 8),
                                Text(
                                  "${weather.time}",
                                  style: GoogleFonts.lato(
                                      fontSize: 13,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 1
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${weather.temp} \u00b0',

                            style: GoogleFonts.lato(

                                color: Colors.white,
                                fontSize:90,
                                fontWeight: FontWeight.w300
                            ),

                          ),
                          Row(
                            children: [
                              Image.network(weather.icon,color: Colors.white,width: 50,height: 50,),
                              Text(
                                  '${weather.weatherType}',
                                  style: GoogleFonts.lato(
                                      fontSize: 24,

                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 1
                                  )
                              ),
                            ],
                          ),


                        ],
                      ),
                      Divider(
                        color: Colors.white,
                        thickness: 1,
                        height: 40,


                      ),
                      Container(
                          padding: EdgeInsets.fromLTRB(20, 0, 20,20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Text(
                                    'Wind',
                                    style: GoogleFonts.lato(
                                        color:Colors.grey,
                                        fontSize: 14
                                    ),
                                  ),
                                  SizedBox(height: 12,),
                                  Text(
                                      '${weather.wind}',
                                      style: GoogleFonts.lato(
                                          color:Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22

                                      )
                                  ),
                                  SizedBox(height: 3,),
                                  Text(
                                      'km/h',
                                      style: GoogleFonts.lato(
                                          color:Colors.white,
                                          fontWeight: FontWeight.bold
                                      )
                                  ),
                                  SizedBox(height: 10,),
                                  Stack(
                                    children: [
                                      Container(
                                        height: 3,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            color: Colors.white38,
                                            borderRadius: BorderRadius.circular(15)
                                        ),
                                      ),
                                      Container(
                                        height: 3,
                                        width: weather.wind>50?weather.wind%10:weather.wind,
                                        decoration: BoxDecoration(
                                            color: Colors.greenAccent,
                                            borderRadius: BorderRadius.circular(15)
                                        ),
                                      ),
                                    ],
                                  )

                                ],
                              ),
                              Column(

                                children: [

                                  Text(
                                    'Cloud',
                                    style: GoogleFonts.lato(
                                        color:Colors.grey,
                                        fontSize: 14
                                    ),
                                  ),
                                  SizedBox(height: 12,),
                                  Text(
                                      '${weather.cloud}',
                                      style: GoogleFonts.lato(
                                          color:Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22

                                      )
                                  ),
                                  SizedBox(height: 3,),
                                  Text(
                                      '%',
                                      style: GoogleFonts.lato(
                                          color:Colors.white,
                                          fontWeight: FontWeight.bold
                                      )
                                  ),
                                  SizedBox(height: 10,),
                                  Stack(
                                    children: [
                                      Container(
                                        height: 3,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            color: Colors.white38,
                                            borderRadius: BorderRadius.circular(15)
                                        ),
                                      ),
                                      Container(
                                        height: 3,
                                        width: weather.cloud/2,
                                        decoration: BoxDecoration(
                                            color: Colors.redAccent,
                                            borderRadius: BorderRadius.circular(15)
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Column(

                                children: [

                                  Text(
                                    'Humidity',
                                    style: GoogleFonts.lato(
                                        color:Colors.grey,
                                        fontSize: 14
                                    ),
                                  ),
                                  SizedBox(height: 12,),
                                  Text(
                                      '${weather.humidity}',
                                      style: GoogleFonts.lato(
                                          color:Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22

                                      )
                                  ),
                                  SizedBox(height: 3,),
                                  Text(
                                      '%',
                                      style: GoogleFonts.lato(
                                          color:Colors.white,
                                          fontWeight: FontWeight.bold
                                      )
                                  ),
                                  SizedBox(height: 10,),
                                  Stack(
                                    children: [
                                      Container(
                                        height: 3,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            color: Colors.white38,
                                            borderRadius: BorderRadius.circular(15)
                                        ),
                                      ),
                                      Container(
                                        height: 3,
                                        width: weather.humidity/2,
                                        decoration: BoxDecoration(
                                            color: Colors.redAccent,
                                            borderRadius: BorderRadius.circular(15)
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),


                            ],
                          )
                      )
                    ],
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
