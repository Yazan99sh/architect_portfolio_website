import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:shaher_website/UI/Component/FacebookButton.dart';
import 'package:shaher_website/UI/Component/InstgramButton.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher_web/url_launcher_web.dart';
class About extends StatefulWidget {
  final int index;
  final String screenType;

  About(this.index, this.screenType);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> with TickerProviderStateMixin {
  ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController(
      initialScrollOffset: 0.0,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //write or call your logic
      //code will run when widget rendering complete
      Future.delayed(Duration(seconds: 1)).whenComplete(() {
        if (widget.index != -1) {
          _controller.animateTo(800,
              duration: Duration(milliseconds: 1000), curve: Curves.easeIn);
        }
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child:ProgressiveImage(
            width: MediaQuery.of(context).size.width,
            height: 750,
            fit: BoxFit.cover,
            placeholder: AssetImage('images/notfound.jpg'),
            image: AssetImage('images/Baraa.jpg'),
            thumbnail: AssetImage('images/Baraa.jpg'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 0),
          child: Scrollbar(
            child: SingleChildScrollView(
              primary: widget.index == -1 ? true : false,
              controller: widget.index != -1 ? _controller : null,
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 750,
                    child: Center(
                      child: SelectableText(
                        'Shaher Salouci',
                        style: TextStyle(
                            fontSize: 45,
                            fontFamily: ArabicFonts.Cairo,
                            package: 'google_fonts_arabic',
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                        textScaleFactor: 1,
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.grey[50],
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Container(
                          height: 75,
                        ),
                        Container(
                          width: double.maxFinite,
                          child: Row(
                            children: [
                              Expanded(
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 500,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            width: 300,
                                            child: SelectableText(
                                              'My Design Philosophy',
                                              style: TextStyle(
                                                  fontFamily: ArabicFonts.Cairo,
                                                  package:
                                                      'google_fonts_arabic',
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold),
                                              textScaleFactor: 1,
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 500,
                                        child: SelectableText(
                                          "Architectural and Urban Design is the elaborate play of public space and spatial space everything comes out of nowhere everything has a destiny and a place in emptiness It is mastered play with volumes under the light He is everything capable of bringing out the beauty of my place The simplest way to reach A large void can hold a smaller void The spatial relationship results from the superposition of an area of ​​its dimensions, and a region of the common space emerges from that Architecture is everything that comes out of nowhere The design comes from an accommodating place and comfortable movement through it In my opinion, a designer and a human being It should contain the convenience features of convenience within the economy We must put ourselves as the customer to serve him and deliver the design idea for his psychological and practical comfort, not to be limited to the profit and personal benefit thinking We can say that knowing is knowledge of existence in the end thanks for reading and spend your precious time in my website.",
                                          style: TextStyle(
                                            fontFamily: ArabicFonts.Cairo,
                                            package: 'google_fonts_arabic',
                                            fontSize: 18,
                                          ),
                                          textScaleFactor: 1,
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child:ProgressiveImage(
                                  width: double.maxFinite,
                                  height: 700,
                                  fit: BoxFit.cover,
                                  placeholder: AssetImage('images/notfound.jpg'),
                                  image: AssetImage('images/5.jpg'),
                                  thumbnail: AssetImage('images/5.jpg'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 75,
                        ),
                        Container(
                          width: double.maxFinite,
                          child: Center(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 150, bottom: 100),
                                  child: Divider(
                                    color: Colors.black,
                                    thickness: 1.5,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Container(
                                      width: 75,
                                      child: Row(
                                        children: [
                                          Expanded(child: FacebookButton()),
                                          Container(
                                            width: 8,
                                          ),
                                          Expanded(child: InstagramButton()),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: SelectableText(
                                    '©2020 by Yazan Shekh Mohammed. Proudly created with Flutter',
                                    onTap: () {
                                      var url =
                                          'https://yazanshmo.000webhostapp.com/';
                                      launch(url);
                                    },
                                    style: TextStyle(
                                        fontFamily: ArabicFonts.Cairo,
                                        package: 'google_fonts_arabic',
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                    textScaleFactor: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
