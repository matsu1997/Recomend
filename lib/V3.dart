
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Profile.dart';

class V3 extends StatefulWidget {
  @override
  State<V3> createState() => _V3State();
}
class _V3State extends State<V3> {
  var uid = "";

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text("お気に入り", style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black),),
            iconTheme: IconThemeData(color: Colors.black),
            centerTitle: true,
            actions: [],
            bottom: const TabBar(
              tabs: [
                Tab(child: Text("気になる", style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black),),),
                Tab(child: Text("来店済み", style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black),),),
              ],),),
          body: TabBarView(children: [V3V1(), V3V2()],
          ),),),);
  }
}

class V3V1 extends StatefulWidget {
  @override
  State<V3V1> createState() => _V3V1State();
}
class _V3V1State extends State<V3V1> {
  var item = [];
  var index1 = 0;
  @override
  void initState() {
    super.initState();
    _loadData();
  }
Widget build(BuildContext context) {
  return Scaffold(
  body: Container(
  child: Column(children: <Widget>[
  Expanded(child:Container(margin: EdgeInsets.all(15),
  child: ListView.builder(
  itemCount: item.length,
  itemBuilder: (context, index) {
  return  GestureDetector(
  onTap: () async { SharedPreferences prefs = await SharedPreferences.getInstance();prefs.setString("uidA", item[index]["uid"]);
  Navigator.of(context).push(
  MaterialPageRoute(builder: (context) => Profile(item[index]["uid"],item[index]["最寄り駅"],)),);},
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

Future<void> _loadData()  async {
  item = [];
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var uid = prefs.getString("uid")?? "";
  FirebaseFirestore.instance.collection('users').doc(uid).collection("気になる").get().then((QuerySnapshot snapshot) {
    snapshot.docs.forEach((doc) {
      setState(() {
        item.add(doc);
        ;});});});}
}



class V3V2 extends StatefulWidget {
  @override
  State<V3V2> createState() => _V3V2State();
}
class _V3V2State extends State<V3V2> {
  var item = [];
  var index1 = 0;
  @override
  void initState() {
    super.initState();
    _loadData();
  }
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Column(children: <Widget>[
              Expanded(child:Container(margin: EdgeInsets.all(15),
                child: ListView.builder(
                  itemCount: item.length,
                  itemBuilder: (context, index) {
                    return  GestureDetector(
                        onTap: () {index1 = index;pop();
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Profile(item[index]["uid"],item[index]["最寄り駅"],)),);},
                        child:Card(shadowColor: Colors.grey[100],elevation: 2, clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24),),
                          child: Column(children: [
                             Row(children: [
                               Container(alignment: Alignment.bottomCenter,height: 200,width: 150, decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                 image: DecorationImage(image: NetworkImage(item[index]["ImageId"]), fit: BoxFit.fill,),),
                                   child: Container(alignment: Alignment.bottomCenter,height: 30,width: 150,color: Colors.black.withOpacity(0.5),
                                       child:Container(margin: EdgeInsets.only(bottom: 5),child:FittedBox(fit: BoxFit.fitWidth,
                                           child: Text(item[index]["userName"],style: TextStyle(fontWeight: FontWeight.bold,color:Colors.white,fontSize: 15)))))),
                               Expanded(child:Container(height: 200, child:
                              Column(children: [
                                Container(margin: EdgeInsets.all(5),child:Text("総合",style: TextStyle(fontWeight: FontWeight.bold),)),
                                Container(margin: EdgeInsets.all(5),child: Icon(Icons.star,color: Colors.orange,),),
                                Container(width: double.infinity,margin: EdgeInsets.all(5),child: Row(children: [ Container(margin: EdgeInsets.only(right: 5),child:Icon(Icons.person_rounded,color: Colors.orange,size: 20,)),Expanded(child: Text("コミュニケーション"),),Container(margin: EdgeInsets.only(right: 10),child: Text("4.9"),)],),),
                                Container(margin: EdgeInsets.all(5),child: Row(children: [ Container(margin: EdgeInsets.only(right: 5),child:Icon(Icons.sunny,color: Colors.orange,size: 20,)),Expanded(child: Text("清潔感"),),Container(margin: EdgeInsets.only(right: 10),child: Text("4.9"),)],),),
                                Container(margin: EdgeInsets.all(5),child: Row(children: [ Container(margin: EdgeInsets.only(right: 5),child:Icon(Icons.house_sharp,color: Colors.orange,size: 20,)),Expanded(child: Text("お店の雰囲気"),),Container(margin: EdgeInsets.only(right: 10),child: Text("4.9"),)],),),
                                Container(margin: EdgeInsets.all(5),child: Row(children: [ Container(child: Text("秦野市",style: TextStyle(fontWeight: FontWeight.bold,color:Colors.grey,fontSize: 10)),),Text(" / ",style: TextStyle(color:Colors.grey)),Container(child: Text("ビファイン鍼灸治療院",style: TextStyle(fontWeight: FontWeight.bold,color:Colors.grey,fontSize: 10)),)],),),
                                Expanded(child: Text("詳しくみる",style: TextStyle(fontWeight: FontWeight.bold,color:Colors.blue),),),
                                ],),
                              )),],),
                            Container(margin: EdgeInsets.only(left:10,right: 10),child:Divider(color: Colors.grey)),
                            Container(margin: EdgeInsets.only(top:10,left: 10,right: 5), alignment: Alignment.center,
                              child: Text("あなたのレビュー",style: TextStyle(fontSize:15,fontWeight: FontWeight.bold,color:Colors.grey)),),
                          ]),));},),)),
              Container(child: Container())
            ])));}
Future<void> _loadData()  async {
  item = [];
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var uid = prefs.getString("uid")?? "";
  FirebaseFirestore.instance.collection('users').doc(uid).collection("来店済").get().then((QuerySnapshot snapshot) {
    snapshot.docs.forEach((doc) {
      setState(() {
        item.add(doc);
        ;});});});}
  void pop(){
    showDialog(context: context, builder: (context) => AlertDialog(
      actions: <Widget>[Column(children: [
        Container(child: TextButton(child:Text("プロフィールをみる"),onPressed: (){},),),
        Container(child: TextButton(child:Text("予約申請変更"),onPressed: (){},),),
        Container(child: TextButton(child:Text("予約申請取り消し"),onPressed: (){},),),
        Container(child: TextButton(child:Text("メッセージを送る"),onPressed: (){},),)
      ],)],));
  }
}