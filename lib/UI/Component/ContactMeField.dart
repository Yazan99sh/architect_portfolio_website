import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
class ContactMeField extends StatefulWidget {
 final double width;
 final double height;
 final String hintText;
 final int maxLine;
 final bool error;
 final controller;
 final bool obSecure;
 @override
  _ContactMeFieldState createState() => _ContactMeFieldState();

 ContactMeField({Key key,this.error,this.width, this.height,this.hintText,this.maxLine,this.controller,this.obSecure=false}) : super(key:key);
}

class _ContactMeFieldState extends State<ContactMeField> {
  bool hover =false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: InkWell(
        onTap: (){},
        onHover: (hov){
          if (hov){
            setState(() {
              hover =true;
            });
          }
          else {
            setState(() {
              hover =false;
            });
          }
        },
        child: TextFormField(
          obscureText: widget.obSecure,
          enableSuggestions: true,
          controller:widget.controller!=null?widget.controller:null,
          style: TextStyle(
            fontFamily:
            ArabicFonts.Cairo,
            package:
            'google_fonts_arabic',
            fontSize: 18,
            fontWeight: FontWeight.bold
          ),
          cursorColor: Colors.black,
          maxLines: widget.maxLine!=null?widget.maxLine:1,
          decoration: InputDecoration(
            fillColor:Colors.red.withOpacity(0.3),
            filled:widget.error,
            contentPadding:
            EdgeInsets.all(8),
            hintText: '${widget.hintText}',
            hintStyle: TextStyle(
                fontFamily:
                ArabicFonts.Cairo,
                package:
                'google_fonts_arabic',
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18),
            enabledBorder:hover?OutlineInputBorder(
                borderRadius:
                BorderRadius
                    .circular(
                    0),
                borderSide: BorderSide(
                    color: Colors
                        .black)):
            UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Colors
                        .black)),
            focusedBorder:
            OutlineInputBorder(
                borderRadius:
                BorderRadius
                    .circular(
                    0),
                borderSide: BorderSide(
                    color: Colors
                        .black)),

          ),
        ),
      ),
    );
  }
}
