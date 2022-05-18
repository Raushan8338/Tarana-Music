import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarana_app_live/Profile/profile_details_page.dart';
import 'package:tarana_app_live/Profile/user_library/create_library.dart';
import 'package:tarana_app_live/Profile/user_profile.dart';
import 'package:tarana_app_live/Welcome_files/splash.dart';
import 'package:tarana_app_live/about_us.dart';

import '../Welcome_files/splash.dart';
import '../auth_configFile/authconfig.dart';
import '../pages/chose_artist.dart';
import '../components/header_component.dart';
import '../pages/download_data_list.dart';
import '../pages/follower_following_details.dart';
import '../user_history/favorite_song_history.dart';
import '../user_history/recently_played.dart';

class Musician_profile extends StatefulWidget {
  const Musician_profile({Key? key}) : super(key: key);

  @override
  _Musician_profileState createState() => _Musician_profileState();

}

String user_name = '',
    user_id = '',
    creator_names = '',
    tarana_ids = '',
    creator_images = '',
    creator_is_verifieds = '',
    creator_followerss = '',
    creator_playlists = '',
    creator_followingss = '',
    floowing_status = '',
    image_url = '',
    creator_emails = '',
    creator_phones = '',
    creator_dobs = '',
    is_creators_demo = '';

class _Musician_profileState extends State<Musician_profile> {
  bool isSwitched = false;
  final ImagePicker _picker = ImagePicker();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getUserDetails();
    Fetch_shared_pref_data();
    getDownload_list_count();
  }

  Logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('You have logged out successfully !'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => SplashPage("0", "switch_mode")),
              (Route<dynamic> route) => false,
            ),
            child: const Text('Ok'),
          ),
        ],
      ),
      // onTap: ()=>Logout(),
    );
    // exit(0);
    // Navigator.push(context,MaterialPageRoute(builder: (context) => SplashPage()));
  }

  getUserDetails() async {
    isLoading = true;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var user_ids = sharedPreferences.getString("user_id");
    print(user_id);
    Map data = {'user_id': user_ids};
    var jsonResponse = null;
    var response = await http
        .post(Uri.parse(Base_url().baseurl + 'user_details'), body: data);

    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print(jsonResponse);
      var creator_name = jsonResponse['name'];
      var creator_image = jsonResponse['image'];
      var creator_is_verified = jsonResponse['is_verified'];
      var creator_followers = jsonResponse['followers'];
      var creator_playlist = jsonResponse['playlist'];
      var creator_followings = jsonResponse['followings'];
      var already_followed = jsonResponse['already_followed'];
      var creator_email = jsonResponse['email'];
      var creator_phone = jsonResponse['phone'];
      var creator_dob = jsonResponse['dob'];
      var is_creator = jsonResponse['is_creator'];

      setState(() {
        isLoading = false;
        creator_names = creator_name;
        creator_images = creator_image;
        creator_is_verifieds = creator_is_verified;
        creator_followerss = creator_followers;
        creator_playlists = creator_playlist;
        creator_followingss = creator_followings;
        floowing_status = already_followed;
        creator_dobs = creator_dob;
        creator_emails = creator_email;
        creator_phones = creator_phone;
        is_creators_demo = is_creator;
      });
    }
  }

  Fetch_shared_pref_data() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var user_names = sharedPreferences.getString("user_name");
    var user_ids = sharedPreferences.getString("user_id");
    var tarana_id = sharedPreferences.getString("tarana_id");
    //print(is_creators);
    print("is_creators_sdfsdf");
    setState(() {
      user_name = user_names!;
      user_id = user_ids!;
      tarana_ids = tarana_id!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "User Id " + tarana_ids,
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
        actions: [
          Row(
            children: [
              Header_toggle_view_buttom(),
              /* PopupMenuButton(
                icon: Icon(Icons.more_vert,color: Colors.white,),  //don't specify icon if you want 3 dot menu
                itemBuilder: (context) => [
                  PopupMenuItem<int>(
                    value: 0,
                    child: Text("Setting",style: TextStyle(color: Colors.black87),),
                  ),
                  PopupMenuItem<int>(
                    value: 0,
                    child: Text("Setting",style: TextStyle(color: Colors.black87),),
                  ),
                  PopupMenuItem<int>(
                    value: 0,
                    child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.share,color: Colors.black87,size: 17,),
                      Text("Share",style: TextStyle(color: Colors.black87),),
                    ],
                   ),
                    onTap: (){
                      Share.share('hey! check out this new app https://play.google.com/store/search?q=pub%3ADivTag&c=apps', subject: 'DivTag Apps Link');
                    },
                  ),
                  PopupMenuItem<int>(
                    value: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.logout,color: Colors.black87,size: 17,),
                        Text("Logout",style: TextStyle(color: Colors.black87),),
                      ],
                    ),
                    onTap: (){

                    },
                  ),
                ],
                onSelected: (item) => {print(item)},
              )*/
              PopupMenuButton(
                color: Colors.black87,
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ), //don't specify icon if you want 3 dot menu
                itemBuilder: (context) => [
                  PopupMenuItem<int>(
                    value: 0,
                    child: InkWell(
                      child: Container(
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 5,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  User_profile()));
                                    },
                                    child: Icon(
                                      Icons.settings,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Settings",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                                size: 20,
                              )
                            ],
                          )),
                      onTap: () {
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) => Dialog(
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 20, bottom: 10),
                                        child: Text(
                                          "Coming Soon",
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ),
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 20),
                                          child: RaisedButton(
                                              padding: EdgeInsets.zero,
                                              child: Container(
                                                height: 25,
                                                width: 80,
                                                decoration: BoxDecoration(
                                                    color: Colors
                                                        .deepOrangeAccent),
                                                child: Center(
                                                    child: Text(
                                                  "Close",
                                                  style: TextStyle(
                                                      color: Colors.white70,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w900),
                                                )),
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              }))
                                    ])));
                      },
                    ),
                  ),
                  PopupMenuItem<int>(
                    value: 0,
                    child: InkWell(
                      child: Container(
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Icons.flag_outlined,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Report an Issue",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                                size: 20,
                              )
                            ],
                          )),
                      onTap: () {
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) => Dialog(
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 20, bottom: 10),
                                        child: Text(
                                          "Coming Soon",
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ),
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 20),
                                          child: RaisedButton(
                                              padding: EdgeInsets.zero,
                                              child: Container(
                                                height: 25,
                                                width: 80,
                                                decoration: BoxDecoration(
                                                    color: Colors
                                                        .deepOrangeAccent),
                                                child: Center(
                                                    child: Text(
                                                  "Close",
                                                  style: TextStyle(
                                                      color: Colors.white70,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w900),
                                                )),
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              }))
                                    ])));
                      },
                    ),
                  ),
                  PopupMenuItem<int>(
                    value: 0,
                    child: InkWell(
                      child: Container(
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Image.asset(
                                    'assets/images/logo.png',
                                    height: 20,
                                    width: 20,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "About Us",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                                size: 20,
                              )
                            ],
                          )),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => About_us()));
                      },
                    ),
                  ),
                  PopupMenuItem<int>(
                    value: 0,
                    child: InkWell(
                      child: Container(
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Icons.help,
                                    color: Colors.blueAccent,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Need Help",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                                size: 20,
                              )
                            ],
                          )),
                      onTap: () {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) => Dialog(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Text(
                                    "Mobile no.: 123456789",
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    "Mail: abcd@gmail.com",
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  child: Text(
                                    "Address: abc",
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: RaisedButton(
                                        padding: EdgeInsets.zero,
                                        child: Container(
                                          height: 25,
                                          width: 80,
                                          decoration: BoxDecoration(
                                              color: Colors.deepOrangeAccent),
                                          child: Center(
                                              child: Text(
                                            "Close",
                                            style: TextStyle(
                                                color: Colors.white70,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w900),
                                          )),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        }))
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  PopupMenuItem<int>(
                    value: 0,
                    child: InkWell(
                      child: Container(
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Icons.logout,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Log Out",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                                size: 20,
                              )
                            ],
                          )),
                      onTap: () {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text(
                                'Are you sure you want to logout the App !'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'Cancel'),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Navigator.push(context,MaterialPageRoute(builder: (context) => SplashPage()));
                                  Logout();
                                },
                                child: const Text('YES'),
                              ),
                            ],
                          ),
                          // onTap: ()=>Logout(),
                        );
                      },
                    ),
                  ),
                ],
                onSelected: (item) => {print(item)},
              )
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
          child: Column(
            children: [
              Container(
                  height: 100,
                  margin: EdgeInsets.fromLTRB(13, 0, 13, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white12,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${user_name}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap:(){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Follower_following_details("1")));
                                 },
                                  child: Container(
                                    height: 37,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Color(0xffF65F22),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          creator_followingss,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 50,
                                          child: VerticalDivider(
                                            color: Colors.white,
                                            thickness: 1,
                                            indent: 9,
                                            endIndent: 9,
                                            width: 10,
                                          ),
                                        ),
                                        Text(
                                          "Following",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  onTap:(){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Follower_following_details("0")));
                                  },
                                  child: Container(
                                    height: 37,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Color(0xffF65F22),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          creator_followerss,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 50,
                                          child: VerticalDivider(
                                            color: Colors.white,
                                            thickness: 1,
                                            indent: 9,
                                            endIndent: 9,
                                            width: 10,
                                          ),
                                        ),
                                        Text(
                                          "Followers",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Profile_details_page()));
                          },
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: CachedNetworkImage(
                                imageUrl: Base_url().image_profile_url +
                                    creator_images,
                                height: 65,
                                width: 65,
                                fit: BoxFit.cover,
                              )
                              // "https://usersbkp.s3.ap-south-1.amazonaws.com/ATTENDANCE_USERS_IMAGES/095523700_1628747120.jpg"),
                              ),
                        ),
                      ],
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 20, 0, 15),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Your Downloads",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Download_audio_file()));
                    },
                    child: Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white10),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.audiotrack,
                              color: Colors.white,
                              size: 28,
                            ),
                            Text(
                              "Audios",
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            Text(song_download_count,
                                style:
                                    TextStyle(color: Colors.white, fontSize: 15))
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Download_audio_file()));
                    },
                    child: Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white10),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Icon(
                              Icons.videocam,
                              color: Colors.white,
                              size: 30,
                            ),
                            Text(
                              "Videos",
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            Text(video_down_count,
                                style:
                                    TextStyle(color: Colors.white, fontSize: 15))
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Download_audio_file()));
                    },
                    child: Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white10),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Icon(
                              Icons.playlist_play,
                              color: Colors.white,
                              size: 30,
                            ),
                            Text(
                              "Playlists",
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            Text(playlist_down_count,
                                style:
                                    TextStyle(color: Colors.white, fontSize: 15))
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Download_audio_file()));
                    },
                    child: Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white10),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Icon(
                              Icons.collections_bookmark,
                              color: Colors.white,
                              size: 28,
                            ),
                            Text(
                              "Albums",
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            Text(album_download_count,
                                style:
                                    TextStyle(color: Colors.white, fontSize: 15))
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 20, 0, 15),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Your Activity",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              (is_creators == "1")?
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Profile_details_page()));
                },
                child: Container(
                  height: 40,
                  width: 340,
                  margin: EdgeInsets.fromLTRB(0, 0,0,10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.history,
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Manage upload",
                              style:
                              TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ):SizedBox(),

              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Recently_played_his()));
                },
                child: Container(
                  height: 40,
                  width: 340,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.history,
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Recent playlist",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Favorite_played_his()));
                },
                child: Container(
                  height: 40,
                  width: 340,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Favourite Song",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Chose_artist()));
                },
                child: Container(
                  height: 40,
                  width: 340,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.record_voice_over,
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Artist",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            /*  SizedBox(
                height: 10,
              ),
              Container(
                height: 40,
                width: 340,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.playlist_play,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Playlist",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
