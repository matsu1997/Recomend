import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Profile.dart';
import 'main.dart';


class ComentAdd extends StatefulWidget {
  @override
  State<ComentAdd> createState() => _ComentAddState();
}
class _ComentAddState extends State<ComentAdd> {
  var index1 = 0;
  var coment = "";
  @override
  void initState() {
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("金森明咲美",style: TextStyle(fontWeight: FontWeight.bold,color:Colors.black),),
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0, centerTitle: true,
          ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'コメント'),
                onChanged: (String value) {
                  setState(() {coment = value;});},
              ),
              Container(width: double.infinity,
                child: ElevatedButton(child: Text('登録'), onPressed: () async {add();}
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> add() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      await FirebaseFirestore.instance.collection('users').doc(user?.uid)// コレクションID指定
          .set({
        "uid":user?.uid,
        "createdAt": Timestamp.now(),
      });
    });}
}



