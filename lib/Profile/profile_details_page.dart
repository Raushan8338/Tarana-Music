import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:tarana_app_live/Profile/user_library/add_song_his.dart';
import 'package:tarana_app_live/Profile/view_profile_pic.dart';
import '../Welcome_files/splash.dart';
import '../auth_configFile/authconfig.dart';
import '../components/follower_flowwing_tab.dart';
import '../components/header_component.dart';
import '../components/manage_upload_tab.dart';
import '../components/update_profile_pic.dart';
import 'musician_profile.dart';
class Profile_details_page extends StatefulWidget {
  Profile_details_page({Key? key}) : super(key: key);

  @override
  _Profile_details_page createState() => _Profile_details_page();
}
class _Profile_details_page extends State<Profile_details_page> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  final ImagePicker _picker = ImagePicker();
  TabController? _tabController;
  bool isLoading=true;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
    );

    controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        Navigator.pop(context);
        controller.reset();
      }
    }
    );
  }

  bool isSwitched = false;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Stack(
          children: [
            DefaultTabController(
              length: 5,
              child: NestedScrollView(
                  headerSliverBuilder: (context, value) {
                    return [
                      SliverAppBar(
                        backgroundColor: Colors.black87,
                        elevation: 0,
                        leading: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_ios_outlined,
                              color: Colors.white,
                              size: 20,
                            )
                        ),
                        actions: [
                          Header_toggle_view_buttom(),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.more_vert,
                                color: Colors.white,
                                size: 25,
                              )
                          )
                        ],
                        pinned: false,
                      ),

                      SliverPersistentHeader(
                        pinned: false,
                        delegate: _SliverAppBarDelegate(
                            minHeight: 303,
                            maxHeight: 303,
                            child: Column(
                                children: [
                                  InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>View_profile_pic(Base_url().image_profile_url+creator_images)));
                                  },
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: CircleAvatar(
                                        radius: 52,
                                        backgroundColor: Colors.deepOrange,
                                        child: CircleAvatar(
                                          radius: 50,
                                          backgroundImage:
                                          NetworkImage(
                                              Base_url().image_profile_url+creator_images),
                                          // "https://usersbkp.s3.ap-south-1.amazonaws.com/ATTENDANCE_USERS_IMAGES/095523700_1628747120.jpg"),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                  Text(
                                    "${user_name}",
                                    style: TextStyle(color: Colors.orange,fontSize: 25,fontFamily: 'poppins'),
                                  ),
//                                   Navigator.push(context, MaterialPageRoute(builder: (context)=>Edit_profile_info(creator_names,creator_dobs,creator_phones,creator_emails)));
                                  Text(
                                    "jonitha_gandhi",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white
                                    ),
                                  ),

                                  SizedBox(
                                    height: 49,
                                  ),
                                  Flower_flowwing_tab(creator_followerss,creator_followingss),


                                ]
                            )
                        ),
                      ),
                  (is_creators == "1")?
                      SliverPersistentHeader(
                        pinned: true,
                        delegate: _SliverAppBarDelegate(
                          minHeight: 80,
                          maxHeight: 80,
                          child: Container(
                            color:Colors.black87,
                            child: Column(
                              crossAxisAlignment:CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 6,
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Text("Manage Uploads",
                                    style: TextStyle(color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 37,
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: TabBar(
                                    controller: _tabController,
                                    indicator: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                            color: Colors.deepOrangeAccent, width: 2)),
                                    isScrollable: true,
                                    tabs: [
                                      Tab(
                                        child: Container(
                                          height: 37,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: Colors.transparent
                                          ),

                                          child: Center(
                                            child: Text(
                                              "Audio",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      Tab(
                                        child: Container(
                                          height: 37,

                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: Colors.transparent
                                          ),

                                          child: Center(
                                            child: Text(
                                              "Video",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      Tab(
                                        child: Container(
                                          height: 37,

                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: Colors.transparent
                                          ),

                                          child: Center(
                                            child: Text(
                                              "Album",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      Tab(
                                        child: Container(
                                          height: 37,

                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: Colors.transparent
                                          ),

                                          child: Center(
                                            child: Text(
                                              "Playlist",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      Tab(
                                        child: Container(
                                          height: 37,

                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: Colors.transparent
                                          ),

                                          child: Center(
                                            child: Text(
                                              "Channels",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ): SliverPersistentHeader(
                            pinned: false,
                            delegate: _SliverAppBarDelegate(
                              minHeight: 80,
                              maxHeight: 80,
                              child: Container(
                                child: null,
                              )

                              )
                          )
                    ];
                  },
                  body:  (is_creators == "1")?TabBarView(
                    physics: ScrollPhysics(),
                      children: <Widget>[
                        /*album_ids,audio_video_type,language,creator_id*/
                        Add_song_history("","","","","","1"),
                        Add_song_history("","","","","","0"),
                        Manage_upload_placeholder("https://assets3.lottiefiles.com/packages/lf20_hAjGBH.json",""),
                        Manage_upload_placeholder("https://assets6.lottiefiles.com/private_files/lf30_wo5lnbyz.json",""),
                        Manage_upload_placeholder("https://assets3.lottiefiles.com/private_files/lf30_9kwmn1rz.json",""),
                      ]
                  ):SizedBox()
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
