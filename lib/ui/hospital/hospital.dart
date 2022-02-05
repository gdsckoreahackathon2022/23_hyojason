import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hyojason/ui/map/pages.dart';

class HospitalScreen extends StatefulWidget {
  HospitalScreen({this.lat,this.lng});
  final lat,lng;
  @override
  _HospitalScreenState createState() => _HospitalScreenState(
    lat:lat,
    lng:lng
  );
}

class _HospitalScreenState extends State<HospitalScreen> {
  _HospitalScreenState({this.lat,this.lng});

  static Color mainColor = const Color(0xff6524FF);
  double buttonsHeight = 50;

  final lat,lng;
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(75.0),
        child: AppBar(

          flexibleSpace: Container(),
          title: const Padding(
            padding: EdgeInsets.only(top: 15.0),
            child: Text(
              '병원',
              style: TextStyle(fontFamily: 'Noto', fontSize: 30),
            ),
          ),
          elevation: 0.0,
          backgroundColor: mainColor,
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 180,
            width: double.infinity,
            color: mainColor,
            padding: const EdgeInsets.only(top:60,left: 20,right: 20,bottom: 20),
            child: const Text(
              '어디가 \n불편하신가요?',
              style: TextStyle(color: Colors.white,fontFamily: 'NanumGothic',fontSize: 40),
              textAlign: TextAlign.left,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PlacesPage(
                  lat:lat,
                  lng:lng,
                  place: '내과',
                )),
              );
            },
            style: ElevatedButton.styleFrom(
              side: const BorderSide(width: 0.5,),
              primary: Colors.white,
              elevation: 4.0,
            ),
            child: SizedBox(
              height: 130,
              width: double.infinity,
              child: Row(
                children: const [
                  SizedBox(
                    width: 10,
                  ),
                  Center(
                    child: Text(
                      '기침, 가래, 코',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 28,
                          fontFamily: 'NanumBold'),
                    ),

                  ),

                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PlacesPage(
                  lat:lat,
                  lng:lng,
                  place: '신경외과',
                )),
              );
            },
            style: ElevatedButton.styleFrom(
              side: const BorderSide(width: 0.5,),
              primary: Colors.white,
              elevation: 4.0,
            ),
            child: SizedBox(
              height: 130,
              width: double.infinity,
              child: Row(
                children: const [
                  SizedBox(
                    width: 10,
                  ),
                  Center(
                    child: Text(
                      '허리, 목, 다리, 팔 저림',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 30,
                          fontFamily: 'NanumBold'),
                    ),

                  ),

                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PlacesPage(
                  lat:lat,
                  lng:lng,
                  place: '신경과',
                )),
              );
            },
            style: ElevatedButton.styleFrom(
              side: const BorderSide(width: 0.5,),
              primary: Colors.white,
              elevation: 4.0,
            ),
            child: SizedBox(
              height: 130,
              width: double.infinity,
              child: Row(
                children: const [
                  SizedBox(
                    width: 10,
                  ),
                  Center(
                    child: Text(
                      '머리, 기억력 문제',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 30,
                          fontFamily: 'NanumBold'),
                    ),

                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PlacesPage(
                  lat:lat,
                  lng:lng,
                  place: '정형외과',
                )),
              );
            },
            style: ElevatedButton.styleFrom(
              side: const BorderSide(width: 0.5,),
              primary: Colors.white,
              elevation: 4.0,
            ),
            child: SizedBox(
              height: 130,
              width: double.infinity,
              child: Row(
                children: const [
                  SizedBox(
                    width: 10,
                  ),
                  Center(
                    child: Text(
                      '근육, 뼈, 관절',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 30,
                          fontFamily: 'NanumBold'),
                    ),

                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PlacesPage(
                  lat:lat,
                  lng:lng,
                  place: '피부과',
                )),
              );
            },
            style: ElevatedButton.styleFrom(
              side: const BorderSide(width: 0.5,),
              primary: Colors.white,
              elevation: 4.0,
            ),
            child: SizedBox(
              height: 130,
              width: double.infinity,
              child: Row(
                children: const [
                  SizedBox(
                    width: 10,
                  ),
                  Center(
                    child: Text(
                      '피부, 손발톱',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 30,
                          fontFamily: 'NanumBold'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PlacesPage(
                  lat:lat,
                  lng:lng,
                  place: '한의원',
                )),
              );
            },
            style: ElevatedButton.styleFrom(
              side: const BorderSide(width: 0.5,),
              primary: Colors.white,
              elevation: 4.0,
            ),
            child: SizedBox(
              height: 130,
              width: double.infinity,
              child: Row(
                children: const [
                  SizedBox(
                    width: 10,
                  ),
                  Center(
                    child: Text(
                      '한의원 정보',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 30,
                          fontFamily: 'NanumBold'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}