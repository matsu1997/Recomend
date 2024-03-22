
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:recomend/MedicalQestion.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ProfileEdite.dart';
import 'SignUp.dart';
class V4 extends StatefulWidget {
  @override
  State<V4> createState() => _V4State();
}
enum Menu {Edit, login,request, iphone,android ,message }
class _V4State extends State<V4> {
  @override
  var uid = "";
  var count = 0;
  String date = "";
  List<String> Base = [] ;
  List<String> tags = [] ;
  var name = "";var sex = "";var age = ""; var Ken = "";var Shityo = "";var Rosen = "";var Eki = "";
  var item = [];
  var aka1 = true; var aka2 = true;
  void initState() {
    super.initState();Set();
    sign(); }
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title:Text("問診票",style: TextStyle(fontWeight: FontWeight.bold,color:Colors.black),),
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,elevation: 0,
          actions: [ PopupMenuButton(
            onSelected: popupMenuSelected,
            icon:Icon(Icons.account_circle_outlined,color: Colors.black,),
            itemBuilder: (BuildContext context) =>
            <PopupMenuEntry<Menu>>[
              const PopupMenuItem( child: const ListTile(title:Text("施術者ページ")), value: Menu.Edit,),
              const PopupMenuItem( child: const ListTile(title:Text("アカウントの削除")), value: Menu.login,),
              const PopupMenuItem( child: const ListTile(title:Text("プライバシー・ポリシー")), value: Menu.login,),
              const PopupMenuItem( child: const ListTile(title:Text("利用規約")), value: Menu.login,),
            ],)],),
        floatingActionButton: SpeedDial(backgroundColor: Colors.orange,
          animatedIcon: AnimatedIcons.menu_close,
          animatedIconTheme: IconThemeData(size: 22.0),
          curve: Curves.bounceIn,
          children: [
            SpeedDialChild(
                child: Icon(Icons.create,color: Colors.white,),
                backgroundColor: Colors.yellow,
                label: "問診票(副症状)を作成・編集",
                onTap: () {//Navigator.pushNamed(context, "/create_group");
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => MedicalQuestionElse()));},
                labelStyle: TextStyle(fontWeight: FontWeight.w500)),
            SpeedDialChild(
                child: Icon(Icons.create,color: Colors.white,),
                backgroundColor: Colors.green,
                label: "問診票(主症状)を追加",
                onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => MedicalQuestion()));},
                labelStyle: TextStyle(fontWeight: FontWeight.w500)),
            SpeedDialChild(
                child: Icon(Icons.create,color: Colors.white,),
                backgroundColor: Colors.blue,
                label: "問診票(基礎)を作成・編集",
                onTap: () {//Navigator.pushNamed(context, "/create_group");
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => MedicalQuestionBase()));},
                labelStyle: TextStyle(fontWeight: FontWeight.w500)),
          ],
        ),
    body:  SingleChildScrollView(
      child: Column(children: [
        Container(margin: EdgeInsets.all(10),height:40,width:double.infinity,child:Row(children: [Container(margin: EdgeInsets.all(5),height:40,width:60,child:Text("名前",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),Expanded(child:Container(height:40,color:Colors.grey[100],alignment:Alignment.center,child:Text(name,textAlign:TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)))],)),
        Container(margin: EdgeInsets.all(10),height:40,width:double.infinity,child:Row(children: [Container(margin: EdgeInsets.all(5),height:40,width:60,child:Text("性別",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),Expanded(child:Container(height:40,color:Colors.grey[100],alignment:Alignment.center,child:Text(sex,textAlign:TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)))],)),
        Container(margin: EdgeInsets.all(10),height:40,width:double.infinity,child:Row(children: [Container(margin: EdgeInsets.all(5),height:40,width:60,child:Text("年齢",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),Expanded(child:Container(height:40,color:Colors.grey[100],alignment:Alignment.center,child:Text(age,textAlign:TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)))],)),
        Container(margin: EdgeInsets.all(10),height:40,width:double.infinity,child:Row(children: [Container(margin: EdgeInsets.all(5),height:40,width:60,child:Text("市町村",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),Expanded(child:Container(height:40,color:Colors.grey[100],alignment:Alignment.center,child:Text(Shityo,textAlign:TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)))],)),
        Container(margin: EdgeInsets.all(10),height:40,width:double.infinity,child:Row(children: [Container(margin: EdgeInsets.all(5),height:40,width:60,child:Text("最寄り駅",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),Expanded(child:Container(height:40,color:Colors.grey[100],alignment:Alignment.center,child:Text(Eki,textAlign:TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)))],)),
        Container(width:double.infinity,height: 30 ,margin: EdgeInsets.only(top:10), child: Text("主症状",style: TextStyle(color: Colors.blueGrey[900],fontWeight: FontWeight.bold,fontSize: 20),textAlign: TextAlign.center,),),
        Container(margin:EdgeInsets.all(20),child: Visibility(visible: aka1, child: Container(child: Text("主症状が入力されていません",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 20),textAlign: TextAlign.center,),))),
    ListView.builder(shrinkWrap: true,physics: NeverScrollableScrollPhysics(),
            itemCount: item.length,
            itemBuilder: (context, index) {
              return  GestureDetector(
                  onTap: () {pop();},
                  child:Card(shadowColor: Colors.grey[100],elevation: 4, clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24),),
                      child:Container(margin: EdgeInsets.all(10),alignment: Alignment.center,//color: Colors.grey[100],
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                 child:Column(children: [
                   Container(margin: EdgeInsets.all(5),width:double.infinity,child:Row(children: [Container(margin: EdgeInsets.all(3),child:Text("症状",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)),Expanded(child:Container(color:Colors.grey[100],alignment:Alignment.center,child:Text(item[index]["主症状"],textAlign:TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,height: 2),)))],)),
                   Container(margin: EdgeInsets.all(5),width:double.infinity,child:Row(children: [Container(margin: EdgeInsets.all(3),child:Text("いつから？",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)),Expanded(child:Container(color:Colors.grey[100],alignment:Alignment.center,child:Text(item[index]["いつ"],textAlign:TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,height: 2),)))],)),
                   Container(margin: EdgeInsets.all(5),width:double.infinity,child:Row(children: [Container(margin: EdgeInsets.all(3),child:Text("特に辛い時間帯は？",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)),Expanded(child:Container(color:Colors.grey[100],alignment:Alignment.center,child:Text(item[index]["時間帯"],textAlign:TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,height: 2),)))],)),
                   Container(margin: EdgeInsets.all(5),width:double.infinity,child:Row(children: [Container(margin: EdgeInsets.all(3),child:Text("特に辛い姿勢は？",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)),Expanded(child:Container(color:Colors.grey[100],alignment:Alignment.center,child:Text(item[index]["姿勢"],textAlign:TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,height: 2),)))],)),
                   Container(margin: EdgeInsets.all(5),width:double.infinity,child:Row(children: [Container(margin: EdgeInsets.all(3),child:Text("楽になるのは？",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)),Expanded(child:Container(color:Colors.grey[100],alignment:Alignment.center,child:Text(item[index]["楽"],textAlign:TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,height: 2),)))],)),
                   Container(margin: EdgeInsets.all(5),width:double.infinity,child:Row(children: [Container(margin: EdgeInsets.all(3),child:Text("思い当たる原因は？",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)),Expanded(child:Container(color:Colors.grey[100],alignment:Alignment.center,child:Text(item[index]["原因"],textAlign:TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,height: 2),)))],)),
                   ],)
                    )));},),
        Container(width:double.infinity,height: 30 ,margin: EdgeInsets.only(top:10,bottom: 10), child: Text("副症状",style: TextStyle(color: Colors.blueGrey[900],fontWeight: FontWeight.bold,fontSize: 20),textAlign: TextAlign.center,),),
        Container(margin:EdgeInsets.all(20),child: Visibility(visible: aka2, child: Container(child: Text("副症状が入力されていません",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 20),textAlign: TextAlign.center,),))),
        Wrap(runSpacing: 7, spacing: 7,
          children: tags.map((tag) {
            return InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(32)),
              onTap: () {},
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(32)),
                  border: Border.all(width: 2, color: Colors.blueGrey,),
                  color:  Colors.blueGrey ,
                ),
                child: Text(tag, style: TextStyle(
                  color:  Colors.white , fontWeight: FontWeight.bold,
                ),),),);}).toList(),),
        Container(height: 60,)
      ],),
    ));
  }
  Future<void> sign () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var _counter = prefs.getString("uid")?? "";
    if (_counter == ""){}
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {Future(() {Navigator.push(context, MaterialPageRoute(builder: (context) {
            return SignUp();}));});}
      else {
       uid = user.uid;
        _loadData();
      }});}
  Future<void> Set () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    tags = prefs.getStringList("副症状")?? [];
    if (tags != []){aka2= false;}
    Base = prefs.getStringList("基礎")?? [];
    name = Base[0];sex =  Base[1];age =  Base[2];Ken =  Base[3];Shityo = Base[4];Rosen =  Base[5];Eki = Base[6];
    setState(() {  });}
  void pop(){
    showDialog(context: context, builder: (context) => AlertDialog(
      actions: <Widget>[Column(children: [
        Container(child: TextButton(child:Text("似た悩みを改善した口コミを探す"),onPressed: (){},),),
        Container(child: TextButton(child:Text("この症状を削除する"),onPressed: (){},),),
        Container(child: TextButton(child:Text("この症状を編集する"),onPressed: (){},),)
      ],)],));
  }
  Future<void> _requestReview() async {
    final InAppReview inAppReview = InAppReview.instance;
    if (await inAppReview.isAvailable()) {
      inAppReview.requestReview();
    }
  }
  void popupMenuSelected(Menu selectedMenu){
    switch(selectedMenu) {
      case Menu.Edit:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfileEdite()));
        break;
      case Menu.login:
       // Navigator.of(context).push(MaterialPageRoute(builder: (context) => delete()));
        break;
      case Menu.request: _requestReview();
      break;
      case Menu.iphone:
        break;
      case Menu.android:
        break;
      case Menu.message:
       // Navigator.of(context).push(MaterialPageRoute(builder: (context) => mail("")));
        break;
      default:
        break;
    }}
  Future<void> _loadData()  async {
    item = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uid = prefs.getString("uid")?? "";
    FirebaseFirestore.instance.collection("users").doc(uid).collection("主症状").get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        setState(() {aka1 = false;
          item.add(doc);
          ;});});});}
}
