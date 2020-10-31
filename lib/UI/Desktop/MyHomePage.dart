import 'dart:html';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:shaher_website/ControlUI/Pages/Pass.dart';
import 'package:shaher_website/UI/Desktop/About.dart';
import 'package:shaher_website/UI/Desktop/Contact.dart';
import 'package:shaher_website/UI/Desktop/Home.dart';
import 'package:shaher_website/UI/Tablet/TabletAbout.dart';
import 'package:shaher_website/UI/Tablet/TabletContact.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class MyHomePage extends StatefulWidget {
  final int select;
  final String screenType;
  @override
  _MyHomePageState createState() => _MyHomePageState();
  MyHomePage({Key key,this.select,this.screenType}) : super(key:key);
}
class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  var hMax;
  int currentIndex = 0;
  bool hover = false;
  ScrollController _scrollController;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    if (widget.select != null) {
      setState(() {
        currentIndex = widget.select;
      });
    }
    _tabController =
        TabController(length: 3, initialIndex: currentIndex, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var focus = FocusScope.of(context);
        if (!focus.hasPrimaryFocus) {
          focus.unfocus();
        }
      },
      child: Scaffold(
        body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                snap: true,
                floating: true,
                pinned: false,
                backgroundColor: Colors.grey[50],
                expandedHeight: 95,
                flexibleSpace: Row(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: InkWell(
                                onDoubleTap: (){
                                  secretPath();
                                },
                                  onTap: () {
                                    Navigator.pushNamedAndRemoveUntil(context, '/UI',(Route<dynamic> route) => false);
                                  },
                                  child: Image.asset(
                                    'images/bf.png',
                                    width: 75,
                                    height: 75,
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left:8.0),
                              child: Container(
                                width: 150,
                                child: SelectableText(
                                  'Shaher Salouci Architect & Designer',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: ArabicFonts.Cairo,
                                      package: 'google_fonts_arabic',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  //textScaleFactor: 1,
                                  minLines: 2,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Container(
                            width: 300,
                            child: TabBar(
                                controller: _tabController,
                                onTap: (index) {
                                  setState(() {
                                    currentIndex = index;
                                  });
                                },
                                indicator: DotIndicator(
                                  color: Colors.black,
                                  distanceFromCenter: 16,
                                  radius: 3,
                                  paintingStyle: PaintingStyle.fill,
                                ),
                                indicatorColor: Colors.black,
                                labelStyle: TextStyle(
                                  fontFamily: ArabicFonts.Cairo,
                                  package: 'google_fonts_arabic',
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                                tabs: [
                                  Tab(
                                    text: 'Home',
                                  ),
                                  Tab(
                                    text: 'Contact',
                                  ),
                                  Tab(
                                    text: 'About',
                                  ),
                                ]),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ];
          },
          body: Padding(
            padding: const EdgeInsets.only(right: 16, left: 16),
            child: TabBarView(
              children: <Widget>[
                Home(widget.screenType),
               widget.screenType=='desk'&& MediaQuery.of(context).size.width>=1236?Contact(widget.screenType):TabletContact(widget.screenType),
                widget.screenType=='desk'?About(widget.select!=null?widget.select:-1,widget.screenType):TabletAbout(widget.select!=null?widget.select:-1,widget.screenType)
              ],
              controller: _tabController,
            ),
          ),
        ),
      ),
    );
  }

  void secretPath(){
    var alertDialog = AlertDialog(
      title: Text('Warning!',textScaleFactor: 1,style: TextStyle(
       color: Colors.white,
        fontFamily: ArabicFonts.Cairo,
        package: 'google_fonts_arabic',
      ),),
      backgroundColor: Colors.red,
      content:Text('You are walking into forbidden section in the website it is just authorized  for the owner ',textScaleFactor: 1,style: TextStyle(
        color: Colors.white,
        fontFamily: ArabicFonts.Cairo,
        package: 'google_fonts_arabic',
      ),),
      actions: [
        FlatButton(onPressed: (){
          Navigator.of(context).push(PageRouteBuilder(pageBuilder:(context,animation,secondAnimation){
            return Pass();
          },
              transitionDuration: Duration(milliseconds: 1000),
              transitionsBuilder: (context,animation,secondAnimation,child){
                animation = CurvedAnimation(curve: Curves.easeIn,parent: animation);
                return FadeTransition(opacity:animation,child: child,);
              }
          ));
        }, child:Text('Pass',textScaleFactor: 1,style: TextStyle(
          color: Colors.white,
          fontFamily: ArabicFonts.Cairo,
          package: 'google_fonts_arabic',
        ),),),
        FlatButton(onPressed: ()=>Navigator.pop(context), child:Text('Close',textScaleFactor: 1,style: TextStyle(
          color: Colors.white,
          fontFamily: ArabicFonts.Cairo,
          package: 'google_fonts_arabic',
        ),),),
      ],
    );
    showDialog(context: context,builder: (context)=>alertDialog);
  }

}
