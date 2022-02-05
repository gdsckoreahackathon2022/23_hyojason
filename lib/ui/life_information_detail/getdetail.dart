import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class Smartphone1Screen extends StatefulWidget {
  Smartphone1Screen({this.title, this.description, this.imageUrl, this.url});

  final title, description, imageUrl,url;

  @override
  _Smartphone1ScreenState createState() => _Smartphone1ScreenState(
      title: this.title,
      description: this.description,
      imageUrl: this.imageUrl,
      url:this.url
  );
}

class _Smartphone1ScreenState extends State<Smartphone1Screen> {
  _Smartphone1ScreenState({this.title, this.description, this.imageUrl,this.url});

  final title, description, imageUrl,url;
  static Color mainColor = Color(0xff6524FF);
  double buttonsHeight = 50;
  int number = 2;

  @override
  void initState() {
    super.initState();
  }

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Future<void> _refresh() async {
    setState(() {});
  }

  _launchURL() async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(

          flexibleSpace: Container(),
          title: const Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Text(
              ' ',
              style: TextStyle(fontFamily: 'Noto', fontSize: 30),
            ),
          ),
          elevation: 0.0,
          backgroundColor: mainColor,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Card(
                  elevation: 5.0,
                  child: Container(
                      height: 80,
                      alignment: Alignment.center,
                      child: Text(
                        '$title',
                        style: const TextStyle(fontSize: 40),
                      )),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Text(
                    '$description',
                    style: const TextStyle(fontSize: 30),
                  ),
                ),
                Image.network(imageUrl,
                    errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.white,
                    alignment: Alignment.center,
                  );
                }),
                TextButton(
                  onPressed: _launchURL,
                  child: Text(
                    url,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
