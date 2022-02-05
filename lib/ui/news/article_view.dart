import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleView extends StatefulWidget {
  final String imgUrl, title, desc, posturl;

  ArticleView(
      {required this.imgUrl,
      required this.desc,
      required this.title,
      required this.posturl});

  @override
  _ArticleViewState createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {

  _launchURL() async {
    if (await canLaunch(widget.posturl)) {
      await launch(widget.posturl);
    } else {
      throw 'Could not launch';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Stack(
            children: [
              Container(height: MediaQuery.of(context).size.height+200,
              color: Colors.transparent,),
            Container(
              child: Image.network(
                widget.imgUrl,
                height: 380,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
              ListTile(
                leading: IconButton(
                  iconSize: 30,
                  icon: const Icon(Icons.arrow_back,color: Colors.white,),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Positioned(
                right: 0,
                top:280,
                child: Container(
                  color: Colors.white,
                  height: 750,
                  width: 370,
                ),
              ),
              Positioned(
                right: 5,
                top: 300,
                child: Container(
                  width: 350,
                  padding: const EdgeInsets.only(left: 7, right: 7),
                  child: Text(
                    widget.title,
                    style: const TextStyle(fontSize: 35, fontFamily: 'NanumBold'),
                  ),
                ),
              ),
              Positioned(
                right: 5,
                top: 470,

                child: Container(
                  width: 350,
                  height: 380,
                  padding: const EdgeInsets.only(left: 7, right: 7),
                  child: Text(
                    widget.desc,
                    style: const TextStyle(
                      fontFamily: 'Noto',
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 5,
                bottom: 100,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(left: 7, right: 7),
                  child: const Text(
                    '자세히보기:',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 5,
                bottom: 40,
                child: TextButton(

                  onPressed: _launchURL,
                  child: Text(

                    widget.posturl,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
