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
      return 'π©';
    } else if (condition < 400) {
      return 'π§';
    } else if (condition < 600) {
      return 'β';
    } else if (condition < 700) {
      return 'β';
    } else if (condition < 800) {
      return 'π«';
    } else if (condition == 800) {
      return 'β';
    } else if (condition <= 804) {
      return 'β';
    } else {
      return 'π€·β';
    }
  }
  String getWeatherwritng(int condition) {
    if (condition < 300) {
      return 'μ²λ₯κ΅¬λ¦μ΄ μ³μ';
    } else if (condition < 400) {
      return 'λΉκ° μ‘°κΈ μμ';
    } else if (condition < 600) {
      return 'λΉκ° λ§μ΄ μμ';
    } else if (condition < 700) {
      return 'λμ΄ μμ';
    } else if (condition < 800) {
      return 'λ¨Όμ§μ μκ°κ° λΌμμ΄μ';
    } else if (condition == 800) {
      return 'κ΅¬λ¦νμ  μμ΄μ';
    } else if (condition <= 804) {
      return 'κ΅¬λ¦μ΄ μ½κ° μμ΄μ';
    } else {
      return 'μΌμ λ°λμ΄ λλ¬΄ λΆμ΄μβ';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'λλ¬΄ λ₯λ€μ, μμ΄μ€ν¬λ¦Ό νλ λ¨Ήμ£ ';
    } else if (temp > 20) {
      return 'π λ°ν μμ΄μΌκ² λ€μ';
    } else if (temp < 10) {
      return 'λͺ©λλ¦¬λ μ₯κ°μ΄ νμν΄μ';
    } else {
      return 'μμνλ μ μ±κ²¨μμ΄μ';
    }
  }
}