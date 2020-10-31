import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:shaher_website/main.dart';
import 'package:shaher_website/responsive/ReviewView.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;
class ProjectDetElements extends StatefulWidget {
  final int index;
  final List ads;
  @override
  _ProjectDetElementsState createState() => _ProjectDetElementsState();

  ProjectDetElements(this.index,this.ads);
}

class _ProjectDetElementsState extends State<ProjectDetElements> {
  bool hover =false;
  AudioCache _audioCache;
  @override
  void initState() {
    super.initState();
    // create this only once
    _audioCache = AudioCache(prefix: "audio/", fixedPlayer: AudioPlayer()..setReleaseMode(ReleaseMode.STOP));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        setState(() {
          selected.setIndex(widget.index);
        });
        Navigator.of(context).push(PageRouteBuilder(pageBuilder:(context,animation,secondAnimation){
          return ReviewView(widget.index,widget.ads);
        },
        transitionDuration: Duration(milliseconds: 1000),
          transitionsBuilder: (context,animation,secondAnimation,child){
          animation = CurvedAnimation(curve: Curves.easeIn,parent: animation);
return FadeTransition(opacity:animation,child: child,);
          }
        ));
      },
      onHover: (hov){
        if (hov){
          try{
            _audioCache.play('zapsplat_sound_design_whoosh_short_deep_54865.mp3');
          }catch(e){
          }
          setState(() {
            hover =true;
          });
        }
        else {
          setState(() {
            hover = false;
          });
        }
      },
      child:Stack(
        children: [
          Hero(
            tag:'${widget.ads[widget.index]['image'].toString().split('/').last}-tag',
            child: ProgressiveImage(
              width: double.maxFinite,
              height: 650,
              fit: BoxFit.cover,
              placeholder: AssetImage('images/notfound.jpg'),
              image: NetworkImage('${widget.ads[widget.index]['image']}'),
              thumbnail: NetworkImage('${widget.ads[widget.index]['image']}'),
            ),
          ),
          hover?AnimatedContainer(
            duration: Duration(milliseconds: 500),
            color:hover?Colors.black.withOpacity(0.4):Colors.transparent,
            child: hover?Center(
              child: IconButton(icon:Icon(Icons.download_rounded,color: Colors.white,), onPressed:(){
                //download('${widget.ads[widget.index]['image']}');
                js.context.callMethod("open",["https://shahersalousi.000webhostapp.com/Shaher/download.php?image=${widget.ads[widget.index]['image']}"]);

              }),
            ):null,
          ):Container(),
        ],
      ),
    );
  }
}
