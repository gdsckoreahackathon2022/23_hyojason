import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hyojason/ui/life_information_detail/corona.dart';
import 'package:hyojason/ui/life_information_detail/enviroment.dart';
import 'package:hyojason/ui/life_information_detail/smartphone.dart';
import 'package:hyojason/ui/life_information_detail/welfare.dart';


class WiseScreen extends StatefulWidget {
  @override
  _WiseScreenState createState() => _WiseScreenState();
}

class _WiseScreenState extends State<WiseScreen> {
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
        preferredSize: const Size.fromHeight(90.0),
        child: AppBar(

          flexibleSpace: Container(),
          title: const Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Text(
              '생활의 지혜',
              style: TextStyle(fontFamily: 'Noto', fontSize: 30),
            ),
          ),
          elevation: 0.0,
          backgroundColor: mainColor,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: <Widget>[
          Column(

            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CoronaScreen()),
                  );
                },
                child: Card(
                  elevation: 5,
                  child: SizedBox(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    child: const Center(
                      child: ListTile(
                        leading: Text(
                          '코로나19 정보',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 35,
                              fontFamily: 'NanumBold'),
                        ),
                        trailing: Icon(Icons.coronavirus,color:Colors.black,size:45)
                      ),
                    ),
                  ),
                ),

              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EnviromentScreen()),
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
                      '환경',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 35,
                          fontFamily: 'NanumBold'),
                    ),
                    trailing: Image.asset(
                      'images/enviroment.png',
                      width: 70,
                    ),
                  ),
                ),
              ),
            ),

          ),
          const SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WelfareScreen()),
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
                      '복지',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 35,
                          fontFamily: 'NanumBold'),
                    ),
                    trailing: Image.asset(
                      'images/welfare.png',
                      width: 70,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SmartphoneScreen()),
              );
            },
            child: Card(
              elevation: 5,
              child: SizedBox(
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: const Center(
                  child: ListTile(
                      leading: Text(
                        '스마트폰 사용하기',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 35,
                            fontFamily: 'NanumBold'),
                      ),
                      trailing: Icon(Icons.smartphone,color: Colors.black,size:45)
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}