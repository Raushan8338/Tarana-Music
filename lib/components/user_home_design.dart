import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../auth_configFile/authconfig.dart';
import 'cached_network_image.dart';

class Home_design_pattern extends StatefulWidget {
  double height,width,radius;
  String image,audio_video_type;
  Home_design_pattern(this.height, this.width, this.image,this.radius,this.audio_video_type, {Key? key}) : super(key: key);

  @override
  _Home_design_patternState createState() => _Home_design_patternState(this.height, this.width, this.image,this.radius,this.audio_video_type);
}

class _Home_design_patternState extends State<Home_design_pattern> {
  double height,width,radius;
  String image,audio_video_type;
  _Home_design_patternState(this.height, this.width, this.image,this.radius,this.audio_video_type);
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            height: height,
            width: width,
            child:ClipRRect(
                borderRadius:  BorderRadius.all(
                    Radius.circular(radius)),
                child:
                Cached_Network_Image(image,95,75,
                    8),
            ),
          ),
          Container(
            child: (audio_video_type == "0") ? Positioned(
                right:0,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Icon(
                      Icons.audiotrack,
                      size: 15.0,
                      color:Colors.white
                  ),
                )
            ):Container(
              child: (audio_video_type == "1") ? Positioned(
                  right:0,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Icon(
                        Icons.videocam,
                        size: 15.0,
                        color:Colors.white
                    ),
                  )
              ) :SizedBox()
            )
          )
        ],
      ),
    );
  }
}
