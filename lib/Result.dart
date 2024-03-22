
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Profile.dart';


class Result extends StatefulWidget {
  Result(this.name);
  String name;
  @override
State<Result> createState() => _ResultState();
}
enum Menu {Edit, login,request, iphone,android ,message }
class _ResultState extends State<Result> {
  var item = [];
  double _rating = 0;
  @override
  void initState() {
    super.initState();
   _loadData();
  }


  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("検索結果", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
          centerTitle: true,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          actions: [  PopupMenuButton(
            onSelected: popupMenuSelected,
            icon:Icon(Icons.format_line_spacing_rounded,color: Colors.black,),
            itemBuilder: (BuildContext context) =>
            <PopupMenuEntry<Menu>>[
              const PopupMenuItem( child: const ListTile(title:Text("総合評価順")), value: Menu.Edit,),
              const PopupMenuItem( child: const ListTile(title:Text("頭の治療の評価順")), value: Menu.login,),
              const PopupMenuItem( child: const ListTile(title:Text("首肩の治療の評価順")), value: Menu.request),
              const PopupMenuItem( child: const ListTile(title:Text("腕の治療の評価順")), value: Menu.message,),
              const PopupMenuItem( child: const ListTile(title:Text("背中の治療の評価順")), value: Menu.message,),
              const PopupMenuItem( child: const ListTile(title:Text("足の治療の評価順")), value: Menu.message,),
              const PopupMenuItem( child: const ListTile(title:Text("全身の治療の評価順")), value: Menu.message,),
              const PopupMenuItem( child: const ListTile(title:Text("美容ばりの評価順")), value: Menu.message,),
            ],
          )],
        ),
        body: Container(
            child: Column(children: <Widget>[
              Expanded(child:Container(margin: EdgeInsets.all(15),
                child: ListView.builder(
                  itemCount: item.length,
                  itemBuilder: (context, index) {
                       return  GestureDetector(
                        onTap: () async { SharedPreferences prefs = await SharedPreferences.getInstance();prefs.setString("uidA", item[index]["uid"]);
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => Profile(item[index]["uid"],item[index]["最寄り駅"],)),);},
                    child:Card(shadowColor: Colors.grey[100],elevation: 2, clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24),),
                      child: Container(
                        child: Row(children: [
                          Container(alignment: Alignment.bottomCenter,height: 200,width: 150, decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(image: NetworkImage(item[index]["ImageId"]), fit: BoxFit.fill,),),
                              child: Container(alignment: Alignment.bottomCenter,height: 30,width: 150,color: Colors.black.withOpacity(0.5),
                                  child:Container(margin: EdgeInsets.only(bottom: 5),child:FittedBox(fit: BoxFit.fitWidth,
                                      child: Text(item[index]["userName"],style: TextStyle(fontWeight: FontWeight.bold,color:Colors.white,fontSize: 15)))))),
                          Expanded(child:Container(height: 200, child:
                          Column(children: [
                            Container(margin: EdgeInsets.all(5),child:Text("総合",style: TextStyle(fontWeight: FontWeight.bold),)),
                          Stack(children: [  Row(children: [RatingBar(allowHalfRating: true,initialRating: item[index]["総合"][2].toDouble()
                              , minRating: 1, maxRating: 5, itemCount: 5, itemSize: 30, itemPadding: EdgeInsets.all(2),
                              ratingWidget: RatingWidget(full: Icon(Icons.star, color: Colors.amber), half: Icon(Icons.star_half, color: Colors.amber), empty: Icon(Icons.star_border, color: Colors.grey)), onRatingUpdate: (_rating) {},
                            ),Container(child: Text("("+ item[index]["総合"][2].toString()  +")"),)]),
                            Container(color: Colors.transparent,width: double.infinity,height: 30,),],),
                            Container(width: double.infinity,margin: EdgeInsets.all(5),child: Row(children: [ Container(margin: EdgeInsets.only(right: 5),child:Icon(Icons.person_rounded,color: Colors.orange,size: 20,)),Expanded(child: Text("コミュニケーション"),),Container(margin: EdgeInsets.only(right: 10),child: Text(item[index]["コミュ"][2].toString()),)],),),
                            Container(margin: EdgeInsets.all(5),child: Row(children: [ Container(margin: EdgeInsets.only(right: 5),child:Icon(Icons.sunny,color: Colors.orange,size: 20,)),Expanded(child: Text("清潔感"),),Container(margin: EdgeInsets.only(right: 10),child: Text(item[index]["清潔感"][2].toString()),)],),),
                           Container(margin: EdgeInsets.all(5),child: Row(children: [ Container(margin: EdgeInsets.only(right: 5),child:Icon(Icons.house_sharp,color: Colors.orange,size: 20,)),Expanded(child: Text("お店の雰囲気"),),Container(margin: EdgeInsets.only(right: 10),child: Text(item[index]["雰囲気"][2].toString()),)],),),
                           Container(margin: EdgeInsets.all(5),child: Row(children: [ Container(child: Text(item[index]["市町村"],style: TextStyle(fontWeight: FontWeight.bold,color:Colors.grey,fontSize: 10)),),Text(" / ",style: TextStyle(color:Colors.grey)),Container(child: Text(item[index]["店舗名"],style: TextStyle(fontWeight: FontWeight.bold,color:Colors.grey,fontSize: 10)),)],),),
                           Expanded(child: Text("詳しくみる",style: TextStyle(fontWeight: FontWeight.bold,color:Colors.blue),),),
                          ],),)),
                  ],),),));},),)),
              Container(child: Container())
               ])));}
  void _loadData()  {
    item = [];
    FirebaseFirestore.instance.collection("施術者").doc("日高").collection("施術者").get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        setState(() {
          item.add(doc);
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
