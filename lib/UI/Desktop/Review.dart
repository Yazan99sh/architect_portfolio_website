import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:shaher_website/UI/Desktop/FullScreen.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;
class Review extends StatefulWidget {
  final int initImage;
  final List ads;
  @override
  _ReviewState createState() => _ReviewState();

  Review(this.initImage, this.ads);
}

class _ReviewState extends State<Review> {
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
        body: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left:16,top: 50),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            IconButton(
                                icon: Icon(
                                  Icons.fullscreen,
                                  color: Colors.black,
                                ),
                                iconSize: 35,
                                onPressed:(){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context){return FullScreen(initImage,widget.ads);}),);
                                }),
                            Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: IconButton(
                                  icon: Icon(
                                    Icons.download_rounded,
                                    color: Colors.black,
                                  ),
                                  iconSize: 30,
                                  onPressed: (){
                                    js.context.callMethod("open",["https://shahersalousi.000webhostapp.com/Shaher/download.php?image=${widget.ads[initImage]['image']}"]);
                                  }),
                            )
                          ],
                        )),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: IconButton(
                              icon: Icon(
                                Icons.close,
                                color: Colors.black,
                              ),
                              iconSize: 30,
                              onPressed: (){
                                Navigator.of(context).pop();
                              }),
                        )),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            icon: Icon(
                              Icons.keyboard_arrow_left,
                            ),
                            iconSize: 30,
                            disabledColor:Colors.black54,
                            color: Colors.black,
                            onPressed:initImage==0?null:(){
                              setState(() {
                                initImage = initImage - 1;
                                _pageController.animateToPage(initImage, duration:Duration(milliseconds: 1), curve:Curves.easeIn);
                              });
                            }),
                        Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: SizedBox(
                            width:MediaQuery.of(context).size.width*0.45,
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
                                            width:MediaQuery.of(context).size.width*0.45,
                                            height: 700,
                                            fit: BoxFit.cover,
                                            placeholder: AssetImage('images/notfound.jpg'),
                                            image: NetworkImage('${i['image']}'),
                                            thumbnail: NetworkImage('${i['image']}'),
                                          ),),
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
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          width:250,
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
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
