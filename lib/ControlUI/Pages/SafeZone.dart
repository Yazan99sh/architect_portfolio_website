import 'package:flutter/material.dart';
class SafeZone extends StatefulWidget {
  @override
  _SafeZoneState createState() => _SafeZoneState();
}

class _SafeZoneState extends State<SafeZone> {
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      //write or call your logic
      //code will run when widget rendering complete
      Navigator.pushNamedAndRemoveUntil(context, '/UI',(Route<dynamic> route) => false);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
