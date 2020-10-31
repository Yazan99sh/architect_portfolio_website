import 'package:flutter/material.dart';
import 'package:shaher_website/Services/Images.dart';
import 'package:shaher_website/UI/Desktop/EmptyElements.dart';
import 'package:shaher_website/UI/Desktop/ProjectDetails.dart';
import 'package:shaher_website/responsive/ScreenTypeLayout.dart';
import '../main.dart';
import 'OrientationLayout.dart';
class ProjectView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = selected.getData();
    return FutureBuilder(builder:(context,snapshot){
      if (snapshot.connectionState==ConnectionState.waiting){
        return Container(
          width: 65,
          height: 65,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
      else if (snapshot.hasError){
        return Container();
      }
      else {
        List images = snapshot.data;
        if (images.length>0)
          return ScreenTypeLayout(
            mobile: OrientationLayout(portrait:ProjectDetails('tablet',images),landscape: ProjectDetails('tablet',images)),
            tablet:ProjectDetails('tablet',images),
            desktop:ProjectDetails('Desktop',images),
          );
        else {
          return EmptyElements() ;
        }
      }
    },future:images(data['title']),);

  }
}
