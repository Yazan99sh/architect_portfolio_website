import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:shaher_website/UI/Component/SubmitButton.dart';
class EmptyElements extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        child:Center(
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("This Project doesn't contain any elements or material yet , Please check it later ",style: TextStyle(
                  fontSize: 35,
                  color: Colors.black,
                  fontFamily: ArabicFonts.Cairo,
                  package: 'google_fonts_arabic',
                ),textScaleFactor: 1,),
              ),
              SubmitButton((){
                Navigator.pushNamedAndRemoveUntil(context, '/UI',(Route<dynamic> route) => false);
              },label:'Go Back Home'),
            ],
          ),
        ),
      ),
    );
  }
}
