import 'package:flutter/material.dart';
import 'package:shaher_website/UI/Desktop/MyHomePage.dart';
import 'package:shaher_website/UI/Mobile/MobileHomePage.dart';
import 'OrientationLayout.dart';
import 'ScreenTypeLayout.dart';
class HomeView extends StatelessWidget {
  final int indexSelect;
  HomeView({Key key,this.indexSelect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (indexSelect != null)
    return ScreenTypeLayout(
        mobile: OrientationLayout(portrait: MobileHomePage(select: indexSelect,screenType: 'Mobile'),landscape: MyHomePage(select: indexSelect,screenType: 'Mobile')),
    tablet:MyHomePage(select: indexSelect,screenType: 'tab'),
      desktop:MyHomePage(select: indexSelect,screenType: 'desk'),
    );
    else
      return ScreenTypeLayout(

     mobile: OrientationLayout(portrait: MobileHomePage(),landscape: MyHomePage(screenType: 'tab',),
     ),
     tablet:OrientationLayout(portrait:MobileHomePage() ,landscape:MyHomePage(screenType: '',)),
        desktop:MyHomePage(screenType: 'desk',),);
  }
}