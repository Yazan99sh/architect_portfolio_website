import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:shaher_website/Services/mail.dart';
import 'package:shaher_website/UI/Component/ContactMeField.dart';
import 'package:shaher_website/UI/Component/FacebookButton.dart';
import 'package:shaher_website/UI/Component/InstgramButton.dart';
import 'package:shaher_website/UI/Component/SubmitButton.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher_web/url_launcher_web.dart';
class Contact extends StatefulWidget {
  Contact(String screenType);

  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> with TickerProviderStateMixin{
  var message = new TextEditingController();
  // ignore: non_constant_identifier_names
  var Name = new TextEditingController();
  // ignore: non_constant_identifier_names
  var Email = new TextEditingController();
  var subject = new TextEditingController();
  bool msg =false;
  bool eml =false;
  bool nam =false;
  bool sub =false;
  String errorEmail='';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: SelectableText(
                'Get In Touch',
                style: TextStyle(
                  fontFamily: ArabicFonts.Cairo,
                  package: 'google_fonts_arabic',
                  fontSize: 45,
                ),
                textScaleFactor: 1,
              ),
            ),
            Container(
              width: 1200,
              height: 700,
              color: Color.fromRGBO(252, 243, 234, 1),
              child: Row(
                children: [
                  Container(
                    width: 600,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SelectableText(
                          'Contact Me :',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: ArabicFonts.Cairo,
                            package: 'google_fonts_arabic',
                            fontSize: 18,
                          ),
                          textScaleFactor: 1,
                        ),
                        SelectableText(
                          'Tel: +963964346124 - Email: shahersalousi@gmail.com',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: ArabicFonts.Cairo,
                            package: 'google_fonts_arabic',
                            fontSize: 18,
                          ),
                          textScaleFactor: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            width: 500,
                            child: Form(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      ContactMeField(width:240, height:50,hintText:'Name',controller: Name,error: nam,),
                                      Container(width: 10,),
                                      ContactMeField(width:240, height:50,hintText:'Email',controller: Email,error: eml,),
                                    ],
                                  ),
                                  Container(height: 8,),
                                  ContactMeField(width: 500,height: 50,hintText:'Subject',controller: subject,error: sub,),
                                  Container(height: 8,),
                                  ContactMeField(width: 500,hintText:'Type your message here...',maxLine: 4,controller: message,error: msg,),
                                  Container(height: 16,),
                                 SubmitButton((){
                                   check(message.text, Email.text, Name.text, subject.text);
                                 })
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 600,
                    child: ProgressiveImage(
                      height: 700,
                      width: 600,
                      fit: BoxFit.cover,
                      placeholder: AssetImage('images/notfound.jpg'),
                      image: AssetImage('images/contact.jpg'),
                      thumbnail: AssetImage('images/contact.jpg'),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.maxFinite,
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 150, bottom: 100),
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
            ),
          ],
        ),
      ),
    );
  }
  void check(String message, String email, String name,String subject) async {
    if (message =='' || message == null ){
      setState(() {
        msg = true;
      });
    }
    else {
      setState(() {
        msg=false;
      });
    }
    if (name =='' || name == null ){
      setState(() {
        nam = true;
      });
    }
    else {
      setState(() {
        nam=false;
      });
    }
    if (subject =='' || subject == null ){
      setState(() {
        sub = true;
      });
    }
    else {
      setState(() {
        sub=false;
      });
    }
    if (email =='' || email == null ){
      setState(() {
        eml = true;
        errorEmail = "Email Can't be Empty";
      });
    }
    else {
      if(!email.contains('@')){
        setState(() {
          eml = true;
          errorEmail ='Email must Contain a @ ';
        });
      }
      else {
        setState(() {
          eml =false;
        });
      }
    }
    if (!msg && !nam && !eml && !sub){
      bool suc = await sendEmail(message,email,name,subject);
      if (suc){
        Flushbar(
          maxWidth:double.maxFinite,
          flushbarStyle: FlushbarStyle.FLOATING,
          backgroundColor:Colors.green,
          title: 'Response',
          messageText: Text("every thing is good  , enjoy",style:TextStyle(
            color: Colors.white,
          ),textScaleFactor: 1,),
          duration:  Duration(seconds: 3),
        )..show(context);
        reset();
      }
      else {
        Flushbar(
          maxWidth: 825,
          flushbarStyle: FlushbarStyle.FLOATING,
          backgroundColor:Colors.red,
          messageText: Text("Something Went Wrong , Please Try Again",style:TextStyle(
            color: Colors.white,
          ),textScaleFactor: 1,),
          duration:  Duration(seconds: 3),
        )..show(context);
      }
    }
  }

  void reset() {
    setState(() {
      message.clear();
      Name.clear();
      Email.clear();
      subject.clear();
    });
  }
}
