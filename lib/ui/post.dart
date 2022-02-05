import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Post extends StatefulWidget {
  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  FirebaseFirestore fireStore = FirebaseFirestore.instance;


  String postTitle = "";
  String content = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('포스팅')),
      body: Container(
        child: Column(
          children: [
            TextField(
                controller: titleController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '제목',
                ),
                onChanged: (value) {
                  setState(() {
                    postTitle = value;
                  });
                }),
            TextField(
              controller: contentController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '내용',
              ),
              onChanged: (value) {
                setState(() {
                  content = value;
                });
              },
            ),
            ElevatedButton(
                onPressed: (){
                  fireStore.collection('Posts').doc().set({
                    "postTitle":postTitle,
                    "content": content,
                  });

            }, child: Text('upload'))
          ],
        ),
      ),
    );
  }
}
