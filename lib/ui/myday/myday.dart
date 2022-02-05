import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/widgets.dart';
import 'package:hyojason/ui/myday/post.dart';
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';

class MydayScreen extends StatefulWidget {
  MydayScreen({this.userData});

  final userData;

  @override
  _MydayScreenState createState() => _MydayScreenState();
}

class _MydayScreenState extends State<MydayScreen> {
  FirebaseStorage storage = FirebaseStorage.instance;
  static Color mainColor = const Color(0xff6524FF);

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  late String UID;
  late Map likes;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateuid(widget.userData);
  }
  void updateuid(dynamic userData){
    setState(() {

      if (userData == null){
        UID='error';
      }else{
        UID=userData.uid;
      }
    });
  }

  String _chars = 'AaBbCcDdEeFfGgHh';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  // Select and image from the gallery or take a picture with the camera
  // Then upload to Firebase Storage
  Future<void> _upload(String inputSource) async {
    final picker = ImagePicker();
    XFile? pickedImage;
    try {
      pickedImage = await picker.pickImage(
          source: inputSource == 'camera'
              ? ImageSource.camera
              : ImageSource.gallery,
          maxWidth: 1920);

      final String fileName = path.basename(pickedImage!.path);
      File imageFile = File(pickedImage.path);
      String postKey = getRandomString(8);

      try {
        firebase_storage.Reference storageReference =
            firebase_storage.FirebaseStorage.instance.ref('myday/$fileName');
        // Uploading the selected image with some custom meta data
        await storageReference.putFile(
          imageFile,
        );
        String? returnURL;
        await storageReference.getDownloadURL().then((fileURL) {
          returnURL = fileURL;
        });
        fireStore
            .collection('Posts')
            .doc(postKey)
            .set({'key': postKey, 'PicUrl': returnURL,'likes':{UID:false},'currentuser':UID,'timestamp':Timestamp.now()});

        // Refresh the UI
        setState(() {});
      } on FirebaseException catch (error) {
        if (kDebugMode) {
          print(error);
        }
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }

  Future<void> _refresh() async {
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90.0),
        child: AppBar(

          flexibleSpace: Container(),
          title: const Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Text(
              '나의 하루',
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
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      _upload('camera');
                    },
                    icon: const Icon(Icons.camera),
                    label: const Text('카메라로 찍기'),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(mainColor)),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      _upload('gallery');
                    },
                    icon: const Icon(Icons.library_add),
                    label: const Text('사진첩에서 고르기'),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(mainColor)),
                  ),
                ],
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Posts').orderBy('timestamp',descending:true)
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
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              SpecialOfferCard(
                                image: snapshot.data!.docs[index]['PicUrl'],
                                likes: snapshot.data!.docs[index]['likes'],
                                currentuser: snapshot.data!.docs[index]['currentuser'] ,
                                timestamp: snapshot.data!.docs[index]['timestamp'],
                                postKey: snapshot.data!.docs[index]['key'],

                                press: () {},
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
