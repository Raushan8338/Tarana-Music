import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarana_app_live/Profile/user_library/create_library.dart';
import 'package:tarana_app_live/Welcome_files/splash.dart';

import '../Audio_player_File/album_profile.dart';
import '../auth_configFile/authconfig.dart';
import '../pages/chose_artist.dart';
import '../components/share_file.dart';
import '../components/update_profile_pic.dart';
import '../user_history/favorite_song_history.dart';
import '../user_history/recently_played.dart';
import 'musician_profile.dart';

class User_profile extends StatefulWidget {
  const User_profile({Key? key}) : super(key: key);

  @override
  _User_profile createState() => _User_profile();
}

class _User_profile extends State<User_profile> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // Remove the debug banner
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: User_profile_material());
  }
}

class User_profile_material extends StatefulWidget {
  const User_profile_material({Key? key}) : super(key: key);

  @override
  _User_profile_material createState() => _User_profile_material();
}

class _User_profile_material extends State<User_profile_material> {
  final ImagePicker _picker = ImagePicker();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    //User_details_dwidget();
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

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black87,
        appBar: AppBar(
          backgroundColor: Color(0xff14192A),
          elevation: 0,
          title: Text(
            "User Id " + tarana_ids,
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontFamily: 'poppins'),
          ),
          actions: [Share_file()],
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Stack(children: [
              Opacity(
                opacity: 0.5,
                child: ClipPath(
                  clipper: BottomWaveClipper(),
                  child: Container(
                    color: Colors.black87,
                    height: 830,
                  ),
                ),
              ),
              //
              ClipPath(
                  clipper: BottomWaveClipper(),
                  child: Container(
                    height: 780,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                          Colors.black87,
                              Colors.black87,
                              Colors.black87,
                              Colors.black87,

                        ])),
                  )),

              Column(
                  //  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: CircleAvatar(
                              radius: 75,
                              backgroundColor: Colors.deepOrange,
                              child: CircleAvatar(
                                  radius: 70,
                                  backgroundImage: NetworkImage(
                                      Base_url().image_profile_url +
                                          creator_images)
                                  // "https://usersbkp.s3.ap-south-1.amazonaws.com/ATTENDANCE_USERS_IMAGES/095523700_1628747120.jpg"),
                                  ),
                            ),
                          ),
                        ),
                        Update_profile_pic()
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(35, 5, 5, 5),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "${user_name}",
                              style: TextStyle(
                                  color: Colors.orange,
                                  fontSize: 25,
                                  fontFamily: 'poppins'),
                            ),
                            IconButton(
                                onPressed: () {
                                  //    Navigator.push(context, MaterialPageRoute(builder: (context)=>Edit_profile_info(creator_names,creator_dobs,creator_phones,creator_emails)));
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ))
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      child: (is_creators == '0')
                          ? Column(
                              children: [
                                Text("Normal Mode",
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    )),
                                TextButton(
                                  child: Text("Switch".toUpperCase(),
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: Colors.white,
                                      )),
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      side: const BorderSide(
                                        color: Colors.deepOrangeAccent,
                                      ),
                                    ),
                                  )),
                                  onPressed: () {
                                    /*  showModalBottomSheet(
                                context: context,
                                builder: (BuildContext bc) {
                                  return Container(
                                    height: 170,
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.all(
                                          10),
                                      child: Column(
                                        children: [
                                          InkWell(
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding: const EdgeInsets.all(10),
                                                child: Text(
                                                    "Switch to Creator", style: TextStyle(fontSize: 20,fontFamily: 'poppins'),
                                                ),
                                              ),
                                            ),
                                            onTap: (){
                                              switchUserToCreator ('1');
                                            },
                                          ),
                                          Divider(
                                            color: Colors.black,
                                          ),
                                          Align(
                                            alignment: Alignment
                                                .centerLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Text("Switch to Lyrics", style: TextStyle(fontSize: 20,fontFamily: 'poppins',color: Colors.grey),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );*/
                                  },
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                Container(
                                  width: 150,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Creator Mode",
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                          )),
                                      Container(
                                          margin:
                                              EdgeInsets.fromLTRB(8, 0, 0, 0),
                                          child: Icon(
                                            Icons.verified_outlined,
                                            color: Colors.green,
                                          ))
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 70,
                                  child: TextButton(
                                    child: Center(
                                      child: Text("Switch".toUpperCase(),
                                          style: const TextStyle(
                                            fontSize: 11,
                                            color: Colors.white,
                                          )),
                                    ),
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(7.0),
                                        side: const BorderSide(
                                          color: Colors.deepOrangeAccent,
                                        ),
                                      ),
                                    )),
                                    onPressed: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext bc) {
                                          return Container(
                                            height: 170,
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Column(
                                                children: [
                                                  InkWell(
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        child: Text(
                                                          "Switch to User Mode",
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontFamily:
                                                                  'poppins'),
                                                        ),
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      // switchUserToCreator ('0');
                                                    },
                                                  ),
                                                  Divider(
                                                    color: Colors.black,
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      child: Text(
                                                        "Switch to Lyrics",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontFamily:
                                                                'poppins',
                                                            color: Colors.grey),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                "creator_playlists",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                "Playlist",
                                style: TextStyle(
                                  color: Colors.deepOrangeAccent,
                                  fontSize: 13,
                                  fontFamily: 'poppins',
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 55,
                            child: VerticalDivider(
                              color: Colors.deepOrangeAccent,
                              thickness: 1,
                              indent: 7,
                              endIndent: 0,
                              width: 15,
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                "creator_followerss",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                "Followers",
                                style: TextStyle(
                                  color: Colors.deepOrangeAccent,
                                  fontSize: 13,
                                  fontFamily: 'poppins',
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 55,
                            child: VerticalDivider(
                              color: Colors.deepOrangeAccent,
                              thickness: 1,
                              indent: 7,
                              endIndent: 0,
                              width: 15,
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                "creator_followingss",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                "Followings",
                                style: TextStyle(
                                  color: Colors.deepOrangeAccent,
                                  fontSize: 13,
                                  fontFamily: 'poppins',
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Center(
                        child: (is_creators == '1')
                            ? InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Create_library()));
                                },
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(10, 5, 10, 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Upload History",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.upload_file),
                                        color: Colors.white,
                                        iconSize: 25,
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : SizedBox()),
                    SizedBox(
                      height: 0.5,
                      child: new Center(
                        child: new Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Recently_played_his()));
                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(10, 5, 10, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Recently Played",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.history_edu),
                              color: Colors.white,
                              iconSize: 25,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 0.5,
                      child: new Center(
                        child: new Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          color: Colors.white,
                        ),
                      ),
                    ),
                    /*  Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                              onPressed: (){
                                Navigator.pushReplacement(context,MaterialPageRoute(builder:(context) =>lib()
                                ));
                              }, child: Text("Your Library",
                            style: TextStyle(color: Colors.white,
                                fontSize: 20),)),
                          IconButton(onPressed: () {
                          },
                            icon: Icon(Icons.library_music),
                            color: Colors.white,
                            iconSize: 30,)],
                      ),
                    ),*/
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Favorite_played_his()));
                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(10, 5, 10, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Favorite Song",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.music_note_outlined),
                              color: Colors.white,
                              iconSize: 25,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 0.5,
                      child: new Center(
                        child: new Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 5, 10, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Favorite Artist",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Chose_artist()));
                            },
                            icon: Icon(Icons.person_sharp),
                            color: Colors.white,
                            iconSize: 25,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 0.5,
                      child: new Center(
                        child: new Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          color: Colors.white,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title:
                                const Text('Currently App version is 1.02.52'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'Cancel'),
                                child: const Text('Cancel'),
                              ),
                            ],
                          ),
                          // onTap: ()=>Logout(),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(10, 5, 10, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "App Version",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.workspaces_filled),
                              color: Colors.white,
                              iconSize: 25,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 0.5,
                      child: new Center(
                        child: new Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
                      child: InkWell(
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
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 5, 18, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Logout",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              Icon(
                                Icons.logout,
                                color: Colors.white,
                                size: 25,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ]),
              Container(
                child: (isLoading == true)
                    ? Positioned(
                        left: 0,
                        right: 0,
                        top: 0,
                        bottom: 0,
                        child: Container(
                          child: AlertDialog(
                            insetPadding: EdgeInsets.symmetric(horizontal: 90),
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircularProgressIndicatorApp(),
                                Text("Please wait...")
                              ],
                            ),
                          ),
                        ))
                    : SizedBox(),
              ),
            ]),
          ),
        ));
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    debugPrint(size.width.toString());
    var path = new Path();
    path.lineTo(0, size.height - 25);
    var firstStart = Offset(size.width / 4, size.height);
    var firstEnd = Offset(size.width / 2.25, size.height - 20.0);
    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);
    var secondStart =
        Offset(size.width - (size.width / 3.24), size.height - 60);
    var secondEnd = Offset(size.width, size.height - 20);
    path.quadraticBezierTo(
        secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);
    path.lineTo(size.width, size.height - 40);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
