import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hyojason/utility/weather.dart';
import 'first_menu.dart';

class LoadingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoadingScreenState();
  }
}

class _LoadingScreenState extends State<LoadingScreen> {

  late double lat;
  late double lng;

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;



  getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      lat = position.latitude;
      lng = position.longitude;

    });
    print(lat);
    print(lng);
  }
/* Sign In anon */
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/1.png'), fit: BoxFit.fill),
          ),
          child: Container(
            alignment: const Alignment(0, 0.8),
            child: const Text('화면을 눌러주세요!',
                style: TextStyle(fontSize: 20, color: Colors.white)),
          ),
        ),
        onTap: () async {
          dynamic result = await signInAnon();
          if (result == null) {
            print('@@ error signing in');
          } else {
            print('@@ signed in');
            print(result); // return Instance of UserModel
            print(result.uid); // return uid value in UserModel class
            var weatherData = await WeatherModel().getLocationWeather();

            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return FirstMenu(
                lat:lat,
                lng:lng,
                locationWeather: weatherData,
                userData: result,
              );
            }));
          }
        },
      ),
    );
  }
}

class UserModel {
  final String uid;

  UserModel({required this.uid});
}

UserModel? _userFromFirebaseUser(User user) {
  return user != null ? UserModel(uid: user.uid) : null;
}
