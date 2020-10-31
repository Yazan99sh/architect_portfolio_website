import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:progressive_image/progressive_image.dart';
class TabletReview extends StatefulWidget {
  final int initImage;
  final List ads;
  @override
  _TabletReviewState createState() => _TabletReviewState();

  TabletReview(this.initImage, this.ads);
}

class _TabletReviewState extends State<TabletReview> {
  PageController _pageController ;
  int initImage;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initImage);
    initImage = widget.initImage;
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
        body: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width:MediaQuery.of(context).size.width,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child:IconButton(icon:Icon(Icons.reply_rounded,color: Colors.black,),iconSize: 35,splashRadius: 25, onPressed: (){
                      Navigator.of(context).pop();
                    }),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          icon: Icon(
                            Icons.keyboard_arrow_left,
                          ),
                          iconSize: 30,
                          splashRadius: 20,
                          disabledColor:Colors.black54,
                          color: Colors.black,
                          onPressed:initImage==0?null:(){
                            setState(() {
                              initImage = initImage - 1;
                              _pageController.animateToPage(initImage, duration:Duration(milliseconds: 1), curve:Curves.easeIn);
                            });
                          }),
                      Expanded(
                        child: Container(
                          height: 350,
                          child: PageView(
                            onPageChanged: (index){
                              setState(() {
                                initImage = index;
                              });
                            },
                            controller: _pageController,
                            children:widget.ads.map((i) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return TweenAnimationBuilder(
                                    duration: Duration(milliseconds: 450),
                                    curve: Curves.linear,
                                    tween: Tween<double>(begin: 0.0,end: 1),
                                    child: Hero(
                                        tag:'${i['image'].toString().split('/').last}-tag',
                                        child: ProgressiveImage(
                                          width:double.maxFinite,
                                          height: 350,
                                          fit: BoxFit.cover,
                                          placeholder: AssetImage('images/notfound.jpg'),
                                          image: NetworkImage('${i['image']}'),
                                          thumbnail: NetworkImage('${i['image']}'),
                                        )),
                                    builder: (context,val,child){
                                      return Opacity(opacity:val,
                                        child: child,
                                      );
                                    },
                                  );
                                },
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.keyboard_arrow_right,
                          ),
                          iconSize: 30,
                          splashRadius: 20,
                          disabledColor: Colors.black54,
                          color: Colors.black,
                          onPressed:initImage==widget.ads.length-1?null:(){
                            setState(() {
                              initImage = initImage + 1;
                              _pageController.animateToPage(initImage, duration:Duration(milliseconds: 1), curve:Curves.easeIn);
                            });
                          }),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right:55.0,left:55.0,top:16),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom:16.0),
                            child: SelectableText(
                              '${widget.ads[initImage]['ImageTitle']}',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: ArabicFonts.Cairo,
                                  package: 'google_fonts_arabic',
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
                              textScaleFactor: 1,
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: SelectableText(
                            "${widget.ads[initImage]['info']}",
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: ArabicFonts.Cairo,
                                package: 'google_fonts_arabic',
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            //textScaleFactor: 1,
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
