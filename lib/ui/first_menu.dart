import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hyojason/utility/weather.dart';
import 'myday/myday.dart';
import 'life_information/information_screen.dart';
import 'news/news_screen.dart';

class FirstMenu extends StatefulWidget {
  FirstMenu({this.locationWeather, this.userData,this.lat,this.lng});
  final userData;
  final locationWeather;
  final lat,lng;

  @override
  _FirstMenuState createState() => _FirstMenuState(
    lat:lat,
    lng:lng
  );
}

class _FirstMenuState extends State<FirstMenu> {

  _FirstMenuState({this.lat,this.lng});
  final lat;
  final lng;

  WeatherModel weather = WeatherModel();

  late int temperature;
  late String weatherIcon;
  late String weatherwriting;
  late String cityName;
  late String weatherMessage;

  static Color mainColor = const Color(0xff6524FF);
  double buttonsHeight = 50;

  @override
  void initState() {
    super.initState();

    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        weatherMessage = 'Unable to get weather data';
        cityName = '';
        return;
      }
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
      weatherwriting= weather.getWeatherwritng(condition);
      weatherMessage = weather.getMessage(temperature);
      cityName = weatherData['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Container(),
        centerTitle: true,
        elevation: 0.0,
        title: Padding(
          padding: const EdgeInsets.only(top: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                '효자손',
                style: TextStyle(fontFamily: 'Chosun', fontSize: 30),
              ),
            ],
          ),
        ),
        backgroundColor: mainColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: 250,
            color: mainColor,
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                Text(
                  weatherIcon,
                  style: const TextStyle(fontSize: 50,
                      color: Colors.white,
                      fontFamily: 'NanumBold'),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  ' $temperature°C',
                  style: const TextStyle(fontSize: 30,
                      color: Colors.white,
                      fontFamily: 'NanumBold'),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  weatherwriting,
                  style: const TextStyle(fontSize: 30,
                      color: Colors.white,
                      fontFamily: 'NanumBold'),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '$weatherMessage ',
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontSize: 30,
                      color: Colors.white,
                      fontFamily: 'NanumBold'),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(40),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NewsScreen()),
                    );
                  },
                  child: Card(
                    elevation: 5,
                    child: SizedBox(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: ListTile(
                          leading: const Text(
                            '뉴스정보',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 38,
                                fontFamily: 'Noto'),
                          ),
                          trailing: Image.asset(
                            'images/news.png',
                            width: 70,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => InformationScreen(
                        lat:lat,
                        lng:lng,
                      ),
                    ),);
                  },
                  child: Card(
                    elevation: 5,
                    child: SizedBox(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: ListTile(
                          leading: const Text(
                            '생활정보',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 38,
                                fontFamily: 'Noto'),
                          ),
                          trailing: Image.asset(
                            'images/life.png',
                            width: 70,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MydayScreen()
                      ),);
                  },
                  child: Card(
                    elevation: 5,
                    child: SizedBox(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: ListTile(
                          leading: const Text(
                            '나의하루',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 38,
                                fontFamily: 'Noto'),
                          ),
                          trailing: Image.asset(
                            'images/land.png',
                            width: 70,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
