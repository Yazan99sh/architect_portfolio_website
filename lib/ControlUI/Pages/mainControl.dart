import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:shaher_website/ControlUI/Component/ProjectsBlock.dart';
import 'package:shaher_website/ControlUI/Pages/NewProject.dart';
import 'package:shaher_website/Services/Projects.dart';

class MainControl extends StatefulWidget {
  @override
  _MainControlState createState() => _MainControlState();
}

class _MainControlState extends State<MainControl> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
                        return NewProject();
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
                  'Create new project',
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'Logout',
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
          'Main Control Panel',
          style: TextStyle(
            fontFamily: ArabicFonts.Cairo,
            package: 'google_fonts_arabic',
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 60,
              color: Colors.black,
              child: Center(
                child: Text(
                  'Projects',
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
              future:projects(),
              builder:(context,snapshot){
                if (snapshot.connectionState==ConnectionState.waiting){
                 return Container(
                    width: double.maxFinite,
                    height:MediaQuery.of(context).size.height-120,
                    child:Center(
                      child: Container(
                          width: 65,
                          height: 65,
                          child: CircularProgressIndicator()),
                    ),
                  );
                }
                else {
                  List data = snapshot.data;
                  return ListView.builder(itemBuilder: (context, index) {
                    return ProjectsBlock(data[index]);
                  },
                    itemCount: data.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),);
                }
              }),
        ],
      ),
    );
  }
}
