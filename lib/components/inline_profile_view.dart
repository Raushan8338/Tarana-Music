import 'package:flutter/material.dart';

import '../Profile/creator_song_profile.dart';
import 'cached_network_image.dart';
import 'following_folloup_buttom.dart';

class Inline_profile_view extends StatelessWidget {
  String userImage,user_name,subtitle,album_id,created_id;
   Inline_profile_view(this.userImage,this.user_name,this.subtitle,this.album_id,this.created_id, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> Creator_song_profile(created_id,album_id)));
      },
      child: ListTile(
        leading: Cached_Network_Image(userImage,43,43,8),
        title: Text(
          user_name,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
        subtitle: Text(user_name,
            style: TextStyle(color: Colors.white, fontSize: 12)),
      ),
    );
  }
}
