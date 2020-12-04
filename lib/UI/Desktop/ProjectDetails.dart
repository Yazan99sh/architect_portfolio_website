import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:shaher_website/UI/Component/ProjectDetElements.dart';
import 'package:shaher_website/main.dart';

class ProjectDetails extends StatefulWidget {
  final String screenType;
  final List images;
  ProjectDetails(this.screenType,this.images);

  @override
  _ProjectDetailsState createState() => _ProjectDetailsState();
}
class _ProjectDetailsState extends State<ProjectDetails> {
  ScrollController _scrollController;
  ScrollController _scrollController2;
  double off = 0.0;
  bool arrows=true;
  var data=selected.getData();
  var projectNumber=selected.getSelectTapped()+1;
  var initImage;
  var message='';
Future ft = Future((){});
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(initialScrollOffset: off);
    _scrollController.addListener(() {
        off = _scrollController.offset;
        if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
            !_scrollController.position.outOfRange) {
          setState(() {
            message = "reach the bottom";
          });
        }
        if (_scrollController.offset <= _scrollController.position.minScrollExtent &&
            !_scrollController.position.outOfRange) {
          setState(() {
            message = "reach the top";
          });
        }
        print(message);
    });
    _scrollController2 = ScrollController(initialScrollOffset: 800);
    WidgetsBinding.instance.addPostFrameCallback((_){
      //write or call your logic
      //code will run when widget rendering complete
ft = ft.then((_){
  return Future.delayed(Duration(milliseconds: 250));
});
_scrollController2.animateTo(
    0, duration: Duration(milliseconds: 1000), curve: Curves.easeIn);
    });
    if (selected.getSelectIndex() !=-1){
      initImage = selected.getSelectIndex();
    }
    else {
      initImage = 0;
    }
    pageController = PageController(initialPage: initImage);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _scrollController2.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var cellSize;
    var cellOSize;
    var pad;
    if (widget.screenType == 'Desktop'){
cellSize= 6.5;
cellOSize=13;
pad = 50;
    }
    else if (widget.screenType=='tablet'){
      cellSize = 9.85;
      cellOSize =9.85;
      pad = 25;
    }
    else {
      cellSize =9.85;
      cellOSize=9.85;
      pad=16;
    }
    return MouseRegion(
      onHover: (event){
        if (event.kind==PointerDeviceKind.mouse){
            arrows = true;
        }
        else {
          arrows = false;
        }
      },
      child: GestureDetector(
        onTap: () {
          var focus = FocusScope.of(context);
          if (!focus.hasPrimaryFocus) {
            focus.unfocus();
          }
        },
        child: Scaffold(
          backgroundColor: Colors.grey[50],
          body: Scrollbar(
            child: SingleChildScrollView(
              controller: _scrollController2,
              child:Column(
                children: [
                  Container(
                    width: double.maxFinite,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(left: pad),
                            child: InkWell(
                              onTap: (){
                                Navigator.pushNamedAndRemoveUntil(context, '/UI',(Route<dynamic> route) => false);
                              },
                              child: Image.asset(
                                'images/bf.png',
                                width: 75,
                                height: 75,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
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
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                  ),
                  Padding(
                    padding:  EdgeInsets.all(pad),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SelectableText(
                                'Project $projectNumber',
                                style: TextStyle(
                                    fontSize: 30,
                                    fontFamily: ArabicFonts.Cairo,
                                    package: 'google_fonts_arabic',
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                textScaleFactor: 1,
                                textAlign: TextAlign.left,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 25,
                                ),
                                child: SelectableText(
                                  "${data['title']}",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: ArabicFonts.Cairo,
                                      package: 'google_fonts_arabic',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  //textScaleFactor: 1,
                                  minLines: 2,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              SelectableText(
                                "${data['info']}",
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
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.all(pad),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 650,
                      child:widget.screenType=='Desktop'?gridViewApproach(context,cellSize,cellOSize):pageViewApproach(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget gridViewApproach(context,cellSize,cellOSize){
    return Stack(
      children: [
        StaggeredGridView.countBuilder(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          //primary: false,
          crossAxisCount: widget.images.length,
          itemCount:widget.images.length,
          itemBuilder: (BuildContext context, int index) {
            return ProjectDetElements(index,widget.images);
          },
          staggeredTileBuilder: (int index) =>
          new StaggeredTile.count(
            widget.images.length,widget.images.length),
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
        ),
        arrows
            ? Padding(
          padding: const EdgeInsets.all(30.0),
          child: Row(
            children: [
              off > 0.0
                  ? Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 30,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        _scrollController.animateTo(
                            off -
                                MediaQuery.of(context)
                                    .size
                                    .width,
                            duration: Duration(
                                milliseconds: 1000),
                            curve: Curves.easeIn);
                        setState(() {
                          off = off -
                              MediaQuery.of(context)
                                  .size
                                  .width;
                        });
                      },
                    ),
                  ))
                  : Container(),
              message!="reach the bottom"
                  ? Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        size: 30,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        _scrollController.animateTo(
                            off +
                                MediaQuery.of(context)
                                    .size
                                    .width,
                            duration: Duration(
                                milliseconds: 1000),
                            curve: Curves.easeIn);
                        setState(() {
                          off = off +
                              MediaQuery.of(context)
                                  .size
                                  .width;
                        });
                      },
                    ),
                  ))
                  : Container(),
            ],
          ),
        )
            : Container(),
      ],
    );
  }
  var pageController ;
  Widget pageViewApproach(context){
    return PageView.builder(
        controller:pageController,
        onPageChanged: (index){
          setState(() {
            initImage = index ;
          });
        },
        itemCount: widget.images.length,
        itemBuilder:(context,index){
          return Stack(children:[
            ProjectDetElements(initImage,widget.images),
            Center(
              child: Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: IconButton(icon:Icon(Icons.keyboard_arrow_left),color:Colors.white,disabledColor:Colors.black54,onPressed:initImage==0?null:(){
                          setState(() {
                            initImage = initImage -1;
                            pageController.animateToPage(initImage, duration:Duration(milliseconds: 450), curve:Curves.easeIn);
                          });
                        },
                          iconSize: 35,),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: IconButton(icon:Icon(Icons.keyboard_arrow_right),color:Colors.white,disabledColor:Colors.black54,onPressed:initImage==widget.images.length-1?null:(){
                          setState(() {
                            initImage = initImage +1;
                            pageController.animateToPage(initImage, duration:Duration(milliseconds: 450), curve:Curves.easeIn);
                          });
                        },iconSize: 35,),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ]);
        });
  }
}
