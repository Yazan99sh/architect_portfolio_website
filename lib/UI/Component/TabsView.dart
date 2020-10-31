import 'package:flutter/material.dart';
class TabsView extends StatelessWidget {
  TabsView(
      {Key key,
        @required this.tabIndex,
        @required this.firstTab,
        @required this.secondTab,
        @required this.thirdTab,
        this.hMax
      })
      : super(key: key);
  final hMax;
  final int tabIndex;
  final Widget firstTab;
  final Widget secondTab;
  final Widget thirdTab;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: hMax!=null?hMax:null,
      child: Stack(
        children: <Widget>[
          AnimatedContainer(
            child: firstTab,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            transform: Matrix4.translationValues(
                tabIndex == 0 ? 0 : MediaQuery.of(context).size.width, 0, 0),
            duration: Duration(milliseconds: 300),
            curve: Curves.easeIn,
          ),
          AnimatedContainer(
            child: secondTab,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            transform: Matrix4.translationValues(
                tabIndex == 1 ? 0 : MediaQuery.of(context).size.width, 0, 0),
            duration: Duration(milliseconds: 300),
            curve: Curves.easeIn,
          ),
          AnimatedContainer(
            child: thirdTab ,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            transform: Matrix4.translationValues(
                tabIndex == 2 ? 0 : MediaQuery.of(context).size.width, 0, 0),
            duration: Duration(milliseconds: 300),
            curve: Curves.easeIn,
          ),
        ],
      ),
    );
  }
}