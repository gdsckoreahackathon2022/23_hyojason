import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SpecialOfferCard extends StatefulWidget {
  const SpecialOfferCard({
    required this.image,
    required this.likes,
    required this.press,
    required this.postKey,
    required this.currentuser,
    required this.timestamp,
  });

  final Timestamp timestamp;
  final String currentuser;
  final String postKey;
  final String image;
  final Map likes;
  final GestureTapCallback press;

  int getLikeCount(likes) {
    // if no likes, return 0
    if (likes == null) {
      return 0;
    }
    int count = 0;
    // if the key is explicitly set to true, add a like
    likes.values.forEach((val) {
      if (val == true) {
        count += 1;
      }
    });
    return count;
  }

  @override
  _SpecialOfferCardState createState() => _SpecialOfferCardState(
      image: this.image,
      likes: this.likes,
      press: this.press,
      postKey: this.postKey,
      currentuser: this.currentuser,
      timestamp: this.timestamp,
      likeCount: getLikeCount(this.likes));
}

class _SpecialOfferCardState extends State<SpecialOfferCard> {
  _SpecialOfferCardState(
      {required this.image,
      required this.likes,
      required this.press,
      required this.postKey,
      required this.currentuser,
      required this.timestamp,
      required this.likeCount});

  final Timestamp timestamp;
  final String currentuser;
  final String postKey;
  final String image;
  final GestureTapCallback press;
  int likeCount;
  Map likes;
  double size = 40;
  bool isLiked = false;



  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (isLiked) {
    } else {
      fireStore.collection('Posts').doc(postKey).update({
        'likes': {currentuser: false}
      });
    }
  }

  handleLikePost() {
    bool _isLiked = likes[currentuser] == true;

    if (_isLiked) {
      fireStore.collection('Posts').doc(postKey).update({
        'likes': {currentuser: false}
      });
      setState(() {
        likeCount -= 1;
        isLiked = false;
        likes[currentuser] = false;
      });
    } else if (!_isLiked) {
      fireStore.collection('Posts').doc(postKey).update({
        'likes': {currentuser: true}
      });
      setState(() {
        likeCount += 1;
        isLiked = true;
        likes[currentuser] = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0.5),
      child: GestureDetector(
        onTap: press,
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 300,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Stack(
                  children: [
                    Image.network(
                      image,
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                      fit: BoxFit.fill,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            const Color(0xFF343434).withOpacity(0.4),
                            const Color(0xFF343434).withOpacity(0.15),
                          ],
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: likes[currentuser]
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : const Icon(Icons.favorite_border, color: Colors.grey),
                  onPressed: () {
                    handleLikePost();
                  },
                ),
                Text('$likeCount')
              ],
            ),
          ],
        ),
      ),
    );
  }
}
