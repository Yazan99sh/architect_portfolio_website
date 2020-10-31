import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:shaher_website/Services/Projects.dart';
import 'package:shaher_website/UI/Component/FacebookButton.dart';
import 'package:shaher_website/UI/Component/InstgramButton.dart';
import 'package:shaher_website/UI/Component/ProjectsCells.dart';
import 'package:shaher_website/responsive/HomeView.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher_web/url_launcher_web.dart';
class MobileHome extends StatefulWidget {
  @override
  _MobileHomeState createState() => _MobileHomeState();
}

class _MobileHomeState extends State<MobileHome> {
  bool hover = false;
  Future projectsData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    projectsData = projects();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ProgressiveImage(
          width: double.maxFinite,
          height:300,
          fit: BoxFit.cover,
          placeholder: AssetImage('images/notfound.jpg'),
          image: AssetImage('images/Example.jpg'),
          thumbnail:AssetImage('images/Example.jpg'),
        ),
        Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 300,
                  width: double.maxFinite,
                  color: Colors.black.withOpacity(0.3),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                            child: SelectableText(
                              'Shaher Salouci',
                              style: TextStyle(
                                  fontFamily: ArabicFonts.Cairo,
                                  package: 'google_fonts_arabic',
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              textScaleFactor: 1,
                            )),
                        Center(
                            child: SelectableText(
                              "Let's Steal The Heaven for you",
                              style: TextStyle(
                                  fontFamily: ArabicFonts.Cairo,
                                  package: 'google_fonts_arabic',
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              textScaleFactor: 1,
                            )),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Colors.grey[50],
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      FutureBuilder(
                        future: projectsData,
                        builder: (context,snapshot){
                          if (snapshot.hasError || snapshot.data==null){
                            return Container();
                          }
                          else{
                            List data = snapshot.data;
                            if (data.length>0)
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 25, bottom: 25),
                                    child: SelectableText(
                                      'My Projects',
                                      style: TextStyle(
                                          fontFamily: ArabicFonts.Cairo,
                                          package: 'google_fonts_arabic',
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                      textScaleFactor: 1,
                                    ),
                                  ),
                                  StaggeredGridView.countBuilder(
                                    primary: false,
                                    physics: ScrollPhysics(),
                                    shrinkWrap: true,
                                    crossAxisCount: 1,
                                    itemCount: data.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return ProjectsCells(data[index],index);
                                    },
                                    staggeredTileBuilder: (int index) =>
                                    new StaggeredTile.count(
                                        1, index.isEven ? 1.2 : 0.8),
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                  ),
                                ],
                              );
                            else return Container();
                          }
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25.0, bottom: 25),
                        child: Container(
                          width: double.maxFinite,
                          child: Column(
                            children: [
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        width: 125,
                                        child: SelectableText(
                                          'My Design Philosophy',
                                          style: TextStyle(
                                              fontFamily: ArabicFonts.Cairo,
                                              package:
                                              'google_fonts_arabic',
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                          textScaleFactor: 1,
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SelectableText(
                                      "Architectural and Urban Design is the elaborate play of public space and spatial space everything comes out of nowhere ...",
                                      style: TextStyle(
                                        fontFamily: ArabicFonts.Cairo,
                                        package: 'google_fonts_arabic',
                                        fontSize: 16,
                                      ),
                                      textScaleFactor: 1,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 16,bottom: 32),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.pushAndRemoveUntil(
                                              context, MaterialPageRoute(
                                              builder: (_) {
                                                return HomeView(
                                                  indexSelect: 2,
                                                );
                                              }),
                                                  (Route<dynamic> route) =>
                                              false);
                                        },
                                        onHover: (hov) {
                                          if (hov) {
                                            setState(() {
                                              hover = true;
                                            });
                                          } else {
                                            setState(() {
                                              hover = false;
                                            });
                                          }
                                        },
                                        child: AnimatedContainer(
                                          width: 125,
                                          height: 45,
                                          decoration: BoxDecoration(
                                            border: hover
                                                ? null
                                                : Border.all(
                                                color: Colors.black,
                                                width: 1),
                                            color: hover
                                                ? Colors.black
                                                : Colors.white,
                                          ),
                                          child: Center(
                                            child: Text(
                                              'Learn More',
                                              style: TextStyle(
                                                  fontFamily:
                                                  ArabicFonts.Cairo,
                                                  package:
                                                  'google_fonts_arabic',
                                                  fontSize: 18,
                                                  color: hover
                                                      ? Colors.white
                                                      : Colors.black),
                                              textScaleFactor: 1,
                                            ),
                                          ),
                                          duration:
                                          Duration(milliseconds: 125),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              ProgressiveImage(
                                width: double.maxFinite,
                                height: 450,
                                fit: BoxFit.cover,
                                placeholder: AssetImage('images/notfound.jpg'),
                                image: AssetImage('images/Baraa.jpg'),
                                thumbnail: AssetImage('images/Baraa.jpg'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 50.0,bottom: 25),
                        child: Container(
                          color: Color.fromRGBO(252, 243, 234, 1),
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 16.0, left: 16, top: 16, bottom: 50),
                                child: Center(
                                  child: SelectableText(
                                    'My Service',
                                    style: TextStyle(
                                        fontFamily: ArabicFonts.Cairo,
                                        package: 'google_fonts_arabic',
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                    textScaleFactor: 1,
                                  ),
                                ),
                              ),
                              ProgressiveImage(
                                width: double.maxFinite,
                                height: 275,
                                fit: BoxFit.cover,
                                placeholder: AssetImage('images/notfound.jpg'),
                                image: AssetImage('images/Citys.jpg'),
                                thumbnail: AssetImage('images/Citys.jpg'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(25.0),
                                child: Container(
                                  child: Center(
                                    child: SelectableText(
                                      'City planning',
                                      style: TextStyle(
                                          fontFamily: ArabicFonts.Cairo,
                                          package: 'google_fonts_arabic',
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                      textScaleFactor: 1,
                                    ),
                                  ),
                                ),
                              ),
                              ProgressiveImage(
                                width: double.maxFinite,
                                height: 275,
                                fit: BoxFit.cover,
                                placeholder: AssetImage('images/notfound.jpg'),
                                image: AssetImage('images/build.jpg'),
                                thumbnail: AssetImage('images/build.jpg'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(25.0),
                                child: Container(
                                  child: Center(
                                    child: SelectableText(
                                      'Architecting',
                                      style: TextStyle(
                                          fontFamily: ArabicFonts.Cairo,
                                          package: 'google_fonts_arabic',
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                      textScaleFactor: 1,
                                    ),
                                  ),
                                ),
                              ),
                              ProgressiveImage(
                                width: double.maxFinite,
                                height: 275,
                                fit: BoxFit.cover,
                                placeholder: AssetImage('images/notfound.jpg'),
                                image: AssetImage('images/Bed.jpg'),
                                thumbnail: AssetImage('images/Bed.jpg'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(25.0),
                                child: Container(
                                  child: Center(
                                    child: SelectableText(
                                      'Home Decoration',
                                      style: TextStyle(
                                          fontFamily: ArabicFonts.Cairo,
                                          package: 'google_fonts_arabic',
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                      textScaleFactor: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: double.maxFinite,
                        child: Center(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 50, bottom: 75),
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
                                        Expanded(
                                            child: FacebookButton()),
                                        Container(
                                          width: 8,
                                        ),
                                        Expanded(
                                            child:InstagramButton()),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: SelectableText(
                                  '©2020 by Yazan Shekh Mohammed. Proudly created with Flutter',
                                  onTap: (){
                                    var url = 'https://yazanshmo.000webhostapp.com/';
                                    launch(url);
                                  },
                                  style: TextStyle(
                                      fontFamily: ArabicFonts.Cairo,
                                      package: 'google_fonts_arabic',
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                  textScaleFactor: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
