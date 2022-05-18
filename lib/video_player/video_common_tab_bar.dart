import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:better_player/better_player.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../components/header_component.dart';
import 'View_video_player.dart';
class Video_Common_tab_bar extends StatefulWidget {
  String catagoryName, fileLocation,id,userImage,name;
  Video_Common_tab_bar(this.catagoryName, this.fileLocation,this.id,this.userImage,this.name, {Key? key}) : super(key: key);

  @override
  _Video_Common_tab_bar createState() =>
      _Video_Common_tab_bar(this.catagoryName, this.fileLocation,this.id,this.userImage,this.name);
}

class _Video_Common_tab_bar extends State<Video_Common_tab_bar>  with SingleTickerProviderStateMixin {
  String catagoryName, fileLocation,id,userImage,name;
  _Video_Common_tab_bar(this.catagoryName, this.fileLocation,this.id,this.userImage,this.name);
  TabController? _tabController;
  @override
  void initState() {
    super.initState();
    getSliderData();
  }
  double getHeight() {
    return 600;
  }
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
    return Scaffold(
      backgroundColor: Colors.white,
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
                        minHeight: 50,
                        maxHeight: 50,
                        child: Container(
                          color: Colors.green[200],
                          child: TabBar(
                            isScrollable: true,
                            labelColor: Colors.black87,
                            unselectedLabelColor: Colors.black87,
                            padding: EdgeInsets.fromLTRB(0,0,0,0),
                            indicator: BoxDecoration(
                              color: Colors.deepOrange,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(15.0),
                              ),
                            ),
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
                                        color: Colors.black87,
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
