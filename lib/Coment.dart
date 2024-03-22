import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'Profile.dart';



class Coment extends StatefulWidget {
  Coment(this.uid);
  String uid;
  @override
  State<Coment> createState() => _ComentState();
}
enum Menu {Edit, login,request, iphone,android ,message }
class _ComentState extends State<Coment> {
  var item = [];
  var index1 = 0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("金森明咲美さんの口コミ",style: TextStyle(fontWeight: FontWeight.bold,color:Colors.black),),
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0, centerTitle: true,
          actions: [  PopupMenuButton(
            onSelected: popupMenuSelected,
            icon:Icon(Icons.format_line_spacing_rounded,color: Colors.black,),
            itemBuilder: (BuildContext context) =>
            <PopupMenuEntry<Menu>>[
              const PopupMenuItem( child: const ListTile(title:Text("新着順")), value: Menu.Edit,),
              const PopupMenuItem( child: const ListTile(title:Text("頭の治療の評価")), value: Menu.login,),
              const PopupMenuItem( child: const ListTile(title:Text("首肩の治療の評価")), value: Menu.request),
              const PopupMenuItem( child: const ListTile(title:Text("腕の治療の評価")), value: Menu.message,),
              const PopupMenuItem( child: const ListTile(title:Text("背中の治療の評価")), value: Menu.message,),
              const PopupMenuItem( child: const ListTile(title:Text("足の治療の評価")), value: Menu.message,),
              const PopupMenuItem( child: const ListTile(title:Text("全身の治療の評価")), value: Menu.message,),
              const PopupMenuItem( child: const ListTile(title:Text("美容ばりの評価")), value: Menu.message,),
            ],
          )],
        ),
        body: Container(
            child: Column(children: <Widget>[
              Expanded(child: Container(margin: EdgeInsets.all(10),
                child: ListView.builder(
                  itemCount: 10,//item.length,
                  itemBuilder: (context, index) {
                    return  Card(
                          shadowColor: Colors.grey[100],
                          elevation: 2,
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
                          child: Column(children: [
                            Row(children: [Container(margin: EdgeInsets.all(10),child:Icon(Icons.person)),Container(child: Text("40代")),Container(child: Text("女性"),),Expanded(child: Text("2022年10月7日",textAlign: TextAlign.right,)),Container(margin: EdgeInsets.all(10),child: Text(""),),],),
                            Container(margin: EdgeInsets.all(10),child: Text("肩こり、慢性の腰痛"),),
                            Row(children: [Container(margin: EdgeInsets.all(5),child: Text("施術満足度"),),
                              Stack(children: [  Row(children: [RatingBar(allowHalfRating: true,initialRating: 4.5, minRating: 1, maxRating: 5, itemCount: 5, itemSize: 30, itemPadding: EdgeInsets.all(2), ratingWidget: RatingWidget(full: Icon(Icons.star, color: Colors.amber), half: Icon(Icons.star_half, color: Colors.amber), empty: Icon(Icons.star_border, color: Colors.grey)), onRatingUpdate: (_rating) {},),Container(child: Text("("+ "4.5"  +")"),)]), Container(width: 200,color: Colors.transparent,height: 30,),],),],),
                            Row(children: [Container(margin: EdgeInsets.all(5),child: Text("コミュニケーション"),),Container(margin: EdgeInsets.only(left:5),child: Text("4.0")),Container(margin: EdgeInsets.all(5),child: Text("清潔感"),),Container(margin: EdgeInsets.only(left:5),child: Text("4.0")),Container(margin: EdgeInsets.all(5),child: Text("お店の雰囲気"),),Container(margin: EdgeInsets.only(left:5),child: Text("4.0")),],),
                            Container(margin: EdgeInsets.only(left:10,right: 10),child:Divider(color: Colors.grey)),
                            Container(width: double.infinity,child: Text("コメント"),),
                            Container(margin: EdgeInsets.all(20),child: Text("jksjkshakhfkagjasnddjkahbbcbcnmbvhsdggjdjhgdajshlgafeeygfhfbncbdhdhddsh"),)
                          ]),);
                  },),)),
              Container(child: Container())
            ])));
  }
void _loadData()  {
  item = [];
  FirebaseFirestore.instance.collection('施術者').doc(widget.uid).collection("レビュー").get().then((QuerySnapshot snapshot) {
    snapshot.docs.forEach((doc) {
      setState(() {item.add(doc);
        ;});});});}
  void popupMenuSelected(Menu selectedMenu){
    switch(selectedMenu) {
      case Menu.Edit:

        break;
      case Menu.login:

        break;
      case Menu.request:
        break;
      case Menu.iphone:
        break;
      case Menu.android:
        break;
      case Menu.message:

        break;
      default:
        break;
    }}
}