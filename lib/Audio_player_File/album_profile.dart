import 'dart:async';
import 'package:audio_service/audio_service.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarana_app_live/Audio_player_File/page_manager.dart';
import 'package:tarana_app_live/Audio_player_File/song_details_dialog.dart';
import 'package:tarana_app_live/Audio_player_File/song_list_item.dart';
import '../Welcome_files/splash.dart';
import '../auth_configFile/authconfig.dart';
import '../Profile/creator_song_profile.dart';
import '../components/download_file.dart';
import '../components/favourite_buttom.dart';
import '../components/like_dislike_page.dart';
import '../components/progress_bar.dart';
import '../components/share_file.dart';
import 'notifier/PlayButtonNotifier.dart';
import 'notifier/service_locator.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Album_profile extends StatefulWidget {
  String image_data,
      catagoryName,
      movie_title,
      catagory_ids,
      album_ids,
      created_by_id,
      creator_name,
      creator_images
  ;

  Album_profile(
      {required this.image_data,
        required this.catagoryName,
        required this.movie_title,
        required this.catagory_ids,
        required this.album_ids,
        required this.created_by_id,
        required this.creator_name,
        required this.creator_images,
      });

  @override
  _Album_profile createState() => _Album_profile(this.image_data, this.catagoryName,
      this.movie_title, this.catagory_ids, this.album_ids, this.created_by_id,this.creator_name,this.creator_images);
}

class _Album_profile extends State<Album_profile> {
  String image_data,
      catagoryName,
      movie_title,
      catagory_ids,
      album_ids,
      created_by_id,
      creator_name,
      creator_images;
  _Album_profile(this.image_data, this.catagoryName,
      this.movie_title, this.catagory_ids, this.album_ids, this.created_by_id,this.creator_name,this.creator_images);

  @override
  void initState() {
    super.initState();
   // getMediaItem();
  }

  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: NestedScrollView(
            physics: NeverScrollableScrollPhysics(),
            headerSliverBuilder: (context, isScrolled) {
              return [
                SliverAppBar(
                  stretch: true,
                  expandedHeight: 200.0,
                  flexibleSpace: FlexibleSpaceBar(
                    stretchModes: <StretchMode>[
                      StretchMode.zoomBackground,
                      StretchMode.blurBackground,
                      StretchMode.fadeTitle,
                    ],
                    centerTitle: true,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          movie_title,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          Base_url().album_image_url + image_data,
                          fit: BoxFit.cover,
                        ),
                        const DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(0.0, 0.5),
                              end: Alignment(0.0, 0.0),
                              colors: <Color>[
                                Color(0x60000000),
                                Color(0x00000000),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ];
            },
            body: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> Creator_song_profile(created_by_id,album_ids)));
                        },
                        child: ListTile(
                          title: Text(
                            movie_title,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          subtitle: Text(
                            creator_followerss+ "Listeners",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          trailing: Wrap(
                            spacing: 12,
                            children: <Widget>[
                             /* Icon(
                                Icons.favorite_border,
                                color: Colors.white,
                                size: 22,
                              ),*/
                              Add_to_favourite(album_ids),

                           //   Like_dislike_page("album",album_ids),
                             // Download_file(),
                              Share_file()
                            ],
                          ),
                        ),
                      ),
                      DefaultTabController(
                        length: 4,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Container(
                                  height: 32,
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                        child: TabBar(
                                            indicator: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(50),
                                                border: Border.all(
                                                    color: Colors.deepOrangeAccent,
                                                    width: 2)),
                                            isScrollable: true,
                                            tabs: [
                                              Tab(
                                                child: Container(
                                                  height: 32,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(20),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "All",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                          fontWeight:
                                                          FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Tab(
                                                child: Container(
                                                  height: 32,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(20),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "Telegu",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                          fontWeight:
                                                          FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Tab(
                                                child: Container(
                                                  height: 32,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(20),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "Hindi",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                          fontWeight:
                                                          FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Tab(
                                                child: Container(
                                                  height: 32,

                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(20),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "English",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                          fontWeight:
                                                          FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ]),
                                      ),
                                      Container(
                                          margin: EdgeInsets.fromLTRB(0,0,12,0),
                                          child: ValueListenableBuilder<ButtonState>(
                                            valueListenable: pageManager.playButtonNotifier,
                                            builder: (_, value, __) {
                                              switch (value) {
                                                case ButtonState.loading:
                                                  return Container(
                                                    margin: EdgeInsets.all(8.0),
                                                    width: 30.0,
                                                    height: 30.0,
                                                    child: CircularProgressIndicator(),
                                                  );
                                                case ButtonState.paused:
                                                  return IconButton(
                                                    icon: Icon(Icons.play_circle_outline,color: Colors.orange,),
                                                    iconSize: 30.0,
                                                    onPressed: pageManager.play,
                                                  );
                                                case ButtonState.playing:
                                                  return IconButton(
                                                    icon: Icon(Icons.pause,color: Colors.orange,),
                                                    iconSize: 30,
                                                    onPressed: pageManager.pause,
                                                  );
                                              }
                                            },
                                          )
                                      ),
                                    ],
                                  )),
                              Container(
                                height: MediaQuery.of(context).size.height,
                                decoration: BoxDecoration(
                                    border: Border(
                                        top: BorderSide(
                                            color: Colors.transparent,
                                            width: 0.5))),
                                child: TabBarView(
                                  children: <Widget>[
                                    Song_list_item(album_ids:album_ids,audio_video_type:"0",language:"",creator_id:created_by_id,creator_name:creator_name,creator_image:creator_images),
                                    Song_list_item(album_ids:album_ids,audio_video_type:"0",language:"114",creator_id:created_by_id,creator_name:creator_name,creator_image:creator_images),
                                    Song_list_item(album_ids:album_ids,audio_video_type:"0",language:"42",creator_id:created_by_id,creator_name:creator_name,creator_image:creator_images),
                                    Song_list_item(album_ids:album_ids,audio_video_type:"0",language:"1",creator_id:created_by_id,creator_name:creator_name,creator_image:creator_images)
                                  ],
                                ),
                              )
                            ]),
                      )
                    ]))));
  }

  /*Future<void> getMediaItem() async {
    await getIt<PageManager>().init(album_ids,creator_name,creator_image, "", '', "");
  }*/
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
