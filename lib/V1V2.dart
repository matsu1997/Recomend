
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'V1V3.dart';


class V1V2 extends StatefulWidget {
  V1V2(this.Select);
  String Select;
  @override
  State<V1V2> createState() => _V1V2State();
}
class _V1V2State extends State<V1V2> {
  @override
  bool aka = true;
  var co = 0;
  var colorbid = 0.01;
  var color = Colors.red;
  var item = [];
  var uid = "";
  void initState() {
    super.initState();
    _loadData();
  }
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(widget.Select,style: TextStyle(fontWeight: FontWeight.bold,color:Colors.black),),
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,  elevation: 0,
          actions: <Widget>[],),
        body:   Container(
            child: Column(children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: item.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {   Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => V1V3(item[index])));},
                    child:Card(
                      shadowColor: Colors.grey[100],
                      elevation: 3,
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Container(child: Row(children: [
                                 Column(children: [
                                Container(child:Text(item[index],style: TextStyle(fontSize:20,fontWeight: FontWeight.bold,color:Colors.black))),
                                    ],),
                              ],),),
                             ],
                        ),),));},),),
              Container(child: Container())
            ]))
    );
  }
  void _loadData()  {
    switch(widget.Select) {
      case '北海道':
        item = ["道央","道南","道北","オホーツク","十勝","釧路・根室"];
        break;
      case '東北':
        item = ["青森県","岩手県","秋田県","宮城県","山形県","福島県"];
        break;
      case '北信越':
        item = ["新潟県","富山県","石川県","福井県","山梨","長野県"];
        break;
      case '関東':
        item = ["栃木県","群馬県","茨城県","埼玉県","東京都","千葉県","神奈川県"];
        break;
      case '東海':
        item = ["岐阜県","静岡県","愛知県","三重県"];
        break;
      case '近畿':
        item = ["滋賀県","京都府","大阪府","兵庫県","奈良県","和歌山県"];
        break;
      case '中国':
        item = ["鳥取県","島根県","岡山県","広島県","山口県"];
        break;
      case '四国':
        item = ["徳島県","香川県","愛媛県","高知県"];
        break;
      case '九州・沖縄':
        item = ["福岡県","佐賀県","長崎県","熊本県","大分県","宮崎県","鹿児島県","沖縄県"];
        break;
      default:
        break;
    } setState(() {});
  }

}