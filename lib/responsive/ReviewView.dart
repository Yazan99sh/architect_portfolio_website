import 'package:flutter/material.dart';
import 'package:shaher_website/UI/Desktop/Review.dart';
import 'package:shaher_website/UI/Tablet/TabletReview.dart';
import 'OrientationLayout.dart';
import 'ScreenTypeLayout.dart';
class ReviewView extends StatelessWidget {
  final index;
  final List ads;
  ReviewView(this.index, this.ads);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(portrait:TabletReview(index,ads),landscape: TabletReview(index,ads)),
      tablet:TabletReview(index,ads),
      desktop:Review(index,ads),
    );
  }
}
