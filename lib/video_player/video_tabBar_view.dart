import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarana_app_live/video_player/View_video_player.dart';
import 'package:tarana_app_live/pages/status_video.dart';
import 'package:video_player/video_player.dart';
import '../auth_configFile/authconfig.dart';
import 'package:http/http.dart' as http;

import '../components/header_component.dart';
class Video_tabBar_view extends StatefulWidget {
  const Video_tabBar_view({Key? key}) : super(key: key);
  @override
  _Video_tabBar_view createState() => _Video_tabBar_view();
}
String user_name_for='';
class _Video_tabBar_view extends State<Video_tabBar_view> {
  @override
  void initState() {
    super.initState();
    getSliderData();
    getUserDetails();
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
  getUserDetails () async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var user_names= sharedPreferences.getString("user_name");
    setState(() {
      user_name_for=user_names!;
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  DefaultTabController(
        length: category_list.length,
        child: Scaffold(
          backgroundColor: Colors.black87,
          body:Column(
            children: [
              TabBarView(
                children: category_list.map((e) {
                  return View_video_player(e['id']);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}