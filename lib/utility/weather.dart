import 'location.dart';
import 'networking.dart';

const apiKey = '3a88cd2dceb8cf62155f13532f521d6f';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?lat=${location.lat}&lon=${location.long}&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔';
    } else if (condition < 700) {
      return '☃';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀';
    } else if (condition <= 804) {
      return '☁';
    } else {
      return '🤷‍';
    }
  }
  String getWeatherwritng(int condition) {
    if (condition < 300) {
      return '천둥구름이 쳐요';
    } else if (condition < 400) {
      return '비가 조금 와요';
    } else if (condition < 600) {
      return '비가 많이 와요';
    } else if (condition < 700) {
      return '눈이 와요';
    } else if (condition < 800) {
      return '먼지와 안개가 끼었어요';
    } else if (condition == 800) {
      return '구름한점 없어요';
    } else if (condition <= 804) {
      return '구름이 약간 있어요';
    } else {
      return '으악 바람이 너무 불어요‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return '너무 덥네요, 아이스크림 하나 먹죠';
    } else if (temp > 20) {
      return '👕 반팔 입어야겠네요';
    } else if (temp < 10) {
      return '목도리랑 장갑이 필요해요';
    } else {
      return '쌀쌀하니 잘 챙겨입어요';
    }
  }
}