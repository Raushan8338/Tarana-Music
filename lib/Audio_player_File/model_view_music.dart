import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tarana_app_live/Audio_player_File/page_manager.dart';
import 'package:tarana_app_live/Audio_player_File/song_details_dialog.dart';
import '../auth_configFile/authconfig.dart';
import '../components/download_file.dart';
import '../components/following_folloup_buttom.dart';
import '../components/inline_profile_view.dart';
import '../components/like_dislike_page.dart';
import '../components/share_file.dart';
import '../components/video_icon.dart';
import 'notifier/PlayButtonNotifier.dart';
import 'notifier/ProgressNotifier.dart';
import 'notifier/repeat_button_notifier.dart';
import 'notifier/service_locator.dart';

class Model_view_music extends StatefulWidget {
  Model_view_music({Key? key}) : super(key: key);

  @override
  _Model_view_musicState createState() => _Model_view_musicState();
}
String floowing_status = '1';

class _Model_view_musicState extends State<Model_view_music> {
  double _currentSliderValue = 0;

  @override
  void dispose() {
    getIt<PageManager>().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xff084a43),
        body: SafeArea(
          top: false,
          child: ValueListenableBuilder<String>(
            valueListenable: pageManager.currentSongImageNotifier,
            builder: (_, image, __) {
              return Center(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.white,
                                size: 25,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            ValueListenableBuilder<String>(
                              valueListenable:
                              pageManager.currentSongAlbumNotifier,
                              builder: (_, title, __) {
                                return Row(
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          "PLAYING FROM PLAYLIST",
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 16),
                                        ),
                                        Text(
                                          title,
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 13),
                                        ),
                                      ],
                                    ),

                                  ],
                                );
                              },
                            ),
                            ValueListenableBuilder<String>(
                              valueListenable:
                              pageManager.currentSongAlbumNotifier,
                              builder: (_, title, __) {
                                return  ValueListenableBuilder<String>(
                                  valueListenable:
                                  pageManager.currentSongIdNotifier,
                                  builder: (_, song_id, __) {
                                    return InkWell(
                                      child: Icon(Icons.more_vert,color: Colors.white,),
                                      onTap: (){
                                        showCupertinoDialog(context: context,
                                            builder: (context){
                                              return Song_details_popup(image,title,'',song_id,"1");
                                            });

                                      },
                                    );
                                  },
                                );
                              },
                            )
                          ],
                        ),
                      ),
                      Spacer(),

                      Center(
                        child: ValueListenableBuilder<String>(
                          valueListenable: pageManager.currentSongImageNotifier,
                          builder: (_, image, __) {
                            return Container(
                              height: 360,
                              child: GestureDetector(
                                  onTap: () {
                                    print(image);
                                  },
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5.0)
                                    ),

                                    child: Image.network(
                                      image,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                              ),
                            );
                          },
                        ),
                      ),

                      Spacer(),



                      Container(
                        margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                        child: Column(
                          children: [
                            ValueListenableBuilder<ProgressBarState>(
                                valueListenable: pageManager.progressNotifier,
                                builder: (_, value, __) {
                                  return ProgressBar(
                                    progressBarColor: Colors.white,
                                    baseBarColor: Colors.grey,
                                    bufferedBarColor: Colors.white30,
                                    thumbColor: Colors.white,
                                    timeLabelTextStyle:
                                    TextStyle(color: Colors.white),
                                    progress: value.current,
                                    buffered: value.buffered,
                                    total: value.total,
                                    onSeek: pageManager.seek,
                                  );
                                }),
                            Container(
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
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                              // alignment: Alignment.topLeft,

                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      ValueListenableBuilder<String>(
                                        valueListenable: pageManager
                                            .currentSongTitleNotifier,
                                        builder: (_, title, __) {
                                          return Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Text(
                                                title,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18),
                                              ));
                                        },
                                      ),
                                      Text('10M listerner',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white)),
                                    ],
                                  ),
                                  Container(
                                    transformAlignment: Alignment.centerRight,
                                    child: Row(
                                      children: [
                                        InkWell(
                                            child: const Icon(
                                                Icons
                                                    .arrow_drop_down_circle_outlined,
                                                color: Colors.white,
                                                size: 24.0),
                                            onTap: () {}),
                                        /*  InkWell(
                                      child: const Icon(
                                          Icons.arrow_drop_down_rounded,
                                          size: 26.0),
                                      onTap: () {}),*/
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  ValueListenableBuilder<String>(
                                    valueListenable:
                                    pageManager.currentSongIdNotifier,
                                    builder: (_, song_id, __) {
                                      return Like_dislike_page("song",song_id,"");
                                    },
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 0, 10, 0),
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.translate,
                                        color: Colors.white,
                                        size: 25,
                                      ),
                                      onPressed: () {},
                                    ),
                                  ),/**/

                                ValueListenableBuilder<String>(
                                  valueListenable: pageManager
                                      .currentSongcreated_by_idNotifier,
                                  builder: (_, created_id, __) {
                                    return ValueListenableBuilder<String>(
                                      valueListenable: pageManager
                                          .currentSongAudiVideoTypeNotifier,
                                      builder: (_, audi_video_type, __) {
                                        return ValueListenableBuilder<String>(
                                          valueListenable: pageManager
                                              .currentSongV_id_Notifier,
                                          builder: (_, video_id, __) {
                                            return   ValueListenableBuilder<String>(
                                              valueListenable: pageManager
                                                  .currentSongV_titleNotifier,
                                              builder: (_, video_title, __) {
                                                return  ValueListenableBuilder<String>(
                                                  valueListenable: pageManager
                                                      .currentSongV_locationNotifier,
                                                  builder: (_, video_location, __) {
                                                    return ValueListenableBuilder<String>(
                                                      valueListenable: pageManager
                                                          .currentSongcreator_imageNotifier,
                                                      builder: (_, creator_image, __) {
                                                        return ValueListenableBuilder<String>(
                                                          valueListenable: pageManager
                                                              .currentSongCreator_name_Notifier,
                                                          builder: (_, creator_name, __) {
                                                            return (audi_video_type=="1")?Video_icon(video_location,video_title,created_id,creator_image,creator_name):IconButton(
                                                              icon: Icon(
                                                                Icons.videocam_outlined,
                                                                color: Colors.grey,
                                                                size: 25,
                                                              ),
                                                              onPressed: () {
                                                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                  content: Text("Video Not Available !"),
                                                                ));
                                                              },
                                                            );
                                                          },
                                                        );
                                                      },
                                                    );
                                                  },
                                                );
                                              },
                                            );
                                          },
                                        );
                                      },
                                    );
                                  },
                                ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 0, 10, 0),
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.phonelink,
                                        color: Colors.white,
                                        size: 25,
                                      ),
                                      onPressed: () {},
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 10, 0),
                                      child:Download_file()
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 10, 0),
                                      child: Share_file()
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 0, 10, 0),
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.playlist_add,
                                        color: Colors.white,
                                        size: 25,
                                      ),
                                      onPressed: () {},
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              // width: MediaQuery.of(context).size.width,
                              child:  Row(
                                children: [
                                  Expanded(
                                    flex: 8,
                                    child:  ValueListenableBuilder<String>(
                                      valueListenable: pageManager
                                          .currentSongCreator_name_Notifier,
                                      builder: (_, name, __) {
                                        return ValueListenableBuilder<String>(
                                          valueListenable: pageManager
                                              .currentSongcreator_imageNotifier,
                                          builder: (_, creator_image, __) {
                                            return ValueListenableBuilder<String>(
                                              valueListenable: pageManager
                                                  .currentSongAlbumIdNotifier,
                                              builder: (_, album_id, __) {
                                                return ValueListenableBuilder<String>(
                                                  valueListenable: pageManager
                                                      .currentSongcreated_by_idNotifier,
                                                  builder: (_, created_id, __) {
                                                    return Inline_profile_view(Base_url().image_profile_url+creator_image,name,name,album_id,created_id);
                                                  },
                                                );
                                              },
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                  Expanded(
                                      flex: 5,
                                      child: Following_follow_button("","",8)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),

              );},
          ),
        ));
  }
}
