
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Coment.dart';

class Profile extends StatefulWidget {
  Profile(this.uid,this.Eki);
  String uid;String Eki;
  @override
  State<Profile> createState() => _ProfileState();
}
class _ProfileState extends State<Profile> {
  List<dynamic> item = [];
  var uid = "";
  var ticks = [0, 1, 2, 3,4,5];//[35, 21, 14, 7, 1];//
  var features = ["  頭", " 首肩", "背中", "腕", "足", "全身症状 "];
  var data = [[0,0,0,0,0,0]];
  double _rating = 0;
  var Sum = 0.0;var Bi = 0.0;var Com = 0.0;var Clean = 0.0;var Hun = 0.0;
  @override
  void initState() {
    super.initState();
    _loadData();
  }
  @override
  Widget build(BuildContext context) {
   features = features.sublist(0, 6.floor());
    data = data.map((graph) => graph.sublist(0, 6.floor())).toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(item[0]["userName"].toString(),style: TextStyle(fontWeight: FontWeight.bold,color:Colors.black),),
        iconTheme: IconThemeData(color: Colors.black), elevation: 0, centerTitle: true,
        actions:[ IconButton(icon: Icon(Icons.bookmark_add_rounded,color: Colors.orange,size: 40,),onPressed: (){add();},),],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(height: 600,width: double.infinity,margin: EdgeInsets.only(top: 30,left: 20,right: 20),
                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                     boxShadow: [BoxShadow(color: Colors.grey.shade300, spreadRadius: 5, blurRadius: 5, offset: Offset(1.5, 1.5),),], color: Colors.white,),
              child: Column(children: [
                  Container(margin: EdgeInsets.only(top: 10,bottom: 20),child: Row(children: [
                      Container(margin: EdgeInsets.only(top: 10,left: 10,right: 10),height: 80,width:80, decoration: BoxDecoration(shape: BoxShape.circle,
                        image: DecorationImage(image: NetworkImage(item[0]["ImageId"].toString()), fit: BoxFit.cover,),)),
                      Container(margin: EdgeInsets.only(left:10,top: 10),
                        child:Column(children: [
                          Container(margin: EdgeInsets.all(5),child:Text("総合",style: TextStyle(fontWeight: FontWeight.bold),)),
                          Stack(children: [  Row(children: [RatingBar(allowHalfRating: true,initialRating: Sum.toDouble()
                            , minRating: 1, maxRating: 5, itemCount: 5, itemSize: 30, itemPadding: EdgeInsets.all(2),
                            ratingWidget: RatingWidget(full: Icon(Icons.star, color: Colors.amber), half: Icon(Icons.star_half, color: Colors.amber), empty: Icon(Icons.star_border, color: Colors.grey)), onRatingUpdate: (_rating) {},
                          ),Container(child: Text("("+ Sum.toString()  +")"),)]),
                            Container(width: 200,color: Colors.transparent,height: 30,),],),
                        Container(child: TextButton(child:Text("口コミをみる"),onPressed: (){ Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Coment(uid)));},),)
                        ]),),
                      Expanded(child: Container()),],),),
                Expanded(child: RadarChart.light(ticks: ticks, features: features, data: data, reverseAxis: false, useSides:true,),),
                Container(margin: EdgeInsets.all(10),child: Row(children: [ Container(margin: EdgeInsets.only(right: 10),child:Icon(Icons.person_rounded,color: Colors.orange,size: 40,)),Expanded(child: Text("美容ばり"),),Container(margin: EdgeInsets.only(right: 40),child: Text(Bi.toString()),)],),),
                Container(margin: EdgeInsets.all(10),child: Row(children: [ Container(margin: EdgeInsets.only(right: 10),child:Icon(Icons.person_rounded,color: Colors.orange,size: 40,)),Expanded(child: Text("コミュニケーション"),),Container(margin: EdgeInsets.only(right: 40),child: Text(Com.toString()),)],),),
                Container(margin: EdgeInsets.all(10),child: Row(children: [ Container(margin: EdgeInsets.only(right: 10),child:Icon(Icons.sunny,color: Colors.orange,size: 40,)),Expanded(child: Text("清潔感"),),Container(margin: EdgeInsets.only(right: 40),child: Text(Clean.toString()),)],),),
                Container(margin: EdgeInsets.all(10),child: Row(children: [ Container(margin: EdgeInsets.only(right: 10),child:Icon(Icons.house_sharp,color: Colors.orange,size: 40,)),Expanded(child: Text("お店の雰囲気"),),Container(margin: EdgeInsets.only(right: 40),child: Text(Hun.toString()),)],),)],),),
              Container(margin: EdgeInsets.only(top:10),height: 800 ,child: ProfileV(uid),)
          ],),),);
  }
  void _loadData()  {item = [];
    FirebaseFirestore.instance.collection("施術者").doc(widget.Eki).collection("施術者").where("uid", isEqualTo:widget.uid).get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        setState(() {item.add(doc);//if (item != []){set();}
         print(item);
        uid = doc["uid"].toString();
        data.add([doc["頭"][2], doc["首肩"][2], doc["背中"][2], doc["腕"][2], doc["足"][2], doc["全身症状"][2]]);
        features = ["  頭("+doc["頭"][1].toString()+")", " 首肩("+doc["首肩"][1].toString()+")", "背中("+doc["背中"][1].toString()+")", "腕("+doc["腕"][1].toString()+")", "足("+doc["足"][1].toString()+")", "全身症状 ("+doc["全身症状"][1].toString()+")"];
        Sum = doc["総合"][2].toDouble();
        Bi = doc["美容ばり"][2].toDouble();
        Com = doc["コミュ"][2].toDouble();
        Clean = doc["清潔感"][2].toDouble();
        Hun = doc["雰囲気"][2].toDouble();
        });
        });});}

  // void set (){setState(() {
  //  uid =item[0]["uid"].toString();
  // data.add([item[0]["頭"][2], item[0]["首肩"][2], item[0]["背中"][2], item[0]["腕"][2], item[0]["足"][2], item[0]["全身症状"][2]]);
  // features = ["  頭("+item[0]["頭"][1].toString()+")", " 首肩("+item[0]["首肩"][1].toString()+")", "背中("+item[0]["背中"][1].toString()+")", "腕("+item[0]["腕"][1].toString()+")", "足("+item[0]["足"][1].toString()+")", "全身症状 ("+item[0]["全身症状"][1].toString()+")"];
  // Sum = item[0]["総合"][2].toDouble();
  // Bi = item[0]["美容ばり"][2].toDouble();
  // Com = item[0]["コミュ"][2].toDouble();
  // Clean = item[0]["清潔感"][2].toDouble();
  // Hun = item[0]["雰囲気"][2].toDouble();});}


  Future<void> add() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uid = prefs.getString("uid")?? "";
    FirebaseFirestore.instance.collection('users').doc(uid).collection("気になる").doc(item[0]["uid"]).set({
    "uid":item[0]["uid"].toString(),"userName":item[0]["userName"],"市町村":item[0]["市町村"],"店舗名":item[0]["店舗名"],"ImageId":item[0]["ImageId"],
    "総合":item[0]["総合"],  "コミュ" : item[0]["コミュ"], "清潔感": item[0]["清潔感"],
    "雰囲気":item[0]["雰囲気"],   "createdAt": Timestamp.now(),"コード":item[0]["コード"],"最寄り駅":item[0]["最寄り駅"],
    });
  }

  String randomString(int length) {
    const _randomChars =
        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    const _charsLength = _randomChars.length;
    final rand = new Random();
    final codeUnits = new List.generate(
      length,
          (index) {
        final n = rand.nextInt(_charsLength);
        return _randomChars.codeUnitAt(n);
      },);
    return new String.fromCharCodes(codeUnits);}
}

class ProfileV extends StatefulWidget {
  ProfileV(this.uid);
  String uid;
  @override
  State<ProfileV> createState() => _ProfileVState();
}
class _ProfileVState extends State<ProfileV> {
  @override
  void initState() {
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar:  TabBar(
              tabs: [
                Tab(child: Text("プロフィール",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),),
                Tab(child: Text("店舗情報",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),),
                Tab(child: Text("メニュー",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),),
                   ],),
          body: TabBarView(children: [ProfileV1(widget.uid),ProfileV2(widget.uid),ProfileV3(widget.uid),],
          ),),),);}
}

class ProfileV1 extends StatefulWidget {
  ProfileV1(this.uid);
  String uid;
  @override
  State<ProfileV1> createState() => _ProfileV1State();
}
class _ProfileV1State extends State<ProfileV1> {
  var Jiko = "";
  var Syumi = "";
  var Food = "";
  var Music = "";
  var From = "";
  @override
  void initState() {
    super.initState();_loadData();
  }
  Widget build(BuildContext context) {
    return Scaffold(
        body:  SingleChildScrollView(child:Column(children: [
        Container(margin: EdgeInsets.all(20),child: Row(children: [Container(width: 100,child:Text("自己紹介",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),)),Expanded(child: Container(child:Text(Jiko,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),)))],)),
          Container(margin: EdgeInsets.all(20),child: Row(children: [Container(width: 100,child:Text("取得資格",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),)),Expanded(child: Container(child:Text("",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),)))],)),
          Container(margin: EdgeInsets.all(20),child: Row(children: [Container(width: 100,child:Text("趣味",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),)),Expanded(child: Container(child:Text(Syumi,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),)))],)),
          Container(margin: EdgeInsets.all(20),child: Row(children: [Container(width: 100,child:Text("好きな食べ物",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),)),Expanded(child: Container(child:Text(Food,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),)))],)),
          Container(margin: EdgeInsets.all(20),child: Row(children: [Container(width: 100,child:Text("好きな音楽",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),)),Expanded(child: Container(child:Text(Music,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),)))],)),
          Container(margin: EdgeInsets.all(20),child: Row(children: [Container(width: 100,child:Text("出身地",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),)),Expanded(child: Container(child:Text(From,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),)))],)),
           ],)));}
  Future<void> _loadData()  async {
    SharedPreferences prefs = await SharedPreferences.getInstance();var uid = prefs.getString("uidA")?? "";print(uid);
    FirebaseFirestore.instance.collection("施術者").doc(uid).collection("情報").where("情報",isEqualTo: "プロフィール").get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        setState(() {
      Jiko = doc["自己紹介"];Syumi = doc["趣味"];Food = doc["好きな食べ物"];Music= doc["好きな音楽"];From= doc["出身地"];
        ;});});});}
}
class ProfileV2 extends StatefulWidget {
  ProfileV2(this.uid);
  String uid;
  @override
  State<ProfileV2> createState() => _ProfileV2State();
}
class _ProfileV2State extends State<ProfileV2> {
  var home = "";var name = "";var adress = "";
  var near = "";var time = "";var rest = "";
  var tel = "";var park = "";var bed = "";var credit = "";
  var item = [];
  @override
  void initState() {
    super.initState();
    _loadData();
  }
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(child:Column(children: [
          Container(margin: EdgeInsets.all(15),child: Row(children: [Container(width: 100,child:Text("ホームページ",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),)),Expanded(child: Container(child:Text(home,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),)))],)),
          Container(margin: EdgeInsets.all(15),child: Row(children: [Container(width: 100,child:Text("店舗名",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),)),Expanded(child: Container(child:Text(name,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),)))],)),
          Container(margin: EdgeInsets.all(15),child: Row(children: [Container(width: 100,child:Text("住所",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),)),Expanded(child: Container(child:Text(adress,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),)))],)),
          Container(margin: EdgeInsets.all(15),child: Row(children: [Container(width: 100,child:Text("最寄り駅",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),)),Expanded(child: Container(child:Text(near,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),)))],)),
          Container(margin: EdgeInsets.all(15),child: Row(children: [Container(width: 100,child:Text("営業時間",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),)),Expanded(child: Container(child:Text(time,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),)))],)),
          Container(margin: EdgeInsets.all(15),child: Row(children: [Container(width: 100,child:Text("定休日",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),)),Expanded(child: Container(child:Text(rest,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),)))],)),
          Container(margin: EdgeInsets.all(15),child: Row(children: [Container(width: 100,child:Text("TEL",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),)),Expanded(child: Container(child:Text(tel.toString(),style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),)))],)),
          Container(margin: EdgeInsets.all(15),child: Row(children: [Container(width: 100,child:Text("駐車場の有無",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),)),Expanded(child: Container(child:Text(park,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),)))],)),
          Container(margin: EdgeInsets.all(15),child: Row(children: [Container(width: 100,child:Text("ベッド数",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),)),Expanded(child: Container(child:Text(bed.toString(),style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),)))],)),
          Container(margin: EdgeInsets.all(15),child: Row(children: [Container(width: 100,child:Text("クレジット/　アプリ決算",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),)),Expanded(child: Container(child:Text(credit,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),)))],)),
          Expanded(child:
          GridView.count(
              padding: EdgeInsets.all(10.0), crossAxisCount: 2, crossAxisSpacing: 5.0,mainAxisSpacing: 10.0,childAspectRatio: 1.0,
              shrinkWrap: true,physics: NeverScrollableScrollPhysics(),
              children: List.generate(item[0].length, (index) {
                return GestureDetector(onTap: () {},    
                  child: Container(alignment: Alignment.bottomCenter,height: 300,width: 150, decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(image: NetworkImage(item[0][index][0]), fit: BoxFit.fill,),),
                      child: Container(alignment: Alignment.bottomCenter,height: 30,width: 150,color: Colors.black.withOpacity(0.5),
                          child:Container(margin: EdgeInsets.only(bottom: 5),child:FittedBox(fit: BoxFit.fitWidth,
                              child: Text(item[0][index][1],style: TextStyle(fontWeight: FontWeight.bold,color:Colors.white,fontSize: 15)))))),
                );}))),
        ],)));}
  Future<void> _loadData()  async {
   // item = [["","店舗外観"],["","施術所"]];
    SharedPreferences prefs = await SharedPreferences.getInstance();var uid = prefs.getString("uidA")?? "";
    FirebaseFirestore.instance.collection("施術者").doc(uid).collection("情報").where("情報",isEqualTo: "店舗").get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        setState(() {item = [];
          item.add([[doc["imageId1"].toString(),"店舗外観"],[doc["imageId2"].toString(),"施術所"]]);print(item);
        home = doc["ホームページ"];name= doc["店舗名"];adress=doc["住所"];near=doc["最寄り駅"];time=doc["営業時間"];rest=doc["定休日"];
        tel=doc["TEL"];park=doc["駐車場"];bed=doc["ベッド"];credit=doc["クレジット"];
              ;});});});}
}

class ProfileV3 extends StatefulWidget {
  ProfileV3(this.uid);
  String uid;
  @override
  State<ProfileV3> createState() => _ProfileV3State();
}
class _ProfileV3State extends State<ProfileV3> {
  var item = []; var home = "";var TEL = "";var Line="";var site ="";
  @override
  void initState() {
    super.initState();
    _loadData();
  }
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
          Container(height:20,margin: EdgeInsets.all(10),child: Row(children: [Container(width: 100,child:Text("電話予約",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),)),Expanded(child: Container(child:Text(home,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),)))],)),
          Container(height:20,margin: EdgeInsets.all(10),child: Row(children: [Container(width: 100,child:Text("LINE予約",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),)),Expanded(child: Container(child:Text(TEL,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),)))],)),
          Container(height:20,margin: EdgeInsets.all(10),child: Row(children: [Container(width: 100,child:Text("サイト予約",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),)),Expanded(child: Container(child:Text(Line,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),)))],)),
          Container(height:20,margin: EdgeInsets.all(10),child: Row(children: [Container(width: 100,child:Text("その他",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),)),Expanded(child: Container(child:Text(site,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),)))],)),
        Expanded(
          child: ListView.builder(
            itemCount: item.length,
            itemBuilder: (context, index) {
              return Card(
                shadowColor: Colors.grey[100],
                elevation: 8,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    children: [Container(
                      margin: EdgeInsets.only(top:10,left: 10,right: 5),
                      alignment: Alignment.center,
                      child: Text(item[index]["text"],style: TextStyle(fontSize:20,fontWeight: FontWeight.bold,color:Colors.black)),),
                      Container(child:
                      Row(children: [Container(height: 100,width: 100, margin: EdgeInsets.only(top: 10,left: 10,right: 10),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(image: AssetImage("images/asami.JPG"), fit: BoxFit.cover,),)),
                           Expanded(child: Text(item[index]["subText"],style: TextStyle(fontWeight: FontWeight.bold,color:Colors.grey),),)],),),
                      Container(child:Text(item[index]["値段"].toString()+"円",style: TextStyle(fontSize:15,fontWeight: FontWeight.bold,color:Colors.grey))),
                    ],
                  ),),);},),),
        ],));}
  Future<void> _loadData()  async {
    SharedPreferences prefs = await SharedPreferences.getInstance();var uid = prefs.getString("uidA")?? "";
    item = [];
    FirebaseFirestore.instance.collection('施術者').doc(uid).collection("メニュー").get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        setState(() {if (doc["Co"]== "方法"){home =doc["ホームページ"];TEL=doc["TEL"];Line=doc["Line"];site=doc["サイト"];}else{item.add(doc);}
        ;});});});}
}

