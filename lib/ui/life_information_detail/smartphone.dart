import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hyojason/ui/life_information_detail/getdetail.dart';

class SmartphoneScreen extends StatefulWidget {
  @override
  _SmartphoneScreenState createState() => _SmartphoneScreenState();
}

class _SmartphoneScreenState extends State<SmartphoneScreen> {
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
              '스마트폰 사용하기',
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
                      .collection('Smartphone')
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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Smartphone1Screen(
                                      title:snapshot.data!.docs[index]['title'],
                                      description:snapshot.data!.docs[index]['description']??'',
                                      imageUrl:snapshot.data!.docs[index]['imageUrl']??'',
                                      url: snapshot.data!.docs[index]['url'],
                                    )),
                                  );
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

