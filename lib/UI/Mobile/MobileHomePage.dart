import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:shaher_website/UI/Desktop/Contact.dart';
import 'package:shaher_website/UI/Mobile/MobileAbout.dart';
import 'package:shaher_website/UI/Mobile/MobileHome.dart';
import 'package:shaher_website/UI/Tablet/TabletContact.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
class MobileHomePage extends StatefulWidget {
  final int select;
  final String screenType;
  MobileHomePage({Key key,this.select,this.screenType}) : super(key:key);
  @override
  _MobileHomePageState createState() => _MobileHomePageState();
}

class _MobileHomePageState extends State<MobileHomePage> with TickerProviderStateMixin {
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
                pinned: true,
                backgroundColor: Colors.grey[50],
                expandedHeight: 95,
                centerTitle: true,
                title: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(top:25.0),
                    child: SelectableText(
                      'Architect & Designer',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: ArabicFonts.Cairo,
                          package: 'google_fonts_arabic',
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      //textScaleFactor: 1,
                      minLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                leading: Padding(
                  padding: const EdgeInsets.only(left:16.0),
                  child: InkWell(
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(context, '/UI',(Route<dynamic> route) => false);
                      },
                      child: Image.asset(
                        'images/bf.png',
                        width: 60,
                        height: 60,
                      )),
                ),
             bottom: TabBar(
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
            ];
          },
          body: TabBarView(
            children: <Widget>[
             MobileHome(),
              widget.screenType=='desk'&& MediaQuery.of(context).size.width>=1236?Contact(widget.screenType):TabletContact(widget.screenType),
            MobileAbout(widget.select!=null?widget.select:-1)
            ],
            controller: _tabController,
          ),
        ),
      ),
    );
  }
}
