import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:shaher_website/ControlUI/Pages/NewElement.dart';
import 'package:shaher_website/Services/Images.dart';
import 'package:shaher_website/Services/deleteImage.dart';

class ProjectReview extends StatefulWidget {
  final String title;

  ProjectReview(this.title);

  @override
  _ProjectReviewState createState() => _ProjectReviewState();
}

class _ProjectReviewState extends State<ProjectReview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlatButton(
                onPressed: () {
                  Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (context, animation, secondAnimation) {
                        return NewElement(widget.title);
                      },
                      transitionDuration: Duration(milliseconds: 1000),
                      transitionsBuilder:
                          (context, animation, secondAnimation, child) {
                        animation = CurvedAnimation(
                            curve: Curves.easeIn, parent: animation);
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      })).whenComplete(() => setState((){}));
                },
                child: Text(
                  'Create new element',
                  style: TextStyle(
                    fontFamily: ArabicFonts.Cairo,
                    package: 'google_fonts_arabic',
                  ),
                  textScaleFactor: 1,
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlatButton(
                onPressed: () {
                  setState(() {
                  });
                },
                child: Text(
                  'Refresh',
                  style: TextStyle(
                    fontFamily: ArabicFonts.Cairo,
                    package: 'google_fonts_arabic',
                  ),
                  textScaleFactor: 1,
                )),
          ),
        ],
        backgroundColor: Colors.grey[50],
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/UI', (Route<dynamic> route) => false);
              },
              child: Image.asset(
                'images/bf.png',
              )),
        ),
        title: Text(
          'Project Review',
          style: TextStyle(
            fontFamily: ArabicFonts.Cairo,
            package: 'google_fonts_arabic',
          ),
        ),
      ),
      body: Scrollbar(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: 60,
                color: Colors.black,
                child: Center(
                  child: Text(
                    'Images From ${widget.title}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: ArabicFonts.Cairo,
                      package: 'google_fonts_arabic',
                    ),
                    textScaleFactor: 1,
                  ),
                ),
              ),
            ),
            FutureBuilder(
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    width: 65,
                    height: 65,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Container();
                } else {
                  List images = snapshot.data;
                  return Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 16,
                          crossAxisCount: 3,
                          crossAxisSpacing: 16,
                          childAspectRatio: 1),
                      itemCount: images.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          height: 350,
                          child: Column(
                            children: [
                              Container(
                                height: 60,
                                color: Colors.black,
                                child: Stack(
                                  children: [
                                    Center(
                                      child: Text(
                                        '${images[index]['ImageTitle']}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: ArabicFonts.Cairo,
                                          package: 'google_fonts_arabic',
                                        ),
                                        textScaleFactor: 1,
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: 100,
                                          child: FlatButton(
                                              hoverColor: Colors.grey[900],
                                              onPressed: () {
                                                deleteImage(images[index]['image']).whenComplete(() => setState((){}));
                                              },
                                              splashColor: Colors.grey[850],
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.delete,
                                                    color: Colors.white,
                                                  ),
                                                  Container(
                                                    width: 16,
                                                  ),
                                                  Text(
                                                    'Delete',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily:
                                                          ArabicFonts.Cairo,
                                                      package:
                                                          'google_fonts_arabic',
                                                    ),
                                                    textScaleFactor: 1,
                                                  ),
                                                ],
                                              )),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SelectableText(
                                  "${images[index]['info']}",
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
                              Expanded(
                                  child: Image.network(
                                '${images[index]['image']}',
                                fit: BoxFit.cover,
                                width: double.maxFinite,
                              )),
                              Container(
                                height: 60,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
              },
              future: images(widget.title),
            ),
          ],
        ),
      ),
    );
  }
}
