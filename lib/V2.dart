
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'SignUp.dart';


class V2 extends StatefulWidget {
  @override
  State<V2> createState() => _V2State();
}
enum Menu {Edit, login,request, iphone,android ,message }
class _V2State extends State<V2> {
var uid = "";
  @override
  void initState() {
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title:Text("予約",style: TextStyle(fontWeight: FontWeight.bold,color:Colors.black),),
            iconTheme: IconThemeData(color: Colors.black),
            centerTitle: true,
            actions: [],
            bottom: const TabBar(
              tabs: [
                Tab(child: Text("予約申請中",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),),
                Tab(child: Text("予約確定",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),),
                Tab(child: Text("来店履歴",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),),
              ],),),
          body: TabBarView(children: [V2V1(),V2V2(),V2V3(),],
          ),),),);}
}


class V2V1 extends StatefulWidget {
  @override
  State<V2V1> createState() => _V2V1State();
}
class _V2V1State extends State<V2V1> {
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
                        children: [
                          Container(child: Row(children: [
                            Container(height: 60,width: 60, margin: EdgeInsets.only(top: 10,left: 10,right: 10),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(image: NetworkImage(item[index]["ImageId"]), fit: BoxFit.cover,),)),
                             Column(children: [
                               Container(child:Text("金森明咲美",style: TextStyle(fontSize:20,fontWeight: FontWeight.bold,color:Colors.black))),
                               Container(margin: EdgeInsets.all(5),child: Row(children: [ Container(child: Text("秦野市",style: TextStyle(fontWeight: FontWeight.bold,color:Colors.grey,fontSize: 10)),),Text(" / ",style: TextStyle(color:Colors.grey)),Container(child: Text("ビファイン鍼灸治療院",style: TextStyle(fontWeight: FontWeight.bold,color:Colors.grey,fontSize: 10)),)],),),
                             ],),
                            Expanded(child: IconButton(icon:Icon(Icons.circle_notifications_outlined,color: Colors.orange,size: 35,),onPressed: (){index1 = index;pop();},))
                          ],),),
                          Container(margin: EdgeInsets.only(top:10,left: 10,right: 5), alignment: Alignment.center,
                            child: Text("はり・灸+ショートマッサージ 全60分",style: TextStyle(fontSize:15,fontWeight: FontWeight.bold,color:Colors.grey)),),
                          Container(margin: EdgeInsets.only(top:10,left: 10,right: 5), alignment: Alignment.center,
                            child: Text("2022年07月23日10時30分",style: TextStyle(fontSize:15,fontWeight: FontWeight.bold,color:Colors.grey)),),
                        ],
                      ),),);},),),
            Container(child: Container())
          ])));}
Future<void> _loadData()  async {
  item = [];
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var uid = prefs.getString("uid")?? "";
  FirebaseFirestore.instance.collection('users').doc(uid).collection("予約申請中").get().then((QuerySnapshot snapshot) {
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

class V2V2 extends StatefulWidget {
  @override
  State<V2V2> createState() => _V2V2State();
}
class _V2V2State extends State<V2V2> {
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
                          children: [
                            Container(child: Row(children: [
                              Container(height: 60,width: 60, margin: EdgeInsets.only(top: 10,left: 10,right: 10),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(image: NetworkImage(item[index]["ImageId"]), fit: BoxFit.cover,),)),
                              Column(children: [
                                Container(child:Text("金森明咲美",style: TextStyle(fontSize:20,fontWeight: FontWeight.bold,color:Colors.black))),
                                Container(margin: EdgeInsets.all(5),child: Row(children: [ Container(child: Text("秦野市",style: TextStyle(fontWeight: FontWeight.bold,color:Colors.grey,fontSize: 10)),),Text(" / ",style: TextStyle(color:Colors.grey)),Container(child: Text("ビファイン鍼灸治療院",style: TextStyle(fontWeight: FontWeight.bold,color:Colors.grey,fontSize: 10)),)],),),
                              ],),
                              Expanded(child: IconButton(icon:Icon(Icons.circle_notifications_outlined,color: Colors.orange,size: 35,),onPressed: (){index1 = index;pop();},))
                            ],),),
                            Container(margin: EdgeInsets.only(top:10,left: 10,right: 5), alignment: Alignment.center,
                              child: Text("はり・灸+ショートマッサージ 全60分",style: TextStyle(fontSize:15,fontWeight: FontWeight.bold,color:Colors.grey)),),
                            Container(margin: EdgeInsets.only(top:10,left: 10,right: 5), alignment: Alignment.center,
                              child: Text("2022年07月23日10時30分",style: TextStyle(fontSize:15,fontWeight: FontWeight.bold,color:Colors.grey)),),
                            new Divider(color: Colors.black),
                            Container(margin: EdgeInsets.only(top:10,left: 10,right: 5), alignment: Alignment.center,
                              child: Text("ご来店お待ちしております",style: TextStyle(fontSize:15,fontWeight: FontWeight.bold,color:Colors.grey)),),
                          ],
                        ),),);},),),
              Container(child: Container())
            ])));}
Future<void> _loadData()  async {
  item = []; SharedPreferences prefs = await SharedPreferences.getInstance();
  var uid = prefs.getString("uid")?? "";
  FirebaseFirestore.instance.collection('users').doc(uid).collection("予約確定").get().then((QuerySnapshot snapshot) {
    snapshot.docs.forEach((doc) {
      setState(() {
        item.add(doc);
        ;});});});}

  void pop(){
    showDialog(context: context, builder: (context) => AlertDialog(
      actions: <Widget>[Column(children: [
        Container(child: TextButton(child:Text("プロフィールをみる"),onPressed: (){},),),
        Container(child: TextButton(child:Text("予約取り消し"),onPressed: (){},),),
        Container(child: TextButton(child:Text("メッセージを送る"),onPressed: (){},),)
      ],)],));
  }
}

class V2V3 extends StatefulWidget {
  @override
  State<V2V3> createState() => _V2V3State();
}
class _V2V3State extends State<V2V3> {
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
                          children: [
                            Container(child: Row(children: [
                              Container(height: 60,width: 60, margin: EdgeInsets.only(top: 10,left: 10,right: 10),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(image: NetworkImage(item[index]["ImageId"]), fit: BoxFit.cover,),)),
                              Column(children: [
                                Container(child:Text("金森明咲美",style: TextStyle(fontSize:20,fontWeight: FontWeight.bold,color:Colors.black))),
                                Container(margin: EdgeInsets.all(5),child: Row(children: [ Container(child: Text("秦野市",style: TextStyle(fontWeight: FontWeight.bold,color:Colors.grey,fontSize: 10)),),Text(" / ",style: TextStyle(color:Colors.grey)),Container(child: Text("ビファイン鍼灸治療院",style: TextStyle(fontWeight: FontWeight.bold,color:Colors.grey,fontSize: 10)),)],),),
                              ],),
                              Expanded(child: IconButton(icon:Icon(Icons.circle_notifications_outlined,color: Colors.orange,size: 35,),onPressed: (){index1 = index;pop();},))
                            ],),),
                            Container(margin: EdgeInsets.only(top:10,left: 10,right: 5), alignment: Alignment.center,
                              child: Text("はり・灸+ショートマッサージ 全60分",style: TextStyle(fontSize:15,fontWeight: FontWeight.bold,color:Colors.grey)),),
                            Container(margin: EdgeInsets.only(top:10,left: 10,right: 5), alignment: Alignment.center,
                              child: Text("2022年07月23日10時30分",style: TextStyle(fontSize:15,fontWeight: FontWeight.bold,color:Colors.grey)),),
                            new Divider(color: Colors.black),
                            Container(margin: EdgeInsets.only(top:10,left: 10,right: 5), alignment: Alignment.center,
                              child: Text("ご来店お待ちしております",style: TextStyle(fontSize:15,fontWeight: FontWeight.bold,color:Colors.grey)),),
                          ],
                        ),),);},),),
              Container(child: Container())
            ])));}
  Future<void> _loadData()  async {
    item = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uid = prefs.getString("uid")?? "";
    FirebaseFirestore.instance.collection('users').doc(uid).collection("来店履歴").get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        setState(() {
          item.add(doc);
          ;});});});}

  void pop(){
    showDialog(context: context, builder: (context) => AlertDialog(
      actions: <Widget>[Column(children: [
        Container(child: TextButton(child:Text("プロフィールをみる"),onPressed: (){},),),
        Container(child: TextButton(child:Text("予約取り消し"),onPressed: (){},),),
        Container(child: TextButton(child:Text("メッセージを送る"),onPressed: (){},),)
      ],)],));
  }
}