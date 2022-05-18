import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarana_app_live/components/video_icon.dart';

import '../Audio_player_File/song_details_dialog.dart';
import '../Profile/user_library/Add_song_file.dart';
import 'cached_network_image.dart';

class BuildListTile extends StatelessWidget {
  final String image,song_id,text,audio_video_type,v_location,v_name,c_by,c_name,user_image;
  BuildListTile({required this.image,required this.song_id, required this.text, required this.audio_video_type,required this.v_location,required this.v_name,required this.c_by,required this.c_name,required this.user_image});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Cached_Network_Image(image,43,43,8),/*Image.network(
         image,
        width: 43,
        height: 43,

      ),*/
      title: Text(
        text, style: TextStyle(
          fontSize: 17,
          color: Colors
              .white),
      ),
      subtitle:Text(
          text,
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign:
          TextAlign
              .left) ,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              child:(audio_video_type =="")?SizedBox():(audio_video_type !="0")?
              Video_icon(v_location,v_name,c_by,user_image,c_name)
                  :
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: IconButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Add_song_file(text,song_id,audio_video_type)));
                },
                    icon: Icon(Icons.drive_folder_upload,color: Colors.white,)
                ),
              )
          ),
          InkWell(
              child: Icon(Icons.more_vert,color: Colors.white,),
             onTap: (){
               {
                 showCupertinoDialog(context: context,
                     builder: (context){
                       return Song_details_popup('','','','',"0");
                     });
               }
             },

          ),
        ],
      ),
    );
  }
}
