
import 'dart:math';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' as io;

import 'SignUp.dart';
import 'main.dart';

void main() async {
  // 初期化処理を追加
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

/* --- 省略 --- */

// ログイン画面用Widget
class SignUp extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<SignUp> {
  // メッセージ表示用
  String infoText = '';

  // 入力したメールアドレス・パスワード
  String email = '';
  String name = '';
  String password = '';
  var uid = "";
  var item = [];
  var tap = 0;
  var Shop = "";
  var Id = "";
  var Ken = "";var Shityo = "";var Rosen = "";var Eki = "";var sex = "";
  var item0 = ["男性","女性"];
  String imgPathUse="";
  File? _image;
  final imagePicker = ImagePicker();
  var KenCon = TextEditingController();
  var ShityoCon = TextEditingController();
  var RosenCon = TextEditingController();
  var EkiCon = TextEditingController();

  Future getImageFromCamera() async {
    final pickedFile = await imagePicker.getImage(source: ImageSource.camera);
    setState(() {if (pickedFile != null) {_image = File(pickedFile.path);}});}
  PickedFile? pickedFile;
  Future getImageFromGarally() async {
    pickedFile = await imagePicker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {_image = File(pickedFile!.path);}});
  }
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) => initPlugin());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(height: 200,
                child: Container(
                    alignment: Alignment.center,
                    child: _image == null ?
                    Text('プロフィール写真選択\n１枚のみです',textAlign: TextAlign.center,)
                        : Image.file(_image!)),),
              Container(
                  margin: EdgeInsets.only(top:20,bottom: 20),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                    FloatingActionButton(
                        onPressed: getImageFromCamera, child: Icon(Icons.photo_camera)),
                    FloatingActionButton(
                        onPressed: getImageFromGarally, child: Icon(Icons.photo_album))
                  ])),
              Container(width:double.infinity,height: 30 ,margin: EdgeInsets.only(top:10), child: Text("名前",style: TextStyle(color: Colors.blueGrey[900],fontWeight: FontWeight.bold,fontSize: 20),textAlign: TextAlign.center,),),
              Container(color: Colors.grey[100],width:double.infinity,height: 50,margin: EdgeInsets.all(10),child:TextFormField(decoration: InputDecoration(labelText: 'なまえ'),
                onChanged: (String value) {setState(() {name = value;});},),),
              Container(width:double.infinity,height: 30 ,margin: EdgeInsets.only(top:10), child: Text("メールアドレス",style: TextStyle(color: Colors.blueGrey[900],fontWeight: FontWeight.bold,fontSize: 20),textAlign: TextAlign.center,),),
              Container(color: Colors.grey[100],width:double.infinity,height: 50,margin: EdgeInsets.all(10),child:TextFormField(decoration: InputDecoration(labelText: 'メールアドレス'),
                onChanged: (String value) {setState(() {email = value;});},),),
              Container(width:double.infinity,height: 30 ,margin: EdgeInsets.only(top:10), child: Text("パスワード",style: TextStyle(color: Colors.blueGrey[900],fontWeight: FontWeight.bold,fontSize: 20),textAlign: TextAlign.center,),),
              Container(color: Colors.grey[100],width:double.infinity,height: 50,margin: EdgeInsets.all(10),child:TextFormField(decoration: InputDecoration(labelText: 'パスワード'),
                onChanged: (String value) {setState(() {password = value;});},),),
              Container(width:double.infinity,height: 30 ,margin: EdgeInsets.only(top:10), child: Text("性別["+sex+"]",style: TextStyle(color: Colors.blueGrey[900],fontWeight: FontWeight.bold,fontSize: 20),textAlign: TextAlign.center,),),
              GridView.count(
                  padding: EdgeInsets.all(10.0), crossAxisCount: 2, crossAxisSpacing: 5.0,mainAxisSpacing: 10.0,childAspectRatio: 3.0,
                  shrinkWrap: true,physics: NeverScrollableScrollPhysics(),
                  children: List.generate(item0.length, (index) {
                    return GestureDetector(onTap: () {setState(() {sex = item0[index];}); },    child:Container(alignment: Alignment.center,color: Colors.grey[100],
                         child:Text(item0[index],style: TextStyle(color: Colors.blueGrey[900],fontWeight: FontWeight.bold,fontSize: 20),)),
                    );})),
              Container(width:double.infinity,height: 30 ,margin: EdgeInsets.only(top:10), child: Text("店舗名",style: TextStyle(color: Colors.blueGrey[900],fontWeight: FontWeight.bold,fontSize: 20),textAlign: TextAlign.center,),),
              Container(color: Colors.grey[100],width:double.infinity,height: 50,margin: EdgeInsets.all(10),child:TextFormField(decoration: InputDecoration(labelText: '店舗名'),
                onChanged: (String value) {setState(() {Shop = value;});},),),

              Container(width:double.infinity,height: 30 ,margin: EdgeInsets.only(top:10), child: Text("都道府県",style: TextStyle(color: Colors.blueGrey[900],fontWeight: FontWeight.bold,fontSize: 20),textAlign: TextAlign.center,),),
              Container(width:double.infinity,height: 50 ,color: Colors.grey[100],margin: EdgeInsets.all(10),child:TextFormField(onTap: () {item =["道央","道南","道北","オホーツク","十勝","釧路・根室","青森県","岩手県","秋田県","宮城県","山形県","福島県","新潟県","富山県","石川県","福井県","山梨","長野県","栃木県","群馬県","茨城県","埼玉県","東京都","千葉県","神奈川県","岐阜県","静岡県","愛知県","三重県","滋賀県","京都府","大阪府","兵庫県","奈良県","和歌山県","鳥取県","島根県","岡山県","広島県","山口県","徳島県","香川県","愛媛県","高知県","福岡県","佐賀県","長崎県","熊本県","大分県","宮崎県","鹿児島県","沖縄県"];
              FocusScope.of(context).requestFocus(new FocusNode());tap = 1;showPicker();},controller: KenCon,decoration: InputDecoration(labelText: '選択'),
                onChanged: (String value) {setState(() {});},),),

              Container(width:double.infinity,height: 30 ,margin: EdgeInsets.only(top:10), child: Text("市町村",style: TextStyle(color: Colors.blueGrey[900],fontWeight: FontWeight.bold,fontSize: 20),textAlign: TextAlign.center,),),
              Container(width:double.infinity,height: 50 ,color: Colors.grey[100],margin: EdgeInsets.all(10),child:TextFormField(onTap: () { _loadData();FocusScope.of(context).requestFocus(new FocusNode());tap = 2;showPicker();},controller: ShityoCon,decoration: InputDecoration(labelText: '選択'),
                onChanged: (String value) {setState(() {});},),),

              Container(width:double.infinity,height: 30 ,margin: EdgeInsets.only(top:10), child: Text("最寄り路線",style: TextStyle(color: Colors.blueGrey[900],fontWeight: FontWeight.bold,fontSize: 20),textAlign: TextAlign.center,),),
              Container(width:double.infinity,height: 50 ,color: Colors.grey[100],margin: EdgeInsets.all(10),child:TextFormField(onTap: () {item =["道央","道南","道北","オホーツク","十勝","釧路・根室","青森県","岩手県","秋田県","宮城県","山形県","福島県","新潟県","富山県","石川県","福井県","山梨","長野県","栃木県","群馬県","茨城県","埼玉県","東京都","千葉県","神奈川県","岐阜県","静岡県","愛知県","三重県","滋賀県","京都府","大阪府","兵庫県","奈良県","和歌山県","鳥取県","島根県","岡山県","広島県","山口県","徳島県","香川県","愛媛県","高知県","福岡県","佐賀県","長崎県","熊本県","大分県","宮崎県","鹿児島県","沖縄県"];
              FocusScope.of(context).requestFocus(new FocusNode());tap = 3;showPicker();},controller: RosenCon,decoration: InputDecoration(labelText: '選択'),
                onChanged: (String value) {setState(() {});},),),

              Container(width:double.infinity,height: 30 ,margin: EdgeInsets.only(top:10), child: Text("最寄り駅",style: TextStyle(color: Colors.blueGrey[900],fontWeight: FontWeight.bold,fontSize: 20),textAlign: TextAlign.center,),),
              Container(width:double.infinity,height: 50 ,color: Colors.grey[100],margin: EdgeInsets.all(10),child:TextFormField(onTap: () { _loadData();FocusScope.of(context).requestFocus(new FocusNode());tap = 4;showPicker();},controller:EkiCon,decoration: InputDecoration(labelText: '選択'),
                onChanged: (String value) {setState(() {});},),),

              Container(padding: EdgeInsets.all(8), child: Text(infoText),),
              Container(width: double.infinity,
                child: ElevatedButton(child: Text("プライバシーポリシー"),
                  onPressed: () async {final url = "https://note.com/mats_/n/n7ab698b74316";
                    if (await canLaunch(url)) {await launch(url);}},
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent, elevation: 0, onPrimary: Colors.blue,),),),
              Container(width: double.infinity,
                child: ElevatedButton(child: Text("利用規約"),
                  onPressed: () async {final url = "https://note.com/mats_/n/nabf5219f285b";
                    if (await canLaunch(url)) {await launch(url);}},
                  style: ElevatedButton.styleFrom(primary: Colors.transparent, elevation: 0, onPrimary: Colors.blue,),),),
              Container(width: double.infinity,
                child: ElevatedButton(
                    child: Text('上記２つに同意してユーザー登録'),
                    onPressed: () async {
                      if (email != "" || name != "" || password != ""){
                        try {
                          final FirebaseAuth auth = FirebaseAuth.instance;
                          await auth.createUserWithEmailAndPassword(
                            email: email, password: password,);
                          Id = randomString(20); uploadFile(pickedFile!.path,Id);
                          await Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) {
                              return MyApp();}),);
                        } catch (e) {
                          setState(() {infoText = "登録に失敗しました：${e.toString()}";});}
                      }else{
                        setState(() {infoText = "登録に失敗しました";});}}
                ),),
              const SizedBox(height: 8),
              Container(width: double.infinity,
                child: OutlinedButton(child: Text('ログイン'),
                  onPressed: () async {try {
                      final FirebaseAuth auth = FirebaseAuth.instance;
                      final result = await auth.signInWithEmailAndPassword(
                        email: email, password: password,);
                      await Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) {
                          return MyApp();
                        }),);
                    } catch (e) {}
                  },),)
            ],
          ),),),);}

  Future<void> add() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      var uid = user?.uid;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("uid", uid!);
      var pass = randomString(4);
      await FirebaseFirestore.instance.collection('施術者').doc(Shityo).collection("施術者").doc(user?.uid).set({
        "email" : email,
        "uid":user?.uid,
        "userName":name,
        "コード":pass,
        "総合":[0,0,0], "コミュ":[0,0,0], "清潔感":[0,0,0], "雰囲気":[0,0,0], "美容ばり":[0,0,0], "全身症状":[0,0,0], "頭":[0,0,0], "首肩":[0,0,0], "背中":[0,0,0], "腕":[0,0,0], "足":[0,0,0],
        "店舗名":Shop,"ImageId":imgPathUse,
        "都道府県":Ken,"市町村":Shityo,
        "最寄り路線":Rosen,"最寄り駅":Eki,
        "createdAt": Timestamp.now(),
      });
      await FirebaseFirestore.instance.collection('施術者').doc(Eki).collection("施術者").doc(user?.uid).set({
        "email" : email,
        "uid":user?.uid,
        "userName":name,
        "コード":pass,
        "総合":[0,0,0], "コミュ":[0,0,0], "清潔感":[0,0,0], "雰囲気":[0,0,0], "美容ばり":[0,0,0], "全身症状":[0,0,0], "頭":[0,0,0], "首肩":[0,0,0], "背中":[0,0,0], "腕":[0,0,0], "足":[0,0,0],
        "店舗名":Shop,"ImageId":imgPathUse,
        "都道府県":Ken,"市町村":Shityo,
        "最寄り路線":Rosen,"最寄り駅":Eki,
        "createdAt": Timestamp.now(),
      });});}
  Future<void> uploadFile(String sourcePath, String uploadFileName) async {
    final FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child("images"); //保存するフォルダ
    io.File file = io.File(sourcePath);
    UploadTask task = ref.child(uploadFileName).putFile(file);
    try {
      var snapshot = await task;
    } catch (FirebaseException) {}
    getImgs(Id);
  }
  void getImgs(String imgPathRemote) async{
    if ((imgPathRemote != "") && (imgPathRemote != null)) {
      try {
        imgPathUse = await FirebaseStorage.instance.ref().
        child("images").child(imgPathRemote).getDownloadURL();
       add();
      }
      catch (FirebaseException) {}} else{}}
  Future<void> initPlugin() async {
    final status = await AppTrackingTransparency.trackingAuthorizationStatus;
    if (status == TrackingStatus.notDetermined) {
      await Future.delayed(const Duration(milliseconds: 200));
      await AppTrackingTransparency.requestTrackingAuthorization();
    }
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
    final _pickerItems = item.map((item) => Text(item)).toList();
    var selectedIndex = 0;
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(height: 216,
          child: GestureDetector(
            onTap: () {Navigator.pop(context);},
            child: CupertinoPicker(backgroundColor: Colors.white,
              itemExtent: 32,
              children: _pickerItems,
              onSelectedItemChanged: (int index) {
                selectedIndex = index;
              },),),);},).then((_) {
      if (selectedIndex != null) {
        switch(tap){
          case 1:Ken = item[selectedIndex];KenCon.value = TextEditingValue(text: item[selectedIndex]) ;break;
          case 2:Shityo = item[selectedIndex]; ShityoCon.value = TextEditingValue(text: item[selectedIndex]);break;
          case 3:Rosen = item[selectedIndex];RosenCon.value = TextEditingValue(text: item[selectedIndex]) ;break;
          case 4:Eki = item[selectedIndex];EkiCon.value = TextEditingValue(text: item[selectedIndex]) ;break;
        }

      }});}
  void _loadData()  {
    switch(Ken) {
      case '':item = ["都道府県を選択してください"];break;
      case '道央':item = ["石狩","後志","空知","胆振","日高"];break;
      case '道南':item = ["渡島","檜山"];break;
      case '道北':item = ["上川","留萌","宗谷"];break;
      case 'オホーツク':item = ["斜網","北見","遠軽","西紋"];break;
      case '十勝':item = ["北部","中部","南部"];break;
      case '釧路・根室':item = ["釧路","根室"];break;
      case '青森県':item = ["青森市","鰺ヶ沢町（西津軽郡）","板柳町（北津軽郡）","田舎館村（南津軽郡）","今別町（東津軽郡）","おいらせ町（上北郡）","大間町（下北郡）","大鰐町（南津軽郡）","風間浦村（下北郡）","黒石市","五所川原市","五戸町（三戸郡）","佐井村（下北郡）","三戸町（三戸郡）","七戸町（上北郡）","新郷村（三戸郡）","外ヶ浜町（東津軽郡）","田子町（三戸郡）","つがる市","鶴田町（北津軽郡）","東北町（上北郡）","十和田市","中泊町（北津軽郡）","南部町（三戸郡）","西目屋村（中津軽郡）","野辺地町（上北郡）","階上町（三戸郡）","八戸市","東通村（下北郡）","平川市","平内町（東津軽郡）","弘前市","深浦町（西津軽郡）","藤崎町（南津軽郡）","三沢市","むつ市","横浜町（上北郡）","蓬田村（東津軽郡）","六ヶ所村（上北郡）","六戸町（上北郡）"];break;
      case '岩手県':item = ["一関市","一戸町（二戸郡）","岩泉町（下閉伊郡）","岩手町（岩手郡）","奥州市","大槌町（上閉伊郡）","大船渡市","金ケ崎町（胆沢郡）","釜石市","軽米町（九戸郡）","北上市","久慈市","葛巻町（岩手郡）","九戸村（九戸郡）","雫石町（岩手郡）","紫波町（紫波郡）","住田町（気仙郡）","滝沢市","田野畑村（下閉伊郡）","遠野市","西和賀町（和賀郡）","二戸市","野田村（九戸郡）","八幡平市","花巻市","平泉町（西磐井郡）","洋野町（九戸郡）","普代村（下閉伊郡）","宮古市","盛岡市","矢巾町（紫波郡）","山田町（下閉伊郡）","陸前高田市"];break;
      case '秋田県':item = ["秋田市","井川町（南秋田郡）","羽後町（雄勝郡）","大潟村（南秋田郡）","大館市","男鹿市","潟上市","鹿角市","上小阿仁村（北秋田郡）","北秋田市","小坂町（鹿角郡）","五城目町（南秋田郡）","仙北市","大仙市","にかほ市","能代市","八峰町（山本郡）","八郎潟町（南秋田郡）","東成瀬村（雄勝郡）","藤里町（山本郡）","美郷町（仙北郡）","三種町（山本郡）","湯沢市","由利本荘市","横手市"];break;
      case '宮城県':item = ["石巻市","岩沼市","大河原町（柴田郡）","大崎市","大郷町（黒川郡）","大衡村（黒川郡）","女川町（牡鹿郡）","角田市","加美町（加美郡）","川崎町（柴田郡）","栗原市","気仙沼市","蔵王町（刈田郡）","塩竈市","色麻町（加美郡）","七ヶ宿町（刈田郡）","七ヶ浜町（宮城郡）","柴田町（柴田郡）","白石市","仙台市","仙台市青葉区","仙台市泉区","仙台市太白区","仙台市宮城野区","仙台市若林区","大和町（黒川郡）","多賀城市","富谷市","登米市","名取市","東松島市","松島町（宮城郡）","丸森町（伊具郡）","美里町（遠田郡）","南三陸町（本吉郡）","村田町（柴田郡）","山元町（亘理郡）","利府町（宮城郡）","涌谷町（遠田郡）","亘理町（亘理郡）",];break;
      case '山形県':item = ["朝日町（西村山郡）","飯豊町（西置賜郡）","大石田町（北村山郡）","大江町（西村山郡）","大蔵村（最上郡）","小国町（西置賜郡）","尾花沢市","金山町（最上郡）","河北町（西村山郡）","上山市","川西町（東置賜郡）","酒田市","寒河江市","鮭川村（最上郡）","庄内町（東田川郡）","白鷹町（西置賜郡）","新庄市","高畠町（東置賜郡）","鶴岡市","天童市","戸沢村（最上郡）","中山町（東村山郡）","長井市","南陽市","西川町（西村山郡）","東根市","舟形町（最上郡）","真室川町（最上郡）","三川町（東田川郡）","村山市","最上町（最上郡）","山形市","山辺町（東村山郡）","遊佐町（飽海郡）","米沢市"];break;
      case '福島県':item = ["会津坂下町（河沼郡）","会津美里町（大沼郡）","会津若松市","浅川町（石川郡）","飯舘村（相馬郡）","石川町（石川郡）","泉崎村（西白河郡）","猪苗代町（耶麻郡）","いわき市","大玉村（安達郡）","小野町（田村郡）","鏡石町（岩瀬郡）","葛尾村（双葉郡）","金山町（大沼郡）","川内村（双葉郡）","川俣町（伊達郡）","喜多方市","北塩原村（耶麻郡）","国見町（伊達郡）","桑折町（伊達郡）","郡山市","鮫川村（東白川郡）","昭和村（大沼郡）","下郷町（南会津郡）","白河市","新地町（相馬郡）","須賀川市","相馬市","只見町（南会津郡）","棚倉町（東白川郡）","玉川村（石川郡）","田村市","伊達市（福島県）","天栄村（岩瀬郡）","富岡町（双葉郡）","中島村（西白河郡）","浪江町（双葉郡）","楢葉町（双葉郡）","西会津町（耶麻郡）","西郷村（西白河郡）","二本松市","塙町（東白川郡）","磐梯町（耶麻郡）","檜枝岐村（南会津郡）","平田村（石川郡）","広野町（双葉郡）","福島市","双葉町（双葉郡）","古殿町（石川郡）","三島町（大沼郡）","南会津町（南会津郡）","南相馬市","三春町（田村郡）","本宮市","柳津町（河沼郡）","矢吹町（西白河郡）","矢祭町（東白川郡）","湯川村（河沼郡）"];break;
      case '新潟県':item = ["阿賀野市","阿賀町（東蒲原郡）","粟島浦村（岩船郡）","出雲崎町（三島郡）","糸魚川市","魚沼市","小千谷市","柏崎市","加茂市","刈羽村（刈羽郡）","五泉市","佐渡市","三条市","新発田市","上越市","聖籠町（北蒲原郡）","関川村（岩船郡）","胎内市","田上町（南蒲原郡）","津南町（中魚沼郡）","燕市","十日町市","長岡市","新潟市","新潟市秋葉区","新潟市北区","新潟市江南区","新潟市中央区","新潟市西蒲区","新潟市西区","新潟市東区","新潟市南区","妙高市","見附市","南魚沼市","村上市","弥彦村（西蒲原郡）","湯沢町（南魚沼郡）"];break;
      case '富山県':item = ["朝日町（下新川郡）","射水市","魚津市","小矢部市","上市町（中新川郡）","黒部市","高岡市","立山町（中新川郡）","砺波市","富山市","滑川市","南砺市","入善町（下新川郡）","氷見市","舟橋村（中新川郡）"];break;
      case '石川県':item = ["穴水町（鳳珠郡）","内灘町（河北郡）","加賀市","金沢市","かほく市","川北町（能美郡）","小松市","志賀町（羽咋郡）","珠洲市","津幡町（河北郡）","中能登町（鹿島郡）","七尾市","能登町（鳳珠郡）","野々市市","能美市","羽咋市","白山市","宝達志水町（羽咋郡）","輪島市"];break;
      case '福井県':item = ["あわら市","池田町（今立郡）","永平寺町（吉田郡）","越前市","越前町（丹生郡）","おおい町（大飯郡）","大野市","小浜市","勝山市","坂井市","鯖江市","高浜町（大飯郡）","敦賀市","福井市","南越前町（南条郡）","美浜町（三方郡）","若狭町（三方上中郡）"];break;
      case '山梨県':item = ["市川三郷町（西八代郡）","上野原市","大月市","忍野村（南都留郡）","甲斐市","甲州市","甲府市","小菅村（北都留郡）","昭和町（中巨摩郡）","丹波山村（北都留郡）","中央市","都留市","道志村（南都留郡）","鳴沢村（南都留郡）","南部町（南巨摩郡）","西桂町（南都留郡）","韮崎市","早川町（南巨摩郡）","笛吹市","富士河口湖町（南都留郡）","富士川町（南巨摩郡）","富士吉田市","北杜市","南アルプス市","身延町（南巨摩郡）","山中湖村（南都留郡）","山梨市"];break;
      case '長野県':item = ["青木村（小県郡）","上松町（木曽郡）","朝日村（東筑摩郡）","阿智村（下伊那郡）","安曇野市","阿南町（下伊那郡）","飯島町（上伊那郡）","飯田市","飯綱町（上水内郡）","飯山市","生坂村（東筑摩郡）","池田町（北安曇郡）","伊那市","上田市","売木村（下伊那郡）","王滝村（木曽郡）","大桑村（木曽郡）","大鹿村（下伊那郡）","大町市","岡谷市","小川村（上水内郡）","小谷村（北安曇郡）","小布施町（上高井郡）","麻績村（東筑摩郡）","軽井沢町（北佐久郡）","川上村（南佐久郡）","木島平村（下高井郡）","木曽町（木曽郡）","木祖村（木曽郡）","北相木村（南佐久郡）","小海町（南佐久郡）","駒ヶ根市","小諸市","栄村（下水内郡）","坂城町（埴科郡）","佐久市","佐久穂町（南佐久郡）","塩尻市","静岡市","信濃町（上水内郡）","下條村（下伊那郡）","下諏訪町（諏訪郡）","須坂市","諏訪市","喬木村（下伊那郡）","高森町（下伊那郡）","高山村（上高井郡）","辰野町（上伊那郡）","立科町（北佐久郡）","筑北村（東筑摩郡）","千曲市","茅野市","天龍村（下伊那郡）","東御市","豊丘村（下伊那郡）","中川村（上伊那郡）","中野市","長野市","長和町（小県郡）","南木曽町（木曽郡）","根羽村（下伊那郡）","野沢温泉村（下高井郡）","白馬村（北安曇郡）","原村（諏訪郡）","平谷村（下伊那郡）","富士見町（諏訪郡）","松川町（下伊那郡）","松川村（北安曇郡）","松本市","南相木村（南佐久郡）","南牧村（南佐久郡）","南箕輪村（上伊那郡）","箕輪町（上伊那郡）","宮田村（上伊那郡）","御代田町（北佐久郡）","泰阜村（下伊那郡）","山形村（東筑摩郡）","山ノ内町（下高井郡）"];break;
      case '栃木県':item = ["足利市","市貝町（芳賀郡）","宇都宮市","大田原市","小山市","鹿沼市","上三川町（河内郡）","さくら市","佐野市","塩谷町（塩谷郡）","下野市","高根沢町（塩谷郡）","栃木市","那珂川町（那須郡）","那須烏山市","那須塩原市","那須町（那須郡）","日光市","野木町（下都賀郡）","芳賀町（芳賀郡）","益子町（芳賀郡）","壬生町（下都賀郡）","真岡市","茂木町（芳賀郡）","矢板市"];break;
      case '群馬県':item = ["安中市","伊勢崎市","板倉町（邑楽郡）","上野村（多野郡）","邑楽町（邑楽郡）","大泉町（邑楽郡）","太田市","片品村（利根郡）","川場村（利根郡）","神流町（多野郡）","甘楽町（甘楽郡）","桐生市","草津町（吾妻郡）","昭和村（利根郡）","渋川市","下仁田町（甘楽郡）","榛東村（北群馬郡）","高崎市","高山村（吾妻郡）","館林市","玉村町（佐波郡）","千代田町（邑楽郡）","嬬恋村（吾妻郡）","富岡市","中之条町（吾妻郡）","長野原町（吾妻郡）","南牧村（甘楽郡）","沼田市","東吾妻町（吾妻郡）","藤岡市","前橋市","みどり市","みなかみ町（利根郡）","明和町（邑楽郡）","吉岡町（北群馬郡）"];break;
      case '茨城県':item = ["阿見町（稲敷郡）","石岡市","潮来市","稲敷市","茨城町（東茨城郡）","牛久市","大洗町（東茨城郡）","小美玉市","笠間市","鹿嶋市","かすみがうら市","神栖市","河内町（稲敷郡）","北茨城市","古河市","五霞町（猿島郡）","境町（猿島郡）","桜川市","下妻市","城里町（東茨城郡）","常総市","高萩市","大子町（久慈郡）","筑西市","つくば市","つくばみらい市","土浦市","東海村（那珂郡）","利根町（北相馬郡）","取手市","那珂市","行方市","坂東市","常陸太田市","常陸大宮市","日立市","ひたちなか市","鉾田市","水戸市","美浦村（稲敷郡）","守谷市","八千代町（結城郡）","結城市","龍ケ崎市"];break;
      case '埼玉県':item = ["上尾市","朝霞市","伊奈町（北足立郡）","入間市","小鹿野町（秩父郡）","小川町（比企郡）","桶川市","越生町（入間郡）","春日部市","加須市","神川町（児玉郡）","上里町（児玉郡）","川口市","川越市","川島町（比企郡）","北本市","行田市","久喜市","熊谷市","久喜市","熊谷市","鴻巣市","越谷市","幸手市","さいたま市","さいたま市岩槻区","さいたま市浦和区","さいたま市大宮区","さいたま市北区","さいたま市桜区","さいたま市中央区","さいたま市西区","さいたま市緑区","さいたま市南区","さいたま市見沼区","坂戸市","狭山市","志木市","白岡市","杉戸町（北葛飾郡）","草加市","秩父市","鶴ヶ島市","ときがわ町（比企郡）","所沢市","戸田市","長瀞町（秩父郡）","滑川町（比企郡）","新座市","蓮田市","鳩山町（比企郡）","羽生市","飯能市","東秩父村（秩父郡）","東松山市","日高市","深谷市","富士見市","ふじみ野市","本庄市","松伏町（北葛飾郡）","三郷市","美里町（児玉郡）","皆野町（秩父郡）","宮代町（南埼玉郡）","三芳町（入間郡）","毛呂山町（入間郡）","八潮市","横瀬町（秩父郡）","吉川市","吉見町（比企郡）","寄居町（大里郡）","嵐山町（比企郡）","和光市","蕨市"];break;
      case '東京都':item = ["青ヶ島村","昭島市","あきる野市","足立区","荒川区","板橋区","稲城市","江戸川区","青梅市","大島町","大田区","小笠原村","奥多摩町（西多摩郡）","葛飾区","北区","清瀬市","国立市","神津島村","江東区","小金井市","国分寺市","小平市","狛江市","品川区","渋谷区","新宿区","杉並区","墨田区","世田谷区","台東区","立川市","多摩市","中央区","調布市","千代田区","豊島区","利島村","中野区","新島村","西東京市","練馬区","八王子市","八丈町","羽村市","東久留米市","東村山市","東大和市","日野市","日の出町（西多摩郡）","檜原村（西多摩郡）","福生市","府中市（東京都）","文京区","町田市","御蔵島村","瑞穂町（西多摩郡）","三鷹市","港区","三宅村","武蔵野市","武蔵村山市","目黒区"];break;
      case '千葉県':item = ["旭市","我孫子市","いすみ市","市川市","一宮町（長生郡）","市原市","印西市","浦安市","大網白里市","大多喜町（夷隅郡）","御宿町（夷隅郡）","柏市","勝浦市","香取市","鎌ケ谷市","鴨川市","鋸南町（安房郡）","木更津市","君津市","九十九里町（山武郡）","神崎町（香取郡）","栄町（印旛郡）","佐倉市","山武市","酒々井町（印旛郡）","芝山町（山武郡）","白子町（長生郡）","白井市","匝瑳市","袖ケ浦市","多古町（香取郡）","館山市","銚子市","長生村（長生郡）","長南町（長生郡）","千葉市","千葉市稲毛区","千葉市中央区","千葉市花見川区","千葉市緑区","千葉市美浜区","千葉市若葉区","東金市","東庄町（香取郡）","富里市","長柄町（長生郡）","流山市","習志野市","成田市","野田市","富津市","船橋市","松戸市","南房総市","睦沢町（長生郡）","茂原市","八街市","八千代市","横芝光町（山武郡）","四街道市"];break;
      case '神奈川県':item = ["愛川町（愛甲郡）","厚木市","綾瀬市","伊勢原市","海老名市","大磯町（中郡）","大井町（足柄上郡）","小田原市","開成町（足柄上郡）","鎌倉市","川崎市","川崎市麻生区","川崎市川崎区","川崎市幸区","川崎市高津区","川崎市多摩区","川崎市中原区","川崎市宮前区","清川村（愛甲郡）","相模原市","相模原市中央区","相模原市緑区","相模原市南区","寒川町（高座郡）","座間市","逗子市","茅ヶ崎市","中井町（足柄上郡）","二宮町（中郡）","箱根町（足柄下郡）","秦野市","葉山町（三浦郡）","平塚市","藤沢市","松田町（足柄上郡）","真鶴町（足柄下郡）","三浦市","南足柄市","山北町（足柄上郡）","大和市","湯河原町（足柄下郡）","横須賀市","横浜市","横浜市青葉区","横浜市旭区","横浜市泉区","横浜市磯子区","横浜市神奈川区","横浜市金沢区","横浜市港南区","横浜市港北区","横浜市栄区","横浜市瀬谷区","横浜市都筑区","横浜市鶴見区","横浜市戸塚区","横浜市中区","横浜市西区","横浜市保土ケ谷区","横浜市緑区","横浜市南区"];break;
      case '岐阜県':item = ["安八町（安八郡）","池田町（揖斐郡）","揖斐川町（揖斐郡）","恵那市","大垣市","大野町（揖斐郡）","海津市","各務原市","笠松町（羽島郡）","可児市","川辺町（加茂郡）","北方町（本巣郡）","岐南町（羽島郡）","岐阜市","郡上市","下呂市","神戸町（安八郡）","坂祝町（加茂郡）","白川町（加茂郡）","白川村（大野郡）","関ケ原町（不破郡）","関市","高山市","多治見市","垂井町（不破郡）","土岐市","富加町（加茂郡）","中津川市","羽島市","東白川村（加茂郡）","飛騨市","七宗町（加茂郡）","瑞浪市","瑞穂市","御嵩町（可児郡）","美濃加茂市","美濃市","本巣市","八百津町（加茂郡）","山県市","養老町（養老郡）","輪之内町（安八郡）"];break;
      case '静岡県':item = ["熱海市","伊豆市","伊豆の国市","伊東市","磐田市","御前崎市","小山町（駿東郡）","掛川市","河津町（賀茂郡）","川根本町（榛原郡）","函南町（田方郡）","菊川市","湖西市","御殿場市","静岡市","静岡市葵区","静岡市清水区","静岡市駿河区","島田市","清水町（駿東郡）","下田市","裾野市","長泉町（駿東郡）","西伊豆町（賀茂郡）","沼津市","浜松市","浜松市北区","浜松市天竜区","浜松市中区","浜松市西区","浜松市浜北区","浜松市東区","浜松市南区","東伊豆町（賀茂郡）","袋井市","藤枝市","富士市","富士宮市","牧之原市","松崎町（賀茂郡）","三島市","南伊豆町（賀茂郡）","森町（周智郡）","焼津市","吉田町（榛原郡）"];break;
      case '愛知県':item = ["愛西市","阿久比町（知多郡）","あま市","安城市","一宮市","稲沢市","犬山市","岩倉市","大口町（丹羽郡）","大治町（海部郡）","大府市","岡崎市","尾張旭市","春日井市","蟹江町（海部郡）","刈谷市","蒲郡市","北名古屋市","清須市","幸田町（額田郡）","江南市","小牧市","設楽町（北設楽郡）","新城市","瀬戸市","高浜市","武豊町（知多郡）","田原市","知多市","知立市","津島市","東栄町（北設楽郡）","東海市","東郷町（愛知郡）","常滑市","飛島村（海部郡）","豊明市","豊川市","豊田市","豊根村（北設楽郡）","豊橋市","豊山町（西春日井郡）","長久手市","名古屋市","名古屋市熱田区","名古屋市北区","名古屋市昭和区","名古屋市千種区","名古屋市天白区","名古屋市中川区","名古屋市中区","名古屋市中村区","名古屋市西区","名古屋市東区","名古屋市瑞穂区","名古屋市緑区","名古屋市港区","名古屋市南区","名古屋市名東区","名古屋市守山区","日進市","西尾市","半田市","東浦町（知多郡）","扶桑町（丹羽郡）","碧南市","南知多町（知多郡）","美浜町（知多郡）","みよし市","弥富市"];break;
      case '三重県':item = ["朝日町（三重郡）","伊賀市","伊勢市","いなべ市","大台町（多気郡）","尾鷲市","亀山市","川越町（三重郡）","木曽岬町（桑名郡）","紀宝町（南牟婁郡）","紀北町（北牟婁郡）","熊野市","桑名市","菰野町（三重郡）","志摩市","鈴鹿市","大紀町（度会郡）","多気町（多気郡）","玉城町（度会郡）","津市","東員町（員弁郡）","鳥羽市","名張市","松阪市","南伊勢町（度会郡）","御浜町（南牟婁郡）","明和町（多気郡）","四日市市","度会町（度会郡）"];break;
      case '滋賀県':item =["愛荘町（愛知郡）","近江八幡市","大津市","草津市","甲賀市","甲良町（犬上郡）","湖南市","高島市","多賀町（犬上郡）","豊郷町（犬上郡）","長浜市","東近江市","彦根市","日野町（蒲生郡）","米原市","守山市","野洲市","竜王町（蒲生郡）","栗東市"];break;
      case '京都府':item = ["綾部市","井手町（綴喜郡）","伊根町（与謝郡）","宇治市","宇治田原町（綴喜郡）","大山崎町（乙訓郡）","笠置町（相楽郡）","亀岡市","京田辺市","京丹後市","京丹波町（船井郡）","京都市","京都市右京区","京都市上京区","京都市北区","京都市左京区","京都市下京区","京都市中京区","京都市西京区","京都市東山区","京都市伏見区","京都市南区","京都市山科区","木津川市","久御山町（久世郡）","城陽市","精華町（相楽郡）","長岡京市","南丹市","福知山市","舞鶴市","南山城村（相楽郡）","宮津市","向日市","八幡市","与謝野町（与謝郡）","和束町（相楽郡）"];break;
      case '大阪府':item = ["池田市","泉大津市","泉佐野市","和泉市","茨木市","大阪狭山市","大阪市","大阪市旭区","大阪市阿倍野区","大阪市生野区","大阪市北区","大阪市此花区","大阪市城東区","大阪市住之江区","大阪市住吉区","大阪市大正区","大阪市中央区","大阪市鶴見区","大阪市天王寺区","大阪市浪速区","大阪市西区","大阪市西成区","大阪市西淀川区","大阪市東住吉区","大阪市東成区","大阪市東淀川区","大阪市平野区","大阪市福島区","大阪市港区","大阪市都島区","大阪市淀川区","貝塚市","柏原市","交野市","門真市","河南町（南河内郡）","河内長野市","岸和田市","熊取町（泉南郡）","堺市","堺市北区","堺市堺区","堺市中区","堺市西区","堺市東区","堺市南区","堺市美原区","四條畷市","島本町（三島郡）","吹田市","摂津市","泉南市","太子町（南河内郡）","高石市","高槻市","田尻町（泉南郡）","忠岡町（泉北郡）","大東市","千早赤阪村（南河内郡）","豊中市","豊能町（豊能郡）","富田林市","寝屋川市","能勢町（豊能郡）","羽曳野市","阪南市","東大阪市","枚方市","藤井寺市","松原市","岬町（泉南郡）","箕面市","守口市","八尾市"];break;
      case '兵庫県':item = ["相生市","明石市","赤穂市","朝来市","芦屋市","尼崎市","淡路市","伊丹市","市川町（神崎郡）","猪名川町（川辺郡）","稲美町（加古郡）","小野市","加古川市","加西市","加東市","神河町（神崎郡）","上郡町（赤穂郡）","香美町（美方郡）","川西市","神戸市","神戸市北区","神戸市須磨区","神戸市垂水区","神戸市中央区","神戸市長田区","神戸市灘区","神戸市西区","神戸市兵庫区","神戸市東灘区","佐用町（佐用郡）","三田市","宍粟市","新温泉町（美方郡）","洲本市","太子町（揖保郡）","高砂市","多可町（多可郡）","宝塚市","たつの市","丹波篠山市","丹波市","豊岡市","西宮市","西脇市","播磨町（加古郡）","姫路市","福崎町（神崎郡）","三木市","南あわじ市","養父市"];break;
      case '奈良県':item = ["明日香村（高市郡）","安堵町（生駒郡）","斑鳩町（生駒郡）","生駒市","宇陀市","王寺町（北葛城郡）","大淀町（吉野郡）","橿原市","香芝市","葛城市","上北山村（吉野郡）","河合町（北葛城郡）","川上村（吉野郡）","川西町（磯城郡）","上牧町（北葛城郡）","黒滝村（吉野郡）","広陵町（北葛城郡）","五條市","御所市","桜井市","三郷町（生駒郡）","下市町（吉野郡）","下北山村（吉野郡）","曽爾村（宇陀郡）","高取町（高市郡）","田原本町（磯城郡）","天川村（吉野郡）","天理市","十津川村（吉野郡）","奈良市","野迫川村（吉野郡）","東吉野村（吉野郡）","平群町（生駒郡）","御杖村（宇陀郡）","三宅町（磯城郡）","山添村（山辺郡）","大和郡山市","大和高田市","吉野町（吉野郡）"];break;
      case '和歌山県':item =["有田川町（有田郡）","有田市","印南町（日高郡）","岩出市","海南市","かつらぎ町（伊都郡）","上富田町（西牟婁郡）","北山村（東牟婁郡）","紀の川市","紀美野町（海草郡）","串本町（東牟婁郡）","九度山町（伊都郡）","高野町（伊都郡）","古座川町（東牟婁郡）","御坊市","白浜町（西牟婁郡）","新宮市","すさみ町（西牟婁郡）","太地町（東牟婁郡）","田辺市","那智勝浦町（東牟婁郡）","橋本市","日高川町（日高郡）","日高町（日高郡）","広川町（有田郡）","みなべ町（日高郡）","美浜町（日高郡）","湯浅町（有田郡）","由良町（日高郡）","和歌山市"];break;
      case '鳥取県':item = ["岩美町（岩美郡）","倉吉市","江府町（日野郡）","琴浦町（東伯郡）","境港市","大山町（西伯郡）","智頭町（八頭郡）","鳥取市","南部町（西伯郡）","日南町（日野郡）","日吉津村（西伯郡）","日野町（日野郡）","伯耆町（西伯郡）","北栄町（東伯郡）","三朝町（東伯郡）","八頭町（八頭郡）","湯梨浜町（東伯郡）","米子市","若桜町（八頭郡）"];break;
      case '島根県':item = ["海士町（隠岐郡）","飯南町（飯石郡）","出雲市","雲南市","大田市","邑南町（邑智郡）","隠岐の島町（隠岐郡）","奥出雲町（仁多郡）","川本町（邑智郡）","江津市","知夫村（隠岐郡）","津和野町（鹿足郡）","西ノ島町（隠岐郡）","浜田市","益田市","松江市","美郷町（邑智郡）","安来市","吉賀町（鹿足郡）"];break;
      case '岡山県':item = ["赤磐市","浅口市","井原市","岡山市","岡山市北区","岡山市中区","岡山市東区","岡山市南区","鏡野町（苫田郡）","笠岡市","吉備中央町（加賀郡）","久米南町（久米郡）","倉敷市","里庄町（浅口郡）","勝央町（勝田郡）","新庄村（真庭郡）","瀬戸内市","総社市","高梁市","玉野市","津山市","奈義町（勝田郡）","新見市","西粟倉村（英田郡）","早島町（都窪郡）","備前市","真庭市","美咲町（久米郡）","美作市","矢掛町（小田郡）","和気町（和気郡）"];break;
      case '広島県':item = ["安芸太田町（山県郡）","安芸高田市","江田島市","大崎上島町（豊田郡）","大竹市","尾道市","海田町（安芸郡）","北広島町（山県郡）","熊野町（安芸郡）","呉市","坂町（安芸郡）","庄原市","神石高原町（神石郡）","世羅町（世羅郡）","竹原市","廿日市市","東広島市","広島市","広島市安芸区","広島市安佐北区","広島市安佐南区","広島市佐伯区","広島市中区","広島市西区","広島市東区","広島市南区","福山市","府中市（広島県）","府中町（安芸郡）","三原市","三次市"];break;
      case '山口県':item = ["阿武町（阿武郡）","岩国市","宇部市","上関町（熊毛郡）","下松市","山陽小野田市","周南市","下関市","周防大島町（大島郡）","田布施町（熊毛郡）","長門市","萩市","光市","平生町（熊毛郡）","防府市","美祢市","柳井市","山口市","和木町（玖珂郡）"];break;
      case '徳島県':item = ["藍住町（板野郡）","阿南市","阿波市","石井町（名西郡）","板野町（板野郡）","海陽町（海部郡）","勝浦町（勝浦郡）","上板町（板野郡）","上勝町（勝浦郡）","神山町（名西郡）","北島町（板野郡）","小松島市","佐那河内村（名東郡）","つるぎ町（美馬郡）","徳島市","那賀町（那賀郡）","鳴門市","東みよし町（三好郡）","松茂町（板野郡）","美波町（海部郡）","美馬市","三好市","牟岐町（海部郡）","吉野川市"];break;
      case '香川県':item = ["綾川町（綾歌郡）","宇多津町（綾歌郡）","観音寺市","琴平町（仲多度郡）","坂出市","さぬき市","小豆島町（小豆郡）","善通寺市","高松市","多度津町（仲多度郡）","土庄町（小豆郡）","直島町（香川郡）","東かがわ市","丸亀市","まんのう町（仲多度郡）","三木町（木田郡）","三豊市"];break;
      case '愛媛県':item = ["愛南町（南宇和郡）","伊方町（西宇和郡）","今治市","伊予市","内子町（喜多郡）","宇和島市","大洲市","上島町（越智郡）","鬼北町（北宇和郡）","久万高原町（上浮穴郡）","西条市","四国中央市","西予市","東温市","砥部町（伊予郡）","新居浜市","松前町（伊予郡）","松野町（北宇和郡）","松山市","八幡浜市"];break;
      case '高知県':item = ["安芸市","いの町（吾川郡）","馬路村（安芸郡）","大川村（土佐郡）","大月町（幡多郡）","大豊町（長岡郡）","越知町（高岡郡）","香美市","北川村（安芸郡）","黒潮町（幡多郡）","芸西村（安芸郡）","高知市","香南市","佐川町（高岡郡）","四万十市","四万十町（高岡郡）","宿毛市","須崎市","田野町（安芸郡）","津野町（高岡郡）","東洋町（安芸郡）","土佐市","土佐清水市","土佐町（土佐郡）","中土佐町（高岡郡）","奈半利町（安芸郡）","南国市","仁淀川町（吾川郡）","日高村（高岡郡）","三原村（幡多郡）","室戸市","本山町（長岡郡）","安田町（安芸郡）","梼原町（高岡郡）",];break;
      case '福岡県':item = ["赤村（田川郡）","朝倉市","芦屋町（遠賀郡）","飯塚市","糸島市","糸田町（田川郡）","うきは市","宇美町（糟屋郡）","大川市","大木町（三潴郡）","大任町（田川郡）","大野城市","大牟田市","岡垣町（遠賀郡）","小郡市","遠賀町（遠賀郡）","春日市","粕屋町（糟屋郡）","嘉麻市","川崎町（田川郡）","香春町（田川郡）","苅田町（京都郡）","北九州市","北九州市小倉北区","北九州市小倉南区","北九州市戸畑区","北九州市門司区","北九州市八幡西区","北九州市八幡東区","北九州市若松区","鞍手町（鞍手郡）","久留米市","桂川町（嘉穂郡）","上毛町（築上郡）","古賀市","小竹町（鞍手郡）","篠栗町（糟屋郡）","志免町（糟屋郡）","新宮町（糟屋郡）","須恵町（糟屋郡）","添田町（田川郡）","田川市","大刀洗町（三井郡）","太宰府市","筑後市","筑紫野市","築上町（築上郡）","筑前町（朝倉郡）","東峰村（朝倉郡）","那珂川市","中間市","直方市","久山町（糟屋郡）","広川町（八女郡）","福岡市","福岡市早良区","福岡市城南区","福岡市中央区","福岡市西区","福岡市博多区","福岡市東区","福岡市南区","福智町（田川郡）","福津市","豊前市","水巻町（遠賀郡）","みやこ町（京都郡）","みやま市","宮若市","宗像市","柳川市","八女市","行橋市","吉富町（築上郡）"];break;
      case '佐賀県':item = ["有田町（西松浦郡）","伊万里市","嬉野市","大町町（杵島郡）","小城市","鹿島市","上峰町（三養基郡）","唐津市","神埼市","基山町（三養基郡）","玄海町（東松浦郡）","江北町（杵島郡）","佐賀市","白石町（杵島郡）","多久市","武雄市","太良町（藤津郡）","鳥栖市","みやき町（三養基郡）","吉野ヶ里町（神埼郡）"];break;
      case '長崎県':item = ["壱岐市","諫早市","雲仙市","大村市","小値賀町（北松浦郡）","川棚町（東彼杵郡）","五島市","西海市","佐々町（北松浦郡）","佐世保市","島原市","新上五島町（南松浦郡）","対馬市","時津町（西彼杵郡）","長崎市","長与町（西彼杵郡）","波佐見町（東彼杵郡）","東彼杵町（東彼杵郡）","平戸市","松浦市","南島原市"];break;
      case '熊本県':item = ["あさぎり町（球磨郡）","芦北町（葦北郡）","阿蘇市","天草市","荒尾市","五木村（球磨郡）","宇城市","宇土市","産山村（阿蘇郡）","大津町（菊池郡）","小国町（阿蘇郡）","嘉島町（上益城郡）","上天草市","菊池市","菊陽町（菊池郡）","玉東町（玉名郡）","球磨村（球磨郡）","熊本市","熊本市北区","熊本市中央区","熊本市西区","熊本市東区","熊本市南区","甲佐町（上益城郡）","合志市","相良村（球磨郡）","高森町（阿蘇郡）","玉名市","多良木町（球磨郡）","津奈木町（葦北郡）","長洲町（玉名郡）","和水町（玉名郡）","南関町（玉名郡）","錦町（球磨郡）","西原村（阿蘇郡）","氷川町（八代郡）","人吉市","益城町（上益城郡）","美里町（下益城郡）","水上村（球磨郡）","水俣市","南阿蘇村（阿蘇郡）","南小国町（阿蘇郡）","御船町（上益城郡）","八代市","山江村（球磨郡）","山鹿市","山都町（上益城郡）","湯前町（球磨郡）","苓北町（天草郡）"];break;
      case '大分県':item = ["宇佐市","臼杵市","大分市","杵築市","玖珠町（玖珠郡）","国東市","九重町（玖珠郡）","佐伯市","竹田市","津久見市","中津市","日出町（速見郡）","日田市","姫島村（東国東郡）","豊後大野市","豊後高田市","別府市","由布市"];break;
      case '宮崎県':item = ["綾町（東諸県郡）","えびの市","門川町（東臼杵郡）","川南町（児湯郡）","木城町（児湯郡）","串間市","国富町（東諸県郡）","小林市","五ヶ瀬町（西臼杵郡）","西都市","椎葉村（東臼杵郡）","新富町（児湯郡）","高千穂町（西臼杵郡）","高鍋町（児湯郡）","高原町（西諸県郡）","都農町（児湯郡）","西米良村（児湯郡）","日南市","延岡市","日向市","日之影町（西臼杵郡）","美郷町（東臼杵郡）","三股町（北諸県郡）","都城市","宮崎市","諸塚村（東臼杵郡）"];break;
      case '鹿児島県':item = ["姶良市","阿久根市","天城町（大島郡）","奄美市","伊佐市","出水市","伊仙町（大島郡）","いちき串木野市","指宿市","宇検村（大島郡）","大崎町（曽於郡）","鹿児島市","鹿屋市","喜界町（大島郡）","肝付町（肝属郡）","霧島市","錦江町（肝属郡）","薩摩川内市","さつま町（薩摩郡）","志布志市","瀬戸内町（大島郡）","曽於市","龍郷町（大島郡）","垂水市","知名町（大島郡）","徳之島町（大島郡）","十島村（鹿児島郡）","中種子町（熊毛郡）","長島町（出水郡）","西之表市","日置市","東串良町（肝属郡）","枕崎市","三島村（鹿児島郡）","南大隅町（肝属郡）","南九州市","南さつま市","南種子町（熊毛郡）","屋久島町（熊毛郡）","大和村（大島郡）","湧水町（姶良郡）","与論町（大島郡）","和泊町（大島郡）"];break;
      case '沖縄県':item =["粟国村（島尻郡）","伊江村（国頭郡）","石垣市","伊是名村（島尻郡）","糸満市","伊平屋村（島尻郡）","浦添市","うるま市","大宜味村（国頭郡）","沖縄市","恩納村（国頭郡）","嘉手納町（中頭郡）","北大東村（島尻郡）","北中城村（中頭郡）","金武町（国頭郡）","宜野座村（国頭郡）","宜野湾市","国頭村（国頭郡）","久米島町（島尻郡）","座間味村（島尻郡）","竹富町（八重山郡）","多良間村（宮古郡）","北谷町（中頭郡）","渡嘉敷村（島尻郡）","渡名喜村（島尻郡）","豊見城市","中城村（中頭郡）","今帰仁村（国頭郡）","名護市","那覇市","南城市","西原町（中頭郡）","南風原町（島尻郡）","東村（国頭郡）","南大東村（島尻郡）","宮古島市","本部町（国頭郡）","八重瀬町（島尻郡）","与那国町（八重山郡）","与那原町（島尻郡）","読谷村（中頭郡）"];break;
      default:
        break;
    } setState(() {});
  }
}

/* --- 省略 --- */