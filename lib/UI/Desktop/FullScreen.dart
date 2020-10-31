import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:shaher_website/UI/Component/Disbutton.dart';

class FullScreen extends StatefulWidget {
  final int initImage;
  final List ads;

  @override
  _FullScreenState createState() => _FullScreenState();

  FullScreen(this.initImage, this.ads);
}

class _FullScreenState extends State<FullScreen> {
  PageController _pageController;
   var opacity=0.3;
  var opacity2=0.3;

  int initImage;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initImage);
    initImage = widget.initImage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height,
                child: PageView(
                  onPageChanged: (index){
                    setState(() {
                      initImage = index ;
                    });
                  },
                  controller: _pageController,
                  children: widget.ads.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return TweenAnimationBuilder(
                          duration: Duration(milliseconds: 1),
                          curve: Curves.easeInCubic,
                          tween: Tween<double>(begin: 0.9, end: 1),
                          child: Hero(
                              tag:
                                  '${i['image'].toString().split('/').last}-tag',
                              child:ProgressiveImage(
                                width:double.maxFinite,
                                height: double.maxFinite,
                                fit: BoxFit.cover,
                                placeholder: AssetImage('images/Example.jpg'),
                                image: NetworkImage('${i['image']}'),
                                thumbnail: NetworkImage('${i['image']}'),
                              )),
                          builder: (context, val, child) {
                            return Opacity(
                              opacity: val,
                              child: child,
                            );
                          },
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: DisButton(onTap:(){
                  Navigator.popAndPushNamed(context, '/ProjectDetails');
                }, icon:Icons.close),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: DisButton(onTap:(){
                  Navigator.pop(context);
                },
                icon: Icons.fullscreen_exit,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: DisButton(
                    onTap:  initImage == 0
                        ? null
                        : () {
                      setState(() {
                        initImage = initImage - 1;
                        _pageController.animateToPage(initImage,
                            duration: Duration(milliseconds: 750),
                            curve: Curves.linear);
                      });
                    },
                    icon:Icons.keyboard_arrow_left,
                    color: initImage == 0 ? Colors.black54 : Colors.black,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Align(
                  alignment: Alignment.centerRight,
                  child:DisButton(
                    color: initImage == widget.ads.length - 1
                        ? Colors.black54
                        : Colors.black,
                    icon: Icons.keyboard_arrow_right,
                    onTap:  initImage == widget.ads.length - 1
                        ? null
                        : () {
                      setState(() {
                        initImage = initImage + 1;
                        _pageController.animateToPage(initImage,
                            duration: Duration(milliseconds: 750),
                            curve: Curves.linear);
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
