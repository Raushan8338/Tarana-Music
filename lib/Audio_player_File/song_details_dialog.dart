import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarana_app_live/Audio_player_File/page_manager.dart';
import 'package:http/http.dart' as http;
import 'package:tarana_app_live/components/like_dislike_page.dart';
import '../auth_configFile/authconfig.dart';
import '../components/favourite_buttom.dart';
import 'notifier/PlayButtonNotifier.dart';
import 'notifier/repeat_button_notifier.dart';
import 'notifier/service_locator.dart';
class Song_details_popup extends StatelessWidget {
  String current_song_image,current_title,album_title,current_song_id,current_page_id;
  Song_details_popup(this.current_song_image,this.current_title,this.album_title,this.current_song_id,this.current_page_id, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.black,
          body: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.keyboard_arrow_down,
                      color: Colors.white,
                      size: 20,),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(current_title,style: TextStyle(color: Colors.white, fontSize: 14),),
                ],
              ),
              Container(
                child: Card(
                  color: Colors.transparent,
                  elevation: 0,
                  child: Column(children: [
                    Container(
                        child:  Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(
                                Radius.circular(5.0)),
                            child: Image.network(current_song_image,fit: BoxFit.cover,
                            ),
                          ),
                        )
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(current_title,style: TextStyle(color: Colors.white, fontSize: 18),),
                    ),
                    (current_page_id =="1")?
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          ValueListenableBuilder<bool>(
                            valueListenable: pageManager
                                .isShuffleModeEnabledNotifier,
                            builder: (context, isEnabled, child) {
                              return IconButton(
                                icon: (isEnabled)
                                    ? Icon(
                                  Icons.shuffle,
                                  color: Colors.white,
                                )
                                    : Icon(Icons.shuffle,
                                    color: Colors.grey),
                                onPressed: pageManager.shuffle,
                              );
                            },
                          ),
                          ValueListenableBuilder<bool>(
                              valueListenable:
                              pageManager.isFirstSongNotifier,
                              builder: (_, isFirst, __) {
                                return IconButton(
                                  icon: (isFirst)
                                      ? Icon(Icons.skip_previous,
                                      color: Colors.grey)
                                      : Icon(
                                    Icons.skip_previous,
                                    color: Colors.white,
                                  ),
                                  onPressed: pageManager.previous,
                                );
                              }),
                          ValueListenableBuilder<ButtonState>(
                            valueListenable:
                            pageManager.playButtonNotifier,
                            builder: (_, value, __) {
                              switch (value) {
                                case ButtonState.loading:
                                  return Container(
                                    margin: EdgeInsets.all(8.0),
                                    width: 32.0,
                                    height: 32.0,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  );

                                case ButtonState.paused:
                                  return IconButton(
                                    icon: Icon(Icons.play_arrow,
                                        color: Colors.white),
                                    iconSize: 32.0,
                                    onPressed: pageManager.play,
                                  );

                                case ButtonState.playing:
                                  return IconButton(
                                    icon: Icon(Icons.pause,
                                        color: Colors.white),
                                    iconSize: 32.0,
                                    onPressed: pageManager.pause,
                                  );
                              }
                            },
                          ),
                          ValueListenableBuilder<bool>(
                            valueListenable:
                            pageManager.isLastSongNotifier,
                            builder: (_, isLast, __) {
                              return IconButton(
                                icon: (isLast)
                                    ? Icon(
                                  Icons.skip_next,
                                  color: Colors.grey,
                                )
                                    : Icon(Icons.skip_next,
                                    color: Colors.white),
                                onPressed: pageManager.next,
                              );
                            },
                          ),
                          ValueListenableBuilder<RepeatState>(
                            valueListenable:
                            pageManager.repeatButtonNotifier,
                            builder: (context, value, child) {
                              Icon icon;
                              switch (value) {
                                case RepeatState.off:
                                  icon = Icon(Icons.repeat,
                                      color: Colors.grey);

                                  break;
                                case RepeatState.repeatSong:
                                  icon = Icon(
                                    Icons.repeat_one,
                                    color: Colors.white,
                                  );

                                  break;
                                case RepeatState.repeatPlaylist:
                                  icon = Icon(
                                    Icons.repeat,
                                    color: Colors.white,
                                  );

                                  break;
                              }

                              return IconButton(
                                icon: icon,
                                onPressed: pageManager.repeat,
                              );
                            },
                          ),
                        ],
                      ),
                    )
                        :
                    SizedBox(
                      height: 30,
                    ),
                  ]),
                ),
              ),
              Spacer(),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.fromLTRB(5,0,5,22),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Add_to_favourite(current_song_id),
                        Text(
                          "Add to favorite",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: SizedBox(
                        height: 0.5,
                        child: Container(
                          color: Colors.white54,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Icon(
                            Icons.library_music_outlined,
                            color: Colors.white54,
                            size: 30,
                          ),
                        ),
                        Text(
                          "Add to playlist",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: SizedBox(
                        height: 0.5,
                        child: Container(
                          color: Colors.white54,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Icon(
                            Icons.share,
                            color: Colors.white54,
                            size: 30,
                          ),
                        ),
                        Text(
                          "Share",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18),
                        )
                      ],
                    ),
                  ],
                ),
              ),

            ],
          ),
        )
    );
  }


}




/* String current_song_image,current_title,album_title,current_song_id,current_page_id;
  Song_details_popup(this.current_song_image,this.current_title,this.album_title,this.current_song_id,this.current_page_id, {Key? key}) : super(key: key);
*/