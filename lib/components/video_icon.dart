import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../video_player/video_details_page.dart';

class Video_icon extends StatelessWidget {
  String video_url,video_title,creator_id,userImage,name;
  Video_icon(this.video_url,this.video_title,this.creator_id,this.userImage,this.name, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: IconButton(
        icon: Icon(
          Icons.videocam_outlined,
          color: Colors.white,
          size: 25,
        ),
        onPressed: () {
          Navigator.push(context,MaterialPageRoute(builder: (context) => Video_details_page(video_title,video_url,creator_id,userImage,name)));
        },
      ),
    );
  }
}

