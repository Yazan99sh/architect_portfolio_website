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

class Home extends StatefulWidget {
  final String screenType;

  Home(this.screenType);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
    var space;
    var serviceWidth;
    if (widget.screenType == 'desk' &&
        MediaQuery.of(context).size.width >= 1308) {
      space = 50.0;
      serviceWidth = 450;
    } else if (widget.screenType == 'tab') {
      space = 10;
      serviceWidth = 225;
    } else {
      space = 35;
      serviceWidth = 300;
    }

    return Stack(
      children: [
        ProgressiveImage(
          width: double.maxFinite,
          height: 700,
          fit: BoxFit.cover,
          placeholder: AssetImage('images/Example.jpg'),
          image: AssetImage('images/Example.jpg'),
          thumbnail: AssetImage('images/Example.jpg'),
        ),
        Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 700,
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
                          toolbarOptions: ToolbarOptions(
                            copy: true,
                            selectAll: true
                          ),
                          style: TextStyle(
                              fontFamily: ArabicFonts.Cairo,
                              package: 'google_fonts_arabic',
                              fontSize: 45,
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
                              fontSize: 20,
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
                        builder: (context, snapshot) {
                          if (snapshot.connectionState==ConnectionState.waiting){
                            return Container(
                              height: 65,
                              width: 65,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                          else if (snapshot.hasError || snapshot.data == null) {
                            print(snapshot.error);
                            return Container();
                          } else {
                            List data = snapshot.data;
                            if (data.length > 0)
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 100, bottom: 16),
                                    child: SelectableText(
                                      'My Projects',
                                      style: TextStyle(
                                          fontFamily: ArabicFonts.Cairo,
                                          package: 'google_fonts_arabic',
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold),
                                      textScaleFactor: 1,
                                    ),
                                  ),
                                  StaggeredGridView.countBuilder(
                                    primary: false,
                                    physics: ScrollPhysics(),
                                    shrinkWrap: true,
                                    crossAxisCount: 4,
                                    itemCount: data.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return ProjectsCells(data[index],index);
                                    },
                                    staggeredTileBuilder: (int index) =>
                                        new StaggeredTile.count(
                                            1, index.isEven ? 1.2 : 0.8),
                                    mainAxisSpacing: space,
                                    crossAxisSpacing: space,
                                  ),
                                ],
                              );
                            else
                              return Container();
                          }
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0, bottom: 16),
                        child: Container(
                          width: double.maxFinite,
                          height: 700,
                          child: Row(
                            children: [
                              Container(
                                width:
                                    (MediaQuery.of(context).size.width * 0.5) -
                                        32,
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
                                            width: 125,
                                            child: SelectableText(
                                              'My Design Philosophy',
                                              style: TextStyle(
                                                  fontFamily: ArabicFonts.Cairo,
                                                  package:
                                                      'google_fonts_arabic',
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold),
                                              textScaleFactor: 1,
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(0.0),
                                        child: Container(
                                          width: 500,
                                          child: SelectableText(
                                            "Architectural and Urban Design is the elaborate play of public space and spatial space everything comes out of nowhere ...",
                                            style: TextStyle(
                                              fontFamily: ArabicFonts.Cairo,
                                              package: 'google_fonts_arabic',
                                              fontSize: 18,
                                            ),
                                            textScaleFactor: 1,
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 35),
                                        child: Container(
                                          width: 500,
                                          child: Align(
                                            alignment: Alignment.centerLeft,
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
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                  ProgressiveImage(
                    width: (MediaQuery.of(context).size.width * 0.5) -
                        32,
                    height: 700,
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
                        padding: const EdgeInsets.only(top: 50.0),
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
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold),
                                    textScaleFactor: 1,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child:ProgressiveImage(
                                        width: double.maxFinite,
                                        height: serviceWidth,
                                        fit: BoxFit.cover,
                                        placeholder: AssetImage('images/notfound.jpg'),
                                        image: AssetImage('images/Citys.jpg'),
                                        thumbnail: AssetImage('images/Citys.jpg'),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          right: 16.0,
                                          left: 16,
                                        ),
                                        child:ProgressiveImage(
                                          width: double.maxFinite,
                                          height: serviceWidth,
                                          fit: BoxFit.cover,
                                          placeholder: AssetImage('images/notfound.jpg'),
                                          image: AssetImage('images/build.jpg'),
                                          thumbnail: AssetImage('images/build.jpg'),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: ProgressiveImage(
                                        width: double.maxFinite,
                                        height: serviceWidth,
                                        fit: BoxFit.cover,
                                        placeholder: AssetImage('images/notfound.jpg'),
                                        image: AssetImage('images/Bed.jpg'),
                                        thumbnail: AssetImage('images/Bed.jpg'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    Expanded(
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
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          right: 16.0,
                                          left: 16,
                                        ),
                                        child: Container(
                                          child: Center(
                                            child: SelectableText(
                                              'Architecting',
                                              style: TextStyle(
                                                  fontFamily: ArabicFonts.Cairo,
                                                  package:
                                                      'google_fonts_arabic',
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                              textScaleFactor: 1,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
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
                              Container(
                                height: 66,
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
