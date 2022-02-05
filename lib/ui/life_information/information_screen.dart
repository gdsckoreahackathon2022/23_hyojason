import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hyojason/ui/map/pages.dart';
import 'package:hyojason/ui/life_information_detail/wise_screen.dart';
import '../hospital/hospital.dart';

class InformationScreen extends StatefulWidget {
  InformationScreen({this.lat,this.lng});
  final lat, lng;

  @override
  _InformationScreemState createState() => _InformationScreemState(
    lat:lat,
    lng:lng,

  );
}

class _InformationScreemState extends State<InformationScreen> {
  _InformationScreemState({this.lat,this.lng});
  final lat, lng;

  static Color mainColor = const Color(0xff6524FF);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75.0),
        child: AppBar(

          flexibleSpace: Container(),
          title: const Padding(
            padding: EdgeInsets.only(top: 15.0),
            child: Text(
              '생활정보',
              style: TextStyle(fontFamily: 'Noto', fontSize: 30),
            ),
          ),
          elevation: 0.0,
          backgroundColor: mainColor,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(40),
        children: <Widget>[

          Column(

            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HospitalScreen(
                      lat:lat,
                      lng:lng
                    )),
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
                          '병원',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 38,
                              fontFamily: 'NanumBold'),
                        ),
                        trailing: Image.asset(
                          'images/병원.png',
                          width: 70,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PlacesPage(
                        lat:lat,
                        lng:lng,
                      place: '은행',
                    )),
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
                          '은행',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 38,
                              fontFamily: 'NanumBold'),
                        ),
                        trailing: Image.asset(
                          'images/은행.png',
                          width: 70,
                        ),
                      ),
                    ),
                  ),
                ),

              ),
              const SizedBox(
                height: 35,
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PlacesPage(
                  lat:lat,
                  lng:lng,
                  place: '동사무소',
                )),
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
                      '동사무소',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 38,
                          fontFamily: 'NanumBold'),
                    ),
                    trailing: Image.asset(
                      'images/동사무소.png',
                      width: 70,
                    ),
                  ),
                ),
              ),
            ),

          ),
          const SizedBox(
            height: 35,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WiseScreen()),
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
                      '생활의 지혜',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 38,
                          fontFamily: 'NanumBold'),
                    ),
                    trailing: Image.asset(
                      'images/idea.png',
                      width: 70,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 35,
          ),
        ],
      ),
    );
  }
}
