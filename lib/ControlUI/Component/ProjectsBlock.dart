import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:shaher_website/ControlUI/Pages/ProjectReview.dart';
import 'package:shaher_website/Services/delete.dart';
class ProjectsBlock extends StatefulWidget {
 final Map data;
  @override
  _ProjectsBlockState createState() => _ProjectsBlockState();
 ProjectsBlock(this.data);
}

class _ProjectsBlockState extends State<ProjectsBlock> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(bottom:25.0,top: 25,left:MediaQuery.of(context).size.width*0.125,right:MediaQuery.of(context).size.width*0.125),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black)
        ),
        child: Column(
          children: [
            Container(
              height: 60,
              color: Colors.black,
              child: Stack(
                children: [
                  Center(
                    child: Text(
                      '${widget.data['title']}',
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
                    child:Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 100,
                        child: FlatButton(
                            hoverColor: Colors.grey[900],
                            onPressed: () {
                              deleteProject(widget.data['title'],widget.data['image']).whenComplete(() => setState((){}));
                            },
                            splashColor: Colors.grey[850],
                            child:Row(
                              children: [
                                Icon(Icons.delete,color: Colors.white,),
                                Container(width: 16,),
                                Text(
                                  'Delete',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: ArabicFonts.Cairo,
                                    package: 'google_fonts_arabic',
                                  ),
                                  textScaleFactor: 1,
                                ),
                              ],
                            )),
                      ),
                    ) ,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child:Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 100,
                        child: FlatButton(
                            hoverColor: Colors.grey[900],
                            onPressed: () {
                              Navigator.of(context).push(PageRouteBuilder(
                                  pageBuilder: (context, animation, secondAnimation) {
                                    return ProjectReview(widget.data['title']);
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
                                  }));
                            },
                            splashColor: Colors.grey[850],
                            child:Row(
                              children: [
                                Icon(Icons.remove_red_eye,color: Colors.white,),
                                Container(width: 16,),
                                Text(
                                  'Review',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: ArabicFonts.Cairo,
                                    package: 'google_fonts_arabic',
                                  ),
                                  textScaleFactor: 1,
                                ),
                              ],
                            )),
                      ),
                    ) ,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SelectableText(
                "${widget.data['info']}",
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
            ProgressiveImage(
              height: 500,
              width: double.maxFinite,
              fit: BoxFit.cover,
              placeholder: AssetImage('images/notfound.jpg'),
              thumbnail: NetworkImage('${widget.data['image']}'),
              image: NetworkImage('${widget.data['image']}'),
            ),
            Container(
              height: 60,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
