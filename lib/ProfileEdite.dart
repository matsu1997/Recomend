import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io' as io;
import 'SignUp.dart';


class ProfileEdite extends StatefulWidget {
  @override
  State<ProfileEdite> createState() => _ProfileEditeState();
}
class _ProfileEditeState extends State<ProfileEdite> {
  var password = "";
  var uid = "";
  var aka = true;
  @override
  void initState() {
    super.initState();sign();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title:Text("施術者ページ",style: TextStyle(fontWeight: FontWeight.bold,color:Colors.black),),
            iconTheme: IconThemeData(color: Colors.black),
            centerTitle: true,  elevation: 0,
            actions: [],
            bottom: const TabBar(
              tabs: [
                Tab(child: Text("プロフィール",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),),
                Tab(child: Text("店舗",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),),
                Tab(child: Text("メニュー",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),),
              ],
            ),),
          body: TabBarView(children: [ProfileEditeA(uid),ProfileEditeB(uid),ProfileEditeC(uid)],
          ),),),);}
  void sign (){
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {Future(() {Navigator.push(context, MaterialPageRoute(builder: (context) {
        return SignUp();}));});}
      else {uid = user.uid;}});}
}

class ProfileEditeA extends StatefulWidget {
  ProfileEditeA(this.uid);
  String uid;
  @override
  State<ProfileEditeA > createState() => _ProfileEditeAState();
}
class _ProfileEditeAState extends State<ProfileEditeA > {
  void initState() {
    super.initState();_loadData();
  }
  var jico = "";
  var syumi = "";
  var food = "";
  var music = "";
  var from = "";
  var Id = "";
  var jicoA = "";
  var syumiA = "";
  var foodA = "";
  var musicA = "";
  var fromA = "";
  var IdA = "";
  var index1 = 0;
  File? get nil => null;
  String imgPathUse="";
  File? _image;
  var jicoCon = TextEditingController();
  var syumiCon = TextEditingController();
  var foodCon = TextEditingController();
  var musicCon = TextEditingController();
  var fromCon = TextEditingController();
  final imagePicker = ImagePicker();



  Future<void> addFilePath() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uid = prefs.getString("uid")?? "";
    FirebaseFirestore.instance.collection('施術者').doc(uid).collection("情報").doc("プロフィール").set({
      "自己紹介": jico,
      "趣味":syumi,
      "好きな食べ物":food,
      "好きな音楽":music,
      "出身地":from,
      "情報":"プロフィール",
      "Id":Id,
    }, SetOptions(merge: true));
    jicoCon.clear();syumiCon.clear();foodCon.clear();musicCon.clear();fromCon.clear();
    _image = nil;
    imgPathUse = "";
    Navigator.of(context, rootNavigator: true).pop();
    setState(() {});
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(  backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Container(
                child: Column(children: <Widget>[
                  Container(margin: EdgeInsets.all(10),child:TextFormField(decoration: InputDecoration(labelText: '自己紹介'),
                    onChanged: (String value) {setState(() {jico = value;print(jico);});},),),
                  Container(margin: EdgeInsets.all(10),child:TextFormField(controller: TextEditingController(text: syumiA),decoration: InputDecoration(labelText: '趣味'),
                    onChanged: (String value1) {setState(() {syumi = value1;});},),),
                  Container(margin: EdgeInsets.all(10),child:TextFormField(controller: TextEditingController(text: foodA),decoration: InputDecoration(labelText: '好きな食べ物'),
                    onChanged: (String value2) {setState(() {food = value2;});},),),
                  Container(margin: EdgeInsets.all(10),child:TextFormField(controller: TextEditingController(text: musicA),decoration: InputDecoration(labelText: '好きな音楽'),
                    onChanged: (String value3) {setState(() {music = value3;});},),),
                  Container(margin: EdgeInsets.all(10),child:TextFormField(controller: TextEditingController(text: fromA),decoration: InputDecoration(labelText: '出身地'),
                    onChanged: (String value4) {setState(() {from = value4;});},),),
                  Container(
                    margin: EdgeInsets.only(top:20,bottom: 20),
                    child: ElevatedButton(
                      child: Text('追加',style: TextStyle(fontWeight: FontWeight.bold),),
                      onPressed: ()  {
                        Id = randomString(20);
                        addFilePath();
                         },),),]))));}
  Future<void> _loadData()  async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uid = prefs.getString("uid")?? "";
    FirebaseFirestore.instance.collection('施術者').doc(uid).collection("情報").where("情報",isEqualTo: "プロフィール").get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        setState(() {jico =doc["自己紹介"];syumiA=doc["趣味"];foodA=doc["好きな食べ物"];musicA=doc["好きな音楽"];fromA=doc["出身地"];print(jicoA);});
        ;});});}
}


class ProfileEditeB extends StatefulWidget {
  ProfileEditeB(this.uid);
  String uid;
  @override
  State<ProfileEditeB > createState() => _ProfileEditeBState();
}
class _ProfileEditeBState extends State<ProfileEditeB > {
  void initState() {
    super.initState();
  }
  var index = 0;
  var home = "";
  var name = "";
  var adress = "";
  var near = "";
  var time = "";
  var rest = "";
  var tel = "";
  var park = "";
  var bed = "";
  var credit = "";
  var Id = ""; var Id2 = "";
  var list = [];
  File? get nil => null;
  String imgPathUse="";String imgPathUse1 ="";
  File? _image; File? _image1;
  var homeCon = TextEditingController();
  var nameCon = TextEditingController();
  var adressCon = TextEditingController();
  var nearCon = TextEditingController();
  var parkCon = TextEditingController();
  var creditCon = TextEditingController();
  final imagePicker = ImagePicker();


  Future getImageFromCamera() async {
    final pickedFile = await imagePicker.getImage(source: ImageSource.camera);
    setState(() {if (pickedFile != null) {_image = File(pickedFile.path);}});}
  PickedFile? pickedFile;
  Future getImageFromGarally() async {
    pickedFile = await imagePicker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {_image = File(pickedFile!.path);}});
  }
  Future getImageFromCamera1() async {
    final pickedFile1 = await imagePicker.getImage(source: ImageSource.camera);
    setState(() {if (pickedFile1 != null) {_image1 = File(pickedFile1.path);}});}
  PickedFile? pickedFile1;
  Future getImageFromGarally1() async {
    pickedFile1 = await imagePicker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile1 != null) {_image1 = File(pickedFile1!.path);}});
  }
  Future<void> uploadFile(String sourcePath, String uploadFileName, String uploadFileName2) async {
    showProgressDialog();
    final FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child("images"); //保存するフォルダ
    io.File file = io.File(sourcePath);
    UploadTask task = ref.child(uploadFileName).putFile(file);
    UploadTask task2 = ref.child(uploadFileName2).putFile(file);
    try {
      var snapshot = await task;
      var snapshot2 = await task2;
    } catch (FirebaseException) {}
    getImgs(Id,Id2);
  }

  Future<void> addFilePath(String userId, String localPath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uid = prefs.getString("uid")?? "";
    FirebaseFirestore.instance.collection('施術者').doc(uid).collection("情報").doc("店舗").set({"情報":"店舗",
      "ホームページ":home,"店舗名":name,"住所":adress,"最寄り駅":near,"営業時間":time, "定休日":rest,"TEL":tel,"駐車場":park,"ベッド":bed,"クレジット":credit,'imageId1': imgPathUse,'imageId2': imgPathUse1, "Id":Id,
    }, SetOptions(merge: true));
    homeCon.clear();adressCon.clear();nameCon.clear();nearCon.clear();
    _image = nil;
    imgPathUse = "";imgPathUse1 = "";
    Navigator.of(context, rootNavigator: true).pop();
    setState(() {});
  }
  void getImgs(String imgPathRemote,String imgPathRemote1) async{
    if ((imgPathRemote != "") && (imgPathRemote != null)) {
      try {
        imgPathUse = await FirebaseStorage.instance.ref().
        child("images").child(imgPathRemote).getDownloadURL();
        imgPathUse1 = await FirebaseStorage.instance.ref().
        child("images").child(imgPathRemote1).getDownloadURL();
        addFilePath(Id, pickedFile!.path);
      }
      catch (FirebaseException) {}} else{}}
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(  backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Container(
                child: Column(children: <Widget>[
                Container( margin: EdgeInsets.all(10),decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(10),),
                  child:Column(children: [
                    Container(height: 200,
                    child: Container(
                        alignment: Alignment.center,
                        child: _image == null ?
                        Text('店舗外観写真選択\n１枚のみです',textAlign: TextAlign.center,)
                            : Image.file(_image!)),),
                    Container(
                        margin: EdgeInsets.only(top:20,bottom: 20),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                          FloatingActionButton(
                              onPressed: getImageFromCamera, child: Icon(Icons.photo_camera)),
                          FloatingActionButton(
                              onPressed: getImageFromGarally, child: Icon(Icons.photo_album))
                        ])),],)),
                  Container( margin: EdgeInsets.all(10),decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(10),),
                      child:Column(children: [
                        Container(height: 200,
                          child: Container(
                              alignment: Alignment.center,
                              child: _image1 == null ?
                              Text('施術室写真選択\n１枚のみです',textAlign: TextAlign.center,)
                                  : Image.file(_image1!)),),
                        Container(
                            margin: EdgeInsets.only(top:20,bottom: 20),
                            child:
                            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                              FloatingActionButton(
                                  onPressed: getImageFromCamera1, child: Icon(Icons.photo_camera)),
                              FloatingActionButton(
                                  onPressed: getImageFromGarally1, child: Icon(Icons.photo_album))
                            ])),],)),
                  Container(margin: EdgeInsets.all(10),child:TextFormField(decoration: InputDecoration(labelText: 'ホームページ'),
                    onChanged: (String value) {setState(() {home = value;});},),),
                  Container(margin: EdgeInsets.all(10),child:TextFormField(decoration: InputDecoration(labelText: '店舗名'),
                    onChanged: (String value1) {setState(() {name = value1;});},),),
                  Container(margin: EdgeInsets.all(10),child:TextFormField(decoration: InputDecoration(labelText: '住所'),
                    onChanged: (String value2) {setState(() {adress = value2;});},),),
                  Container(margin: EdgeInsets.all(10),child:TextFormField(decoration: InputDecoration(labelText: '最寄駅'),
                    onChanged: (String value3) {setState(() {near = value3;});},),),
                  Container(margin: EdgeInsets.all(10),child:TextFormField(decoration: InputDecoration(labelText: '営業時間'),
                    onChanged: (String value4) {setState(() {time = value4;});},),),
                  Container(margin: EdgeInsets.all(10),child:TextFormField(decoration: InputDecoration(labelText: '定休日'),
                    onChanged: (String value5) {setState(() {rest = value5;});},),),
                  Container(margin: EdgeInsets.all(10),child:TextFormField(keyboardType: TextInputType.number,decoration: InputDecoration(labelText: "TEL"),
                    onChanged: (String value6) {setState(() {tel = value6;});},),),
                  Container(margin: EdgeInsets.all(10),child:TextFormField(onTap: () {list =["あり","なし"];index = 1;
                  FocusScope.of(context).requestFocus(new FocusNode());showPicker();},controller: parkCon,decoration: InputDecoration(labelText: '駐車場の有無'),
                    onChanged: (String value7) {setState(() {park = value7;});},),),
                  Container(margin: EdgeInsets.all(10),child:TextFormField(keyboardType: TextInputType.number,decoration: InputDecoration(labelText: 'ベッド数'),
                    onChanged: (String value8) {setState(() {bed = value8;});},),),
                  Container(margin: EdgeInsets.all(10),child:TextFormField(onTap: () {list =["あり","なし"];index = 2;
                  FocusScope.of(context).requestFocus(new FocusNode());showPicker();},controller: creditCon,decoration: InputDecoration(labelText: 'クレジット/アプリ決算'),
                    onChanged: (String value9) {setState(() {credit = value9;});},),),
                  Container(
                    margin: EdgeInsets.only(top:20,bottom: 20),
                    child: ElevatedButton(
                      child: Text('追加',style: TextStyle(fontWeight: FontWeight.bold),),
                      onPressed: ()  {
                        Id = randomString(20);Id2 = randomString(20);
                        uploadFile(pickedFile!.path,Id,Id2);
                        // setState(() { FocusScope.of(context).unfocus(); });
                      },
                    ),),

                ]))));
  }
  void showProgressDialog() {
    showGeneralDialog(
        context: context,
        barrierDismissible: false,
        transitionDuration: Duration(milliseconds: 300),
        barrierColor: Colors.black.withOpacity(0.5),
        pageBuilder: (BuildContext context, Animation animation, Animation secondaryAnimation) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });}
void showPicker() {
    final _pickerItems = list.map((item) => Text(item)).toList();
    var selectedIndex = 0;
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 216,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: CupertinoPicker(backgroundColor: Colors.white,
              itemExtent: 32,
              children: _pickerItems,
              onSelectedItemChanged: (int index) {
                selectedIndex = index;
              },),),);},).then((_) {
      if (selectedIndex != null) {
        switch (index) {
          case 1:park = list[selectedIndex];parkCon.value = TextEditingValue(text: list[selectedIndex]);;break;
          case 2:credit = list[selectedIndex];creditCon.value = TextEditingValue(text: list[selectedIndex]);  break;
        }
      }});}
}


class ProfileEditeC extends StatefulWidget {
  ProfileEditeC(this.uid);
  String uid;
  @override
  State<ProfileEditeC > createState() => _ProfileEditeCState();
}
class _ProfileEditeCState extends State<ProfileEditeC > {
  var item = []; var item1 = [];
  var Id = "";
  var home = "";var TEL = "";var Line="";var site ="";
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
        body: Container(
            child: Column(children: <Widget>[
            Container(margin:EdgeInsets.all(5),width:double.infinity,child:Row( children: [Icon(Icons.smartphone), Text('予約方法',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),    Container(child:TextButton(child: Text("編集",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),onPressed: (){pop();},))],)),
              Container( margin:EdgeInsets.all(5),decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                boxShadow: [BoxShadow(color: Colors.grey.shade300, spreadRadius: 5, blurRadius: 5, offset: Offset(1.5, 1.5),),], color: Colors.white,), width: double.infinity,child:
                 Container(margin:EdgeInsets.all(10),child:Column(children: [
                Row(children: [Container(margin:EdgeInsets.all(5),child: Text("ホームページURL"),),Container(margin:EdgeInsets.all(5),child: Text(home),)],),
                Row(children: [Container(margin:EdgeInsets.all(5),child: Text("電話番号"),),Container(margin:EdgeInsets.all(5),child: Text(TEL),)],),
                Row(children: [Container(margin:EdgeInsets.all(5),child: Text("LineURL"),),Container(margin:EdgeInsets.all(5),child: Text(Line),)],),
                    Row(children: [Container(child: Text(" 予約サイト"),),Container(margin:EdgeInsets.all(5),child: Text(site),)],),
              ],))),
              Container(margin:EdgeInsets.all(5),width:double.infinity,child:Row(children: [Icon(Icons.bookmark_add_outlined), Text('メニュー',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),), Container(child:TextButton(child: Text("追加",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditeMenuAdd(widget.uid)),).then((value) {_loadData();});},))],)),
              Expanded(
                child: ListView.builder(
                  itemCount: item.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          showDialog(context: context, builder: (context) =>
                              AlertDialog(
                                title: Text("このメニューを削除しますか？",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,),),
                                actions: <Widget>[
                                  Column(children: [
                                    Container(
                                      margin: EdgeInsets.all(10),width: double.infinity,
                                      child: ElevatedButton(
                                        child: Text('削除',style: TextStyle(fontWeight: FontWeight.bold),),
                                        onPressed: () {Id = item[index]["Id"];delete();},),)],)
                                ],));
                        },child:Card(
                      shadowColor: Colors.grey[100],
                      elevation: 8,
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.white, Colors.white],
                              //[Colors.redAccent, Colors.red],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          padding: EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Container(
                                  height: 100,
                                  width: 100,
                                  margin:
                                  EdgeInsets.only(top: 10, left: 10, right: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: AssetImage("images/asami.JPG"),
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                              Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: 10, right: 10),
                                        child: Text(
                                          item[index]["text"],
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: 10, left: 10, right: 10),
                                        child: Text(
                                          item[index]["subText"],
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: 10, left: 10, right: 10),
                                        child: Text(item[index]["値段"].toString() + "円",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                      ),
                                    ],
                                  )),],)),));},),),
              Container()
            ])));}
  Future<void> _loadData()  async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uid = prefs.getString("uid")?? "";
    item = [];
    FirebaseFirestore.instance.collection('施術者').doc(uid).collection("メニュー").get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        setState(() {if (doc["Co"]== "方法"){home =doc["ホームページ"];TEL=doc["TEL"];Line=doc["Line"];site=doc["サイト"];}else{item.add(doc);}
          ;});});});}
  void delete (){
    setState(() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var uid = prefs.getString("uid")?? "";
      FirebaseFirestore.instance.collection('施術者').doc(uid).collection("メニュー").doc(Id).delete();
      _loadData();});Navigator.of(context).pop();}

  void pop(){
    showDialog(context: context, builder: (context) {
     return AlertDialog(insetPadding: EdgeInsets.all(8),
      actions: <Widget>[Container(width: MediaQuery.of(context).size.width,child:Column(children: [
         Container(color: Colors.grey[100],width:double.infinity,height: 50,margin: EdgeInsets.all(10),child:TextFormField(decoration: InputDecoration(labelText: 'ホームページURL'),
          onChanged: (String value) {setState(() {home = value;});},),),
        Container(color: Colors.grey[100],width:double.infinity,height: 50,margin: EdgeInsets.all(10),child:TextFormField(keyboardType: TextInputType.number,decoration: InputDecoration(labelText: '電話番号'),
          onChanged: (String value) {setState(() {TEL = value;});},),),
        Container(color: Colors.grey[100],width:double.infinity,height: 50,margin: EdgeInsets.all(10),child:TextFormField(decoration: InputDecoration(labelText: 'LineURL'),
          onChanged: (String value) {setState(() {Line = value;});},),),
         Container(color: Colors.grey[100],width:double.infinity,height: 50,margin: EdgeInsets.all(10),child:TextFormField(decoration: InputDecoration(labelText: '予約サイトURL'),
          onChanged: (String value) {setState(() {site = value;});},),),
        Container(margin: EdgeInsets.only(top:20,bottom: 5),
          child: ElevatedButton(child: const Text('追加'),
            style: ElevatedButton.styleFrom(primary: Colors.blueGrey[900], onPrimary: Colors.white, shape: const StadiumBorder(),),
            onPressed: () {add();},),),
      ],))],);});}
  Future<void> add() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
  var uid = prefs.getString("uid")?? "";
  Id = randomString(10);
  FirebaseFirestore.instance.collection('施術者').doc(uid).collection("メニュー").doc("方法").set({
    "ホームページ":home,"TEL":TEL,"Line":Line,"サイト":site, "Id":Id,"Co":"方法"},);setState(() {Navigator.of(context).pop();});}
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




class EditeMenuAdd extends StatefulWidget {
  EditeMenuAdd(this.uid);
  String uid;
  @override
  @override
  State<EditeMenuAdd> createState() => _EditeMenuAddState();
}
class _EditeMenuAddState extends State<EditeMenuAdd> {
  void initState() {
    super.initState();
  }
  var uid = "";
  var type = "";
  String infoText = '';
  String text = '';
  String subText = '';
  var limit = 0;
  var time = 0;
  var Id = "";
  var list = ["治療","美容","エステ","リラクゼーション"];
  final TextEditingController _controller = TextEditingController();
  var textCon = TextEditingController();
  var subTextCon = TextEditingController();
  var limitCon = TextEditingController();
  var timeCon = TextEditingController();
  var typeCon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("追加",style: TextStyle(fontWeight: FontWeight.bold,color:Colors.black),),
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Container(
                child: Column(children: <Widget>[
                  Container(margin: EdgeInsets.all(10),child:TextFormField(onTap: () {
                  FocusScope.of(context).requestFocus(new FocusNode());showPicker();},controller: typeCon,decoration: InputDecoration(labelText: '施術タイプ'),
                    onChanged: (String value) {setState(() {type = value;});},),),
                  Container(
                    margin: EdgeInsets.all(10),
                    child:TextFormField(
                      controller: textCon,
                      decoration: InputDecoration(labelText:"メニュー名"),
                      onChanged: (String value) {
                        setState(() {text = value;});
                      },),) ,
                  Container(
                    margin: EdgeInsets.all(10),
                    child:TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      controller: subTextCon,
                      decoration: InputDecoration(labelText:"説明"),
                      onChanged: (String value1) {
                        setState(() {subText = value1;});
                      },),),
                  Container(
                    margin: EdgeInsets.all(10),
                    child:TextFormField(
                      keyboardType: TextInputType.number,
                      maxLines: null,
                      controller: limitCon,
                      decoration: InputDecoration(labelText:"値段"),
                      onChanged: (String value2) {
                        setState(() {limit = int.parse(value2); });
                      },),),
                  Container(
                    margin: EdgeInsets.all(10),
                    child:TextFormField(
                      keyboardType: TextInputType.number,
                      maxLines: null,
                      controller: timeCon,
                      decoration: InputDecoration(labelText:"施術時間＋インターバル時間(分)"),
                      onChanged: (String value3) {
                        setState(() { time = int.parse(value3); });
                      },),),
                  Container(
                    margin: EdgeInsets.only(top:20,bottom: 20),
                    child: ElevatedButton(
                      child: Text('追加',style: TextStyle(fontWeight: FontWeight.bold),),
                      onPressed: ()  {Id = randomString(20);addFilePath();},
                    ),),]))));
  }
  Future<void> addFilePath() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uid = prefs.getString("uid")?? "";
    FirebaseFirestore.instance.collection('施術者').doc(uid).collection("メニュー").doc(Id).set({
      "タイプ":type, "text": text, "subText":subText, "値段":limit, "時間":time, "Id":Id,"Co":"メニュー"
    },);
    textCon.clear();
    subTextCon.clear();
    limitCon.clear();
    Navigator.of(context, rootNavigator: true).pop();
    setState(() {});
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
  void showPicker() {
    final _pickerItems = list.map((item) => Text(item)).toList();
    var selectedIndex = 0;
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 216,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: CupertinoPicker(backgroundColor: Colors.white,
              itemExtent: 32,
              children: _pickerItems,
              onSelectedItemChanged: (int index) {
                selectedIndex = index;
              },),),);},).then((_) {
      if (selectedIndex != null) {
        typeCon.value = TextEditingValue(text: list[selectedIndex]);
         type = list[selectedIndex];
        }});}
}