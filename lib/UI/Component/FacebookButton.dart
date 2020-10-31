import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher_web/url_launcher_web.dart';
class FacebookButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          var url = 'https://www.facebook.com/bara.sa.97';
          launch(url);
        },
        child: Image.asset(
          'images/otherAsset/facebook.png',
          color: Colors.black,
          width: 25,
          height: 25,
        ));
  }
}
