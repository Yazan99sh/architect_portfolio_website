import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:shaher_website/ControlUI/Pages/mainControl.dart';
import 'package:shaher_website/Services/Login.dart';
import 'package:shaher_website/UI/Component/ContactMeField.dart';
import 'package:shaher_website/UI/Component/SubmitButton.dart';
class Pass extends StatefulWidget {
  @override
  _PassState createState() => _PassState();
}

class _PassState extends State<Pass> {
var password =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var focus = FocusScope.of(context);
        if (!focus.hasPrimaryFocus) {
          focus.unfocus();
        }
      },
      child: Scaffold(
        body:Center(
          child: Column(
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
                      width: 175,
                      height: 175,
                    )),
              ),
              ContactMeField(width: 500,hintText:'Type the password...',controller: password,obSecure: true,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SubmitButton((){
                  pass();
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
  void pass()async{
    bool p = await login(password.text);
    if (p){
      Navigator.of(context).push(PageRouteBuilder(pageBuilder:(context,animation,secondAnimation){
        return MainControl();
      },
          transitionDuration: Duration(milliseconds: 1000),
          transitionsBuilder: (context,animation,secondAnimation,child){
            animation = CurvedAnimation(curve: Curves.easeIn,parent: animation);
            return FadeTransition(opacity:animation,child: child,);
          }
      ));
    }
    else {
      Flushbar(
        maxWidth: 825,
        flushbarStyle: FlushbarStyle.FLOATING,
        backgroundColor:Colors.red,
        title: 'Warning',
        messageText: Text("You can't pass",style:TextStyle(
          color: Colors.white,
        ),textScaleFactor: 1,),
        duration:  Duration(seconds: 3),
      )..show(context);
    }
  }
}
