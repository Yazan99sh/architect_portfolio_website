import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:shaher_website/Services/NewImage.dart';
import 'package:shaher_website/UI/Component/ContactMeField.dart';
import 'package:shaher_website/UI/Component/SubmitButton.dart';
class NewElement extends StatefulWidget {
  final String title;
  @override
  _NewElementState createState() => _NewElementState();

  NewElement(this.title);
}

class _NewElementState extends State<NewElement> {
  var title = new TextEditingController();
  var info = new TextEditingController();
  bool tit = false;
  bool inf = false;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Center(
            child:loading?Container(
              width: double.maxFinite,
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: Container(
                  width: 65,
                  height: 65,
                  child: CircularProgressIndicator(),
                ),
              ),
            ):Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: InkWell(
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(context, '/UI',(Route<dynamic> route) => false);
                      },
                      child: Image.asset(
                        'images/bf.png',
                        width: 150,
                        height: 150,
                      )),
                ),
                ContactMeField(width: 500,hintText:'Image Title',controller:title,error: tit,),
                Container(height: 16,),
                ContactMeField(width: 500,hintText:'Image Extra Info...',maxLine: 6,controller: info,error: inf,),
                Container(height: 16,),
                Container(height: 16,),
                Container(
                  decoration: BoxDecoration(
                      border:Border.all(color: Colors.black)
                  ),
                  width: 500,
                  height: 350,
                  child:Center(
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        !handled?IconButton(icon: Icon(Icons.add_circle),onPressed:(){
                          handleFile();
                        },):Icon(Icons.check_circle,color: Colors.green,),
                        Container(height: 16,),
                        Text('Select new Image',style: TextStyle(
                            fontFamily:
                            ArabicFonts.Cairo,
                            package:
                            'google_fonts_arabic',
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),textScaleFactor: 1,),
                      ],
                    ),
                  ),
                ),
                Container(height:25,),
                SubmitButton((){
                  setState(() {
                    loading =true;
                  });
                  check(file, title.text, info.text).whenComplete(() => setState((){
                    loading = false;
                  }));
                }),
                Container(height: 50,),
              ],
            ),
          ),
        ),
      ),
    );
  }
  PlatformFile  file;
  bool handled = false;
  File tempFile;
  Future handleFile()async{
    FilePickerResult result = await FilePicker.platform.pickFiles(type: FileType.image ,allowedExtensions:['jpg','png']);
    if(result != null) {
      setState(() {
        file = result.files.first;
        handled = true;
      });
    }
  }
  Future check(PlatformFile file, String title , String info)async{
    if (title =='' || title == null ){
      setState(() {
        tit = true;
      });
    }
    else {
      setState(() {
        tit=false;
      });
    }
    if (info =='' || info == null ){
      setState(() {
        inf = true;
      });
    }
    else {
      setState(() {
        inf=false;
      });
    }
    if (file==null){
      setState(() {
        handled = false;
      });
    }
    else {
      setState(() {
        handled=true;
      });
    }
    if (!tit && !inf && handled){
      bool suc = await newImage(title,info,file,widget.title);
      if (suc){
        setState(() {
          loading = false;
        });
        Flushbar(
          maxWidth:double.maxFinite,
          flushbarStyle: FlushbarStyle.FLOATING,
          backgroundColor:Colors.green,
          title: 'Response',
          messageText: Text("every thing is good,enjoy",style:TextStyle(
            color: Colors.white,
          ),textScaleFactor: 1,),
          duration:  Duration(seconds: 3),
        )..show(context).whenComplete((){
          Navigator.of(context).pop();
        });
      }
      else {
        setState(() {
          loading = false;
        });
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
}
