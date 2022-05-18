import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:better_player/better_player.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarana_app_live/Audio_player_File/page_manager.dart';

import '../Audio_player_File/notifier/service_locator.dart';
import '../auth_configFile/authconfig.dart';
import '../components/download_file.dart';
import '../components/following_folloup_buttom.dart';
import '../components/header_component.dart';
import '../components/inline_profile_view.dart';
import '../components/like_dislike_page.dart';
import '../components/share_file.dart';
import '../dashboard_home.dart';
import '../home.dart';
import 'View_video_player.dart';
class Video_details_page extends StatefulWidget {
  String catagoryName, fileLocation,id,userImage,name;
  Video_details_page(this.catagoryName, this.fileLocation,this.id,this.userImage,this.name, {Key? key}) : super(key: key);
  @override
  _Video_details_page createState() =>
      _Video_details_page(this.catagoryName, this.fileLocation,this.id,this.userImage,this.name);
}
class _Video_details_page extends State<Video_details_page>  with SingleTickerProviderStateMixin {
  String catagoryName, fileLocation,id,userImage,name;
  _Video_details_page(this.catagoryName, this.fileLocation,this.id,this.userImage,this.name);
  TabController? _tabController;
  @override
  void initState() {
    super.initState();
    getSliderData();
    print(fileLocation);
    print("asdasdasda");
  }
  /* double getHeight() {
    return 600;
  }*/
  List category_list=[];
  getSliderData() async {
    var jsonResponses =null;
    Map data={
    };
    var response = await http.post(Uri.parse('https://www.itexpress4u.tech/taranaApi/taranaVideo_Api/video_catagory'),body: data);
    if (response.statusCode == 200) {
      jsonResponses=jsonDecode(response.body);;
      category_list = jsonResponses['video_catagory_list'];
      setState(() {
      });
    }
    return category_list;
  }
  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return Scaffold(
      backgroundColor: Colors.black87,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Stack(
          children: [
            DefaultTabController(
              length: category_list.length,
              child: NestedScrollView(
                headerSliverBuilder: (context, value) {
                  return [
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: _SliverAppBarDelegate(
                          minHeight: 45,
                          maxHeight: 45,
                          child: Container(
                            color: Colors.black,
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      (fileLocation == "")?
                                      Navigator.push(context,MaterialPageRoute(builder: (context)=>HomeScreen())):
                                      Navigator.pop(context);
                                    },
                                    icon:
                                    Icon(Icons.arrow_back_ios_outlined, color: Colors.white)),
                                User_name_component(),
                              ],
                            ),
                          )
                      ),
                    ),
                    (fileLocation == "")? SliverPersistentHeader(
                        pinned: true,
                        delegate: _SliverAppBarDelegate(
                          minHeight: 0,
                          maxHeight: 0,
                          child: SizedBox(),
                        )):
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: _SliverAppBarDelegate(
                        minHeight: 230,
                        maxHeight: 230,
                        child: Container(
                          width: double.infinity,
                          color: Colors.black87,
                          child: Center(
                            child: AspectRatio(
                              aspectRatio: 16 / 9,
                              child: BetterPlayerPlaylist(
                                  betterPlayerConfiguration:
                                  BetterPlayerConfiguration(),
                                  betterPlayerPlaylistConfiguration:
                                  BetterPlayerPlaylistConfiguration(),
                                  betterPlayerDataSourceList:
                                  createDataSet(Base_url().Video_file_location+fileLocation)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    (fileLocation == "")?SliverPersistentHeader(
                        pinned: true,
                        delegate: _SliverAppBarDelegate(
                          minHeight: 0,
                          maxHeight: 0,
                          child: SizedBox(),
                        )):
                    SliverPersistentHeader(
                      pinned: false,
                      delegate: _SliverAppBarDelegate(
                        minHeight: 180,
                        maxHeight: 180,
                        child:Container(
                          color: Colors.black87,
                          child: Column(
                              children: [
                                Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 30,
                                          margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                          width: MediaQuery.of(context).size.width,
                                          color: Colors.transparent,
                                          child: Text(catagoryName,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontFamily: 'poppins')),
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
                                                return Like_dislike_page("song",song_id,"1");
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
                                            ),
                                            /*Video_icon("",""),*/
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
                                      )

                                    ]),
                                Row(
                                  children: [
                                    Expanded(
                                        flex: 5,
                                        child: Inline_profile_view(Base_url().image_profile_url+userImage,name,name,id,"")),
                                    Expanded(
                                        flex: 5,
                                        child: Following_follow_button("","",8)),
                                  ],
                                ),

                                // Dashboard_home_design(),
                              ]),
                        ),
                      ),
                    ),
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: _SliverAppBarDelegate(
                        minHeight: 37,
                        maxHeight: 37,
                        child: Container(
                          height: 37,
                          decoration: BoxDecoration(
                              color: Colors.black87,
                              borderRadius: BorderRadius.circular(0)),
                          child: TabBar(
                            isScrollable: true,
                            labelColor: Colors.black87,
                            unselectedLabelColor: Colors.black87,
                            padding: EdgeInsets.fromLTRB(0,0,0,0),
                            indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                    color: Colors.deepOrangeAccent, width: 2)),
                            tabs: category_list.map((e) {
                              return Container(
                                height: 37,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Text(
                                    e['catagory_name'],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,

                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ];
                },
                body:TabBarView(
                  children: category_list.map<Widget>((e) {
                    return View_video_player(e['id']);
                  }).toList(),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
createDataSet(String fileLocation) {
  List dataSourceList = <BetterPlayerDataSource>[];
  dataSourceList.add(
    BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      fileLocation,
    ),
  );
  return dataSourceList;
}
