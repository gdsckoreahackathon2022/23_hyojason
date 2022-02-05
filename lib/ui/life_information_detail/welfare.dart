import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class WelfareScreen extends StatefulWidget {
  @override
  _WelfareScreenState createState() => _WelfareScreenState();
}

class _WelfareScreenState extends State<WelfareScreen> {
  static Color mainColor = const Color(0xff6524FF);
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
  _launchURL(url) async {
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
      appBar:PreferredSize(
        preferredSize: const Size.fromHeight(90.0),
        child: AppBar(

          flexibleSpace: Container(),
          title: const Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Text(
              '복지',
              style: TextStyle(fontFamily: 'Noto', fontSize: 30),
            ),
          ),
          elevation: 0.0,
          backgroundColor: mainColor,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Welfare')
                      .orderBy('timestamp', descending: false)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    return SizedBox(
                      height: 130,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (ctx, index) => Container(
                          padding: const EdgeInsets.all(3),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _launchURL( snapshot.data!.docs[index]['url']);

                                  },
                                child: Card(
                                  elevation: 5,
                                  child: SizedBox(
                                    height: 100,
                                    width: MediaQuery.of(context).size.width,
                                    child: Center(
                                      child: Text(
                                        snapshot.data!.docs[index]['title'],
                                        style: const TextStyle(fontSize: 35),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

