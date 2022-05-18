import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarana_app_live/Audio_player_File/page_manager.dart';
import '../Audio_player_File/album_profile.dart';
import '../Audio_player_File/notifier/service_locator.dart';
import '../Audio_player_File/song_list_item.dart';
import '../Welcome_files/splash.dart';
import '../auth_configFile/authconfig.dart';
import '../components/cached_network_image.dart';
import '../components/following_folloup_buttom.dart';
import '../components/progress_bar.dart';
import '../pages/status_details_page.dart';
import '../pages/creator_chat_user_list.dart';
import '../model_class/music_item.dart';
class Creator_song_profile extends StatefulWidget {
  String catagory_ids,album_ids;
  Creator_song_profile(this.catagory_ids,  this.album_ids, {Key? key}) : super(key: key);
  @override
  _Creator_song_profileState createState() => _Creator_song_profileState(this.catagory_ids,this.album_ids);
}

String creator_names = '',
    creator_image = '',
    creator_is_verifieds = '',
    creator_followerss = '',
    creator_playlists = '',
    creator_followingss = '',
    floowing_status = '';
class _Creator_song_profileState extends State<Creator_song_profile> {
  String created_by_id,album_ids;
  _Creator_song_profileState(this.created_by_id,this.album_ids);
  bool progress_status=false;
  @override
  void initState() {
    super.initState();
    getCategory_wise_album_List(created_by_id);
    Following_follow_button(floowing_status,created_by_id,0);
    getUserDetails();
  }

  getUserDetails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var users_id = sharedPreferences.getString('user_id');
    // print("sdfsdf"+users_id!);
    Map data = {
      'user_id': created_by_id,
      'current_user_id': users_id};
    var jsonResponse = null;
    var response = await http
        .post(Uri.parse(Base_url().baseurl + 'user_details'), body: data);
    // print("weFwfewf"+Base_url().baseurl+'user_details');
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      var creator_name = jsonResponse['name'];
      var creator_images = jsonResponse['image'];
      var creator_is_verified = jsonResponse['is_verified'];
      var creator_followers = jsonResponse['followers'];
      var creator_playlist = jsonResponse['playlist'];
      var creator_followings = jsonResponse['followings'];
      var already_followed = jsonResponse['already_followed'];
      setState(() {
        progress_status=true;
        creator_names = creator_name;
        creator_image = creator_images;
        creator_is_verifieds = creator_is_verified;
        creator_followerss = creator_followers;
        creator_playlists = creator_playlist;
        creator_followingss = creator_followings;
        floowing_status = already_followed;
        // getIt<TestClass>().Test_details(album_ids);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor:Color(0xffaa6a12),
            elevation: 0,
            actions: [
              Icon(
                Icons.more_vert,
                color: Colors.white,
                size: 22,
              )
            ],
          ),
          backgroundColor: Colors.black87,
          body: (progress_status=false)?SizedBox(
            height: MediaQuery.of(context).size.height / 1.3,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ):CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Stack(
                      children: [
                        Container(
                          decoration: new BoxDecoration(
                              color: Color(0xffaa6a12),
                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(12),bottomLeft:  Radius.circular(12))
                          ),
                          height: 185,
                          child: Padding(
                            padding:  EdgeInsets.fromLTRB(12,5,12,8),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              creator_names,
                                              style: TextStyle(color: Colors.white, fontSize: 18),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Icon(
                                              Icons.check_circle,
                                              color: Colors.blueAccent,
                                              size: 18,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          "Music Composer-Singer",
                                          style: TextStyle(color: Colors.white, fontSize: 12),
                                        ),
                                      ],
                                    ),
                                    (is_creators =='1')?
                                    Container(
                                      height: 37,
                                      width: 180,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.black12,
                                      ),
                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Request for Collabaration",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ])
                                    ):SizedBox()
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(12,62,0,0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 160,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.cyan,
                                  image: DecorationImage(
                                      image: NetworkImage(Base_url().image_profile_url+creator_image),
                                      fit: BoxFit.cover
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(15),
                                                color: Colors.black12,
                                              ),
                                              height: 35,
                                              width: 100,
                                              child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.groups,
                                                      color: Colors.white,
                                                      size: 20,
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.fromLTRB(8,0,0,0),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Text(
                                                            creator_followerss,
                                                            style: TextStyle(
                                                                color: Colors.white, fontSize: 11,fontWeight: FontWeight.bold),
                                                          ),
                                                          Text(
                                                            "Followers",
                                                            style: TextStyle(
                                                                color: Colors.white, fontSize: 11,fontWeight: FontWeight.bold),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ])),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 35,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15),
                                              color: Colors.black12,
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.headphones,
                                                  color: Colors.white,
                                                  size: 20,
                                                ),
                                                Container(
                                                  margin: EdgeInsets.fromLTRB(8,0,0,0),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        "10M",
                                                        style: TextStyle(
                                                            color: Colors.white, fontSize: 11,fontWeight: FontWeight.bold),
                                                      ),
                                                      Text(
                                                        "Songs",
                                                        style: TextStyle(
                                                            color: Colors.white, fontSize: 11,fontWeight: FontWeight.bold),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                              height: 37,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(15),
                                                color: Colors.black12,
                                              ),
                                              child:Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.person_add_alt_1,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                  Following_follow_button(floowing_status,created_by_id,0),
                                                ],
                                              )),
                                        ),
                                        (is_creators =='1')?InkWell(
                                          onTap: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Creator_chat(Base_url().image_profile_url+creator_image)));
                                          },
                                          child:   Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              height: 37,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(15),
                                                color: Colors.black12,
                                              ),
                                              child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.mail_outline,
                                                      color: Colors.white,
                                                      size: 20,
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.fromLTRB(8,0,0,0),
                                                      child: Text(
                                                        "Message",
                                                        style:
                                                        TextStyle(color: Colors.white, fontSize: 13),
                                                      ),
                                                    )
                                                  ]),
                                            ),
                                          ),):SizedBox(width: 115)
                                      ],
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0,15,15,0),
                                      child: IconButton(onPressed: (){
                                        Share.share('hey! check out this new app https://play.google.com/store/search?q=pub%3ADivTag&c=apps', subject: 'DivTag Apps Link');
                                      },
                                        icon:  Icon(
                                          Icons.share_outlined,
                                          color: Colors.white,
                                          size: 20,
                                        ),),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                        child: Text(
                          'Status',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Creator_status(),
                    Container(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              DefaultTabController(
                                  length: 3,
                                  child: Column(
                                      children: <Widget>[
                                        Container(
                                            height: 37,
                                            decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                borderRadius: BorderRadius.circular(20)
                                            ),

                                            child: TabBar(
                                                indicator: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(50),
                                                    border: Border.all(
                                                        color: Colors.deepOrange,
                                                        width: 1
                                                    )
                                                ),
                                                isScrollable: true,
                                                tabs: [
                                                  Tab(
                                                    child: Container(
                                                      height: 37,
                                                      width: 90,
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
                                                              fontWeight: FontWeight.bold
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),

                                                  Tab(
                                                    child: Container(
                                                      height: 37,
                                                      width: 90,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.circular(20),
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
                                                      width: 90,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.circular(20),
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
                                                ]
                                            )
                                        ),

                                        ListTile(
                                          leading: Text(
                                            "Songs",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),

                                          trailing: Wrap(
                                            spacing: 12,
                                            children: <Widget>[
                                              Icon(
                                                Icons.download_outlined,
                                                color: Colors.white,
                                                size: 25,
                                              ),

                                              Icon(
                                                Icons.play_circle_fill,
                                                color: Colors.orange,
                                                size: 25,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                            height: MediaQuery.of(context).size.height,
                                            child: TabBarView(children: <Widget>[
                                              Song_list_item(album_ids:album_ids,audio_video_type:"",language:"",creator_id:created_by_id,creator_name:creator_names,creator_image:creator_image),
                                              Song_list_item(album_ids:album_ids,audio_video_type:"0",language:"",creator_id:created_by_id,creator_name:creator_names,creator_image:creator_image),
                                              Song_list_item(album_ids:album_ids,audio_video_type:"1",language:"",creator_id:created_by_id,creator_name:creator_names,creator_image:creator_image),
                                          /*    Text(""),
                                              Text(""),
                                              Text(""),*/
                                            ]
                                            )
                                        )
                                      ]
                                  )
                              )
                            ]
                        )
                    ),
                    ListTile(
                      leading: Text(
                        "Albums",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    FutureBuilder(
                      future: getCategory_wise_album_List(album_ids),
                      builder:
                          (BuildContext context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData)
                          return SafeArea(
                            //  child: Text("dfsdf"),
                              child: Center(child: progress_bar()));
                        return Flexible(
                            child: GridView.builder(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 2/2,
                                  crossAxisSpacing: 4.0,
                                  mainAxisSpacing: 4.0
                              ),
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data.length,//CHANGED
                              itemBuilder: (context, i) =>
                                  InkWell(
                                    onTap: (){
                                      Navigator.push(context,MaterialPageRoute(builder: (context) => Album_profile(image_data: snapshot.data[i].image,catagoryName:snapshot.data[i].movie_name,movie_title:snapshot.data[i].movie_name,catagory_ids:album_ids,album_ids:snapshot.data[i].id,created_by_id:snapshot.data[i].c_by,creator_name: "",creator_images: "",)));
                                    },
                                    child:  Column(
                                      children: [
                                        Cached_Network_Image(Base_url().album_image_url+
                                            snapshot.data[i].image,90,90,8),
                                        Center(child: Text(snapshot.data[i].movie_name,style: TextStyle(color: Colors.white),))
                                      ],
                                    ),
                                  ),
                            )
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          )
      ),
    );
  }
}
