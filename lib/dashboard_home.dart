import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarana_app_live/auth_configFile/authconfig.dart';
import 'package:tarana_app_live/pages/status_video.dart';
import 'package:video_player/video_player.dart';
import 'Audio_player_File/album_profile.dart';
import 'Profile/user_library/status_upload_confirmation.dart';
import 'Welcome_files/splash.dart';
import 'components/header_component.dart';
import 'components/progress_bar.dart';
import 'pages/status_details_page.dart';
import 'home_design/creator_home_page.dart';
import 'home_design/home_dash_design.dart';
import 'model_class/status_user_item.dart';
import 'pages/notification.dart';

class Home_page_design extends StatefulWidget {
  const Home_page_design({Key? key}) : super(key: key);
  @override
  _Home_page_designState createState() => _Home_page_designState();
}
String current_user_id='';
String chose_category_name='',category_value='',chose_language_name='',language_value='',banner_image='',banner_image_name='',audio_file='';

class _Home_page_designState extends State<Home_page_design> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Remove the debug banner
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: Dashboard_home());
  }
}
class Dashboard_home extends StatefulWidget {
  const Dashboard_home({Key? key}) : super(key: key);
  @override
  _Dashboard_home createState() => _Dashboard_home();
}
String user_name_for='';
class _Dashboard_home extends State<Dashboard_home> {
  bool isSwitched = true;
  @override
  void initState() {
    super.initState();
    getDashboardData("");
    getUserDetails();
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
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          color: Colors.black87,
          height: size.height,
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: ClipPath(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Container(
                            child:   Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      User_name_component(),
                                      Row(
                                        children: [
                                          (is_creators == "1")?Header_toggle_view_buttom():SizedBox(),
                                          IconButton(
                                            onPressed: () {
                                              Navigator.push(context,MaterialPageRoute(builder: (context) => Notifications()));
                                            },
                                            icon: Icon(Icons.notifications,color: Colors.white,),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                    margin: EdgeInsets.fromLTRB(0,0,0,42),
                                    child:(is_creators == "1")?Creator_home_page(current_user_id): Dashboard_home_design(current_user_id)),
                              ],
                            ),
                          ),
                        )),
                  ),
                ],
              )
          ),
        ),
      ),
    );
  }
}