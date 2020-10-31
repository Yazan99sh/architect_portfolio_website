import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:shaher_website/main.dart';
class ProjectsCells extends StatefulWidget {
  final Map data;
  final int index;
  @override
  _ProjectsCellsState createState() => _ProjectsCellsState();

  ProjectsCells(this.data,this.index);
}

class _ProjectsCellsState extends State<ProjectsCells> {
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
        selected.setData(widget.data);
        selected.setTap(widget.index);
        Navigator.of(context).pushNamed('/ProjectDetails');
      },
      onHover: (hov){
        if (hov){
          _audioCache.play('zapsplat_sound_design_whoosh_short_deep_54865.mp3');
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
          ProgressiveImage(
            height: double.maxFinite,
            width: double.maxFinite,
            fit: BoxFit.cover,
            placeholder: AssetImage('images/notfound.jpg'),
            thumbnail: NetworkImage('${widget.data['image']}'),
            image: NetworkImage('${widget.data['image']}'),
          ),
          hover?AnimatedContainer(
            duration: Duration(milliseconds: 500),
            color:hover?Colors.black.withOpacity(0.4):Colors.transparent,
            child: hover?Center(
              child: Text('${widget.data['title']}',style: TextStyle(
                  color: Colors.white,
                  fontFamily: ArabicFonts.Cairo,
                  package: 'google_fonts_arabic',
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),textScaleFactor: 1 ,),
            ):null,
          ):Container(),
        ],
      ),
    );
  }
}
