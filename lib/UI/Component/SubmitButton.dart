import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
class SubmitButton extends StatefulWidget {
  final GestureTapCallback onTap;
  final String label;
  SubmitButton(this.onTap,{Key key ,this.label}):super(key:key);

  @override
  _SubmitButtonState createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> with TickerProviderStateMixin {
  double opacity = 1;
  AnimationController _animationController;
  Animation<double> _animationOpacity;
  String l;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(duration:Duration(milliseconds: 350),vsync: this);
    _animationOpacity =Tween<double>(begin:1 ,end: 0.5).animate(_animationController);
    if (widget.label!=null){
      l=widget.label;
    }
    else {
      l='Submit';
    }
  }
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation:_animationController,
      builder: (context,_){
        return InkWell(
          onTap:widget.onTap,
          onHover: (hover){
            if (hover){
              _animationController.forward();
            }
            else {
              _animationController.reverse();
            }
          },
          child: Container(
            width: 500,
            height: 60,
            color: Colors.black.withOpacity(_animationOpacity.value),
            child: Center(
              child: Text(
                '$l',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: ArabicFonts.Cairo,
                    package: 'google_fonts_arabic',
                    fontSize: 18,
                    color: Colors.white
                ),
                textScaleFactor: 1,
              ),
            ),
          ),
        );
      },
    );
  }
}
