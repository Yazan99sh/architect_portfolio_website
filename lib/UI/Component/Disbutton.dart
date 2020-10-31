import 'package:flutter/material.dart';
class DisButton extends StatefulWidget {
  final GestureTapCallback onTap;
  final IconData icon;
  final Color color;
  DisButton({Key key,@required this.onTap,@required this.icon,this.color = Colors.black}) : super (key:key);
  @override
  _DisButtonState createState() => _DisButtonState();
}

class _DisButtonState extends State<DisButton> {
  var opacity =0.1;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:widget.onTap,
      onHover: (hover){
        if(hover){
          setState(() {
            opacity = 1.0;
          });
        }
        else {
          setState(() {
            opacity = 0.1;
          });
        }
      },
      child: Opacity(
        opacity:opacity,
        child: Container(
            width: 75,
            height: 75,
            color: Colors.grey[50],
            child: Center(
                child: Icon(
                  widget.icon,
                  size: 35,
                  color:widget.color,
                ))),
      ),
    );
  }
}
