import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarana_app_live/model_class/music_item.dart';
import 'package:tarana_app_live/search_song.dart';
import 'package:tarana_app_live/Profile/user_profile.dart';
import 'package:tarana_app_live/select_language.dart';
import 'package:tarana_app_live/video_player/Video_player_home.dart';
import 'Audio_player_File/model_view_music.dart';
import 'Audio_player_File/notifier/PlayButtonNotifier.dart';
import 'Audio_player_File/notifier/ProgressNotifier.dart';
import 'Audio_player_File/notifier/service_locator.dart';
import 'Audio_player_File/page_manager.dart';
import 'Profile/musician_profile.dart';
import 'camera_page.dart';
import 'dashboard_home.dart';
import 'pages/notification.dart';
import 'package:flutter/cupertino.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  bool loading=true;
  late double _progress;
  @override
  void initState() {
    super.initState();
    getSharedata();
  }
  getSharedata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      var url = prefs.getString('url')!;
      var category_id = prefs.getString('catagory_ids')!;
      getIt<PageManager>().init(category_id,'','','','','');
    });
    // print("ergergeg"+category_id);
  }
  @override
  void dispose() {
    getIt<PageManager>().dispose();
    super.dispose();
  }
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Home_page_design(),
    Video_player_page(),
    Search_song(),
    Musician_profile()
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget buttom_music_player(){
    final pageManager = getIt<PageManager>();
    return Container(
      child:
      ValueListenableBuilder<String>(
        valueListenable: pageManager.currentSongTitleNotifier,
        builder: (_, title, __) {
          return  Container(
              child: (title == '')?
              SizedBox()
                  :
              ValueListenableBuilder<String>(
                  valueListenable: pageManager.currentSongbgColor,
                  builder: (_, colors, __) {
                    Color colord;
                    if(colors== 'blue'){
                      colord=Colors.blue;
                    }
                    else if(colors== 'black'){
                      colord=Colors.black87;
                    }
                    else if(colors== 'orange'){
                      colord=Colors.orange;
                    }
                    else if(colors== 'grey'){
                      colord=Colors.grey;
                    }
                    else {
                      colord=Color(0xFF958178);
                    }
                    return  Container(
                      decoration: BoxDecoration(
                        color: colord,
                          border: Border.all(
                            color:colord,
                          ),
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(8),topRight: Radius.circular(8),bottomRight: Radius.circular(0),bottomLeft: Radius.circular(0))
                      ),
                      child:  Column(
                        children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(3,0,3,0),
                              child: ValueListenableBuilder<ProgressBarState>(
                              valueListenable: pageManager.progressNotifier,
                                  builder: (_, value, __) {
                                    return ProgressBar(
                                      progressBarColor: Colors.white,
                                      baseBarColor: Colors.grey,
                                      barHeight: 1.0,
                                      bufferedBarColor: Colors.white30,
                                      thumbColor: Colors.white,
                                      progress: value.current,
                                      buffered: value.buffered,
                                      thumbRadius: 5.0,
                                      timeLabelPadding: 0.0,
                                      timeLabelTextStyle: TextStyle(color: Colors.white,fontSize: 0.0),
                                      total: value.total,
                                      onSeek: pageManager.seek,
                                    );
                                  }
                                    ),
                            ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(3,0,3,5),
                            child: InkWell(
                              onTap: (){
                                showModalBottomSheet(
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (BuildContext ct){
                                      return Padding(
                                        padding:EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                                        child: Container(child: Model_view_music()),
                                      );
                                    });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      ValueListenableBuilder<String>(
                                        valueListenable: pageManager.currentSongImageNotifier,
                                        builder: (_, image, __) {
                                          return Padding(
                                            padding: const EdgeInsets.only(top: 8.0),
                                            child: GestureDetector(
                                                onTap: (){
                                                  print(image);
                                                },
                                                child: ClipRRect(
                                                  borderRadius: const BorderRadius.all(
                                                      Radius.circular(5.0)),
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                    image,
                                                    width: 55,
                                                    height: 55,
                                                    fit: BoxFit.cover,
                                                    errorWidget: (context, url, error) =>  Container(
                                                      margin: EdgeInsets.fromLTRB(6, 0, 6, 0),
                                                      height: 95,
                                                      width: 75,
                                                      decoration: BoxDecoration(
                                                          color: Colors.grey,
                                                          borderRadius: BorderRadius.all(Radius.circular(10))),
                                                      child: ClipRRect(
                                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                                        child: AspectRatio(
                                                          aspectRatio: 22 / 5,
                                                          child: Container(
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                            ),
                                          );
                                        },
                                      ),
                                      Container(
                                        margin: EdgeInsets.fromLTRB(8, 0,0,0),
                                        width: 135,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            ValueListenableBuilder<String>(
                                              valueListenable: pageManager.currentSongTitleNotifier,
                                              builder: (_, title, __) {
                                                return Padding(
                                                    padding: const EdgeInsets.only(top: 8.0),
                                                    child: Flexible(child: Text(title,style: TextStyle(color: Colors.white, fontSize: 16,),overflow: TextOverflow.ellipsis,))
                                                );
                                              },
                                            ),
                                            ValueListenableBuilder<String>(
                                              valueListenable: pageManager.currentSongSingerNotifier,
                                              builder: (_, title, __) {
                                                return Padding(
                                                    padding: const EdgeInsets.only(top: 8.0),
                                                    child: Text(title,style: TextStyle(color: Color(
                                                        0xFFCECBCB), fontSize: 12),)
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                      ValueListenableBuilder<bool>(
                                        valueListenable: pageManager.isFirstSongNotifier,
                                        builder: (_, isFirst, __) {
                                          return IconButton(
                                            icon: (isFirst) ? Icon(Icons.skip_previous,color: Colors.grey):Icon(Icons.skip_previous,color: Colors.white,),
                                            onPressed: pageManager.previous,
                                          );
                                        },
                                      ),
                                  Container(
                                      child: ValueListenableBuilder<ButtonState>(
                                        valueListenable: pageManager.playButtonNotifier,
                                        builder: (_, value, __) {
                                          switch (value) {
                                            case ButtonState.loading:
                                              return Container(
                                                margin: EdgeInsets.all(8.0),
                                                width: 32.0,
                                                height: 32.0,
                                                child: CircularProgressIndicator(),
                                              );
                                            case ButtonState.paused:
                                              return IconButton(
                                                icon: Icon(Icons.play_arrow,color: Colors.white,),
                                                iconSize: 32.0,
                                                onPressed: pageManager.play,
                                              );
                                            case ButtonState.playing:
                                              return IconButton(
                                                icon: Icon(Icons.pause,color: Colors.white,),
                                                iconSize: 32.0,
                                                onPressed: pageManager.pause,
                                              );
                                          }
                                        },
                                      )
                                  ),
                                        ValueListenableBuilder<bool>(
                                          valueListenable: pageManager.isLastSongNotifier,
                                          builder: (_, isLast, __) {
                                            return IconButton(
                                              icon: (isLast) ? Icon(Icons.skip_next,color: Colors.grey,) : Icon(Icons.skip_next,color: Colors.white),
                                              onPressed: pageManager.next,
                                            );
                                          },
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
              )

          );
        },
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xff14192A),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buttom_music_player(),
          Theme(
              data: Theme.of(context).copyWith(
                canvasColor: Colors.deepOrange,
                // primaryColor: Colors.white,
                /* textTheme: Theme.of(context).textTheme.copyWith(
                          caption: TextStyle(color: Colors.green)
                      )*/
              ),
              child:  BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  showSelectedLabels: true,
                  currentIndex: _selectedIndex,
                  unselectedItemColor: Color(0xffFFE2E0E0),
                  selectedItemColor: Colors.white,
                  showUnselectedLabels: false,
                  iconSize: 25,
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home), label: 'Home'),
                    BottomNavigationBarItem(
                        icon:Icon(Icons.videocam), label: 'Video'
                    ),
                    BottomNavigationBarItem(
                        icon:Icon(Icons.search), label: 'Search'
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.account_circle), label: 'Profile'),
                  ],

                  onTap: _onItemTapped,
                  elevation: 0))

        ],
      ),
    );
  }
}

/* return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Container(
          child:  ValueListenableBuilder<ButtonState>(
            valueListenable: _pageManager.buttonNotifier,
            builder: (_, value, __) {
              switch (value) {
                case ButtonState.loading:
                  return Container(
                    margin: const EdgeInsets.all(8.0),
                    width: 32.0,
                    height: 32.0,
                    child: const CircularProgressIndicator(),
                  );
                case ButtonState.paused:
                  return IconButton(
                    icon: const Icon(Icons.play_arrow),
                    iconSize: 32.0,
                    onPressed: _pageManager.play,
                  );
                case ButtonState.playing:
                  return IconButton(
                    icon: const Icon(Icons.pause),
                    iconSize: 32.0,
                    onPressed: _pageManager.pause,
                  );
              }
            },
          ),,
        ),
      ),
      child: CupertinoPageScaffold(
              backgroundColor: Colors.black,
              child: CupertinoTabScaffold(
                backgroundColor: Colors.black,

                tabBar: CupertinoTabBar(
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home, color: Colors.white), label: 'Home'),
                    BottomNavigationBarItem(
                        icon:Icon(Icons.library_music), label: 'Library'
                    ),
                    BottomNavigationBarItem(
                        icon:Icon(Icons.search), label: 'Search'
                    ),
                    BottomNavigationBarItem(
                        icon:Icon(Icons.notifications_none_rounded), label: 'Notification'
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.account_circle, color: Colors.white), label: 'Profile'),
                  ],
                ),
                tabBuilder: (context,index)
                {
                  switch(index){
                    case 0: return CupertinoTabView(builder: (context){
                      return CupertinoPageScaffold(child:Dashboard_home(),);
                    },);
                    case 1: return CupertinoTabView(builder: (context){
                      return CupertinoPageScaffold(child:Test_just_audio(),);
                    },);
                    case 2: return CupertinoTabView(builder: (context){
                      return CupertinoPageScaffold(child:Search_song(),);
                    },);
                    case 3: return CupertinoTabView(builder: (context){
                      return CupertinoPageScaffold(child:Notifications(),);
                    },);
                    case 4: return CupertinoTabView(builder: (context){
                      return CupertinoPageScaffold(child:User_profile(),);
                    },);
                    default: return CupertinoTabView(builder: (context){
                      return CupertinoPageScaffold(child:Dashboard_home(),);
                    },);
                  }
                  return _tabs[index];
                }
              )
      ),
    );*/
/* return MaterialApp(
      home: DefaultTabController(
        length: 5,
        child: Scaffold(
            bottomNavigationBar: menu(),
            backgroundColor: Colors.transparent,
            body:Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(begin: Alignment.bottomRight, stops: [
                    0.1,
                    0.9
                  ], colors: [
                    Colors.deepOrange.withOpacity(.8),
                    Colors.white.withOpacity(.1)
                  ])),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: size.height,
                      child:  TabBarView(
                        children: [
                          Container(child: Dashboard_home()),
                          Container(child: Test_just_audio()),
                          Container(child: Search_song()),
                          Container(child: Notifications()),
                          Container(child: User_profile()),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            )
        ),
      ),

    );*/
/*
  }

 Widget menu() {
    return Container(
      child:Material(
        color: Color(0xffEE5825),
        elevation: 220,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buttom_music_player(),
            TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorPadding: EdgeInsets.all(5.0),
              indicatorColor:Color(0xff14192A),
              tabs: [
                Tab(
                  icon: Icon(Icons.home),
                ),
                Tab(
                  icon: Icon(Icons.settings_display_outlined),
                ),
                Tab(
                  icon: Icon(Icons.search),
                ),
                Tab(
                  icon: Badge(
                      position: BadgePosition.topEnd(top: 5, end:25),
                      badgeContent: Text(
                        '0',
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                      child:
                      IconButton(icon: Icon(Icons.notifications_none_rounded), onPressed: () {}))
                //  icon: Icon(Icons.notifications_none_rounded),
                ),
                Tab(icon:  Icon(Icons.account_circle,color: Colors.white,))
              ],
            ),
          ],
        ),
      )
    );
  }
}*/
