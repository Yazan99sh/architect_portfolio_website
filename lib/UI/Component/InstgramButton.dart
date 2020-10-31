import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher_web/url_launcher_web.dart';
class InstagramButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          var url = 'https://www.instagram.com/baraa_m_sa/';
          launch(url);
        },
        child: Image.asset(
          'images/otherAsset/instagram.png',
          color: Colors.black,
          width: 25,
          height: 25,
        ));
  }
}
