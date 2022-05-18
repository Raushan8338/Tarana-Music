import 'dart:async';
import 'package:audio_service/audio_service.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarana_app_live/Audio_player_File/page_manager.dart';
import 'package:tarana_app_live/Audio_player_File/song_details_dialog.dart';
import '../Welcome_files/splash.dart';
import '../auth_configFile/authconfig.dart';
import '../Profile/creator_song_profile.dart';
import '../components/cached_network_image.dart';
import '../components/download_file.dart';
import '../components/progress_bar.dart';
import '../components/video_icon.dart';
import '../pages/creator_chat_user_list.dart';
import '../model_class/music_item.dart';
import '../test_folder/astract_class_test.dart';
import 'notifier/PlayButtonNotifier.dart';
import 'notifier/service_locator.dart';

class Song_list_item extends StatelessWidget {
  String album_ids,audio_video_type,language,creator_id,creator_name,creator_image;
  Song_list_item({required this.album_ids,required this.audio_video_type,required this.language, required this.creator_id,required this.creator_name,required this.creator_image,});


  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return Expanded(
      child: ValueListenableBuilder<List<String>>(
        valueListenable: pageManager.playlistNotifier,
        builder: (context, playlistTitles, _) {
          return  ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics:NeverScrollableScrollPhysics(),
            itemCount: playlistTitles.length,
            itemBuilder: (context, index) {
              return Expanded(
                child: Column(
                  children: [
                    InkWell(
                      onTap: () async {
                        pageManager.skipToQueueItem(index,'${playlistTitles[index]}' );
                      },
                      child: Padding(
                        padding:  EdgeInsets.fromLTRB(8,8,8,0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xff222224),
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(8,0,0,0),
                                child: Row(
                                  children: [
                                    Cached_Network_Image(Base_url().image_url+'${pageManager.currentSongImageNotifier}',38,38,
                                        8),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${playlistTitles[index]}',style: TextStyle(fontSize: 17,color: Colors.white
                                          ),
                                          ),
                                          Text(
                                              '${pageManager.currentSongCreator_name_Notifier}',
                                              style: TextStyle(fontSize: 12, color: Colors.grey),
                                              textAlign:
                                              TextAlign
                                                  .left),

                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              /*  Row(
                                children: [
                                  Container(
                                      child:(snapshot.data[index].audio_video_type =="1")?
                                      Video_icon(snapshot.data[index].v_location,snapshot.data[index].v_name,creator_id,creator_image,creator_name)
                                          :SizedBox()
                                  ),
                                  Download_file(),
                                  IconButton(onPressed: (){
                                    showCupertinoDialog(context: context,
                                        builder: (context){
                                          return Song_details_popup(Base_url().image_url+snapshot.data[index].image,snapshot.data[index].title,'','',"0");
                                        });
                                  },
                                      icon: Icon(Icons.more_vert,color: Colors.white,)
                                  )
                                ],
                              )*/
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
    /*  return MediaQuery.removePadding(
        removeTop: true,
        removeBottom: true,
        context: context,
        child: FutureBuilder(
          future: all_song_list(album_ids,audio_video_type,language,""),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: progress_bar());
            }
            return snapshot.data == null ? Container(
              margin: EdgeInsets.fromLTRB(0,55,0,0),
              child: SizedBox(
                child: Align(
                    alignment: Alignment.topCenter,
                    child: Text("No Data Found",style: TextStyle(color: Colors.white,fontSize: 22),)),
              ),
            ):
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics:NeverScrollableScrollPhysics(),
              itemCount: playlistTitles.length,
              itemBuilder: (context, index) {
                return Expanded(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () async {
                          getIt<PageManager>().init(album_ids,creator_name,creator_image, "", creator_id, "");
                          print(index);
                          pageManager.skipToQueueItem(index, snapshot.data[index].title);
                        },
                        child: Padding(
                          padding:  EdgeInsets.fromLTRB(8,8,8,0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color(0xff222224),
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(8,0,0,0),
                                  child: Row(
                                    children: [
                                      Cached_Network_Image(Base_url().image_url+snapshot.data[index].image,38,38,
                                      8),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              snapshot.data[index].title,style: TextStyle(fontSize: 17,color: Colors.white
                                            ),
                                            ),
                                            Text(
                                                snapshot.data[index].singer_name,
                                                style: TextStyle(fontSize: 12, color: Colors.grey),
                                                textAlign:
                                                TextAlign
                                                    .left),

                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                        child:(snapshot.data[index].audio_video_type =="1")?
                                        Video_icon(snapshot.data[index].v_location,snapshot.data[index].v_name,creator_id,creator_image,creator_name)
                                            :SizedBox()
                                    ),
                                    Download_file(),
                                    IconButton(onPressed: (){
                                      showCupertinoDialog(context: context,
                                          builder: (context){
                                            return Song_details_popup(Base_url().image_url+snapshot.data[index].image,snapshot.data[index].title,'','',"0");
                                          });
                                    },
                                        icon: Icon(Icons.more_vert,color: Colors.white,)
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        )
    );*/
  }
}


class CircularProgressIndicatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      backgroundColor: Colors.red,
      strokeWidth: 8,
    );
  }
}
/**/