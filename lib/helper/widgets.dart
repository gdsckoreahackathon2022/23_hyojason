import 'package:flutter/material.dart';
import 'package:hyojason/ui/news/article_view.dart';

class NewsTile extends StatelessWidget {
  final String imgUrl, title, desc, posturl;

  const NewsTile(
      {required this.imgUrl,
      required this.desc,
      required this.title,
      required this.posturl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleView(
                      imgUrl: imgUrl,
                      title: title,
                      desc: desc,
                      posturl: posturl,
                    )));
      },
      child: Container(
        margin: const EdgeInsets.all(2),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.network(
                        imgUrl,
                        height: 100,
                        width: 135,
                        fit: BoxFit.cover,
                        errorBuilder: (context,error,stackTrace) {
                          return Container(
                            color: Colors.white,
                            height: 100,
                            width: 135,
                            alignment: Alignment.center,
                            child:const Text('잔다르크',style: TextStyle(fontSize: 20),),
                          );
                        }
                      ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  SizedBox(
                    width: 250,
                    child: Text(
                      title,
                      style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 25,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
                width: 500,
                child: Divider(color: Colors.grey, thickness: 0.5))
          ],
        ),
      ),
    );
  }
}
