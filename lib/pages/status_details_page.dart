import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tarana_app_live/components/progress_bar.dart';
import 'package:tarana_app_live/components/status_box.dart';
import 'package:video_player/video_player.dart';

import '../Profile/user_library/status_upload_confirmation.dart';
import '../auth_configFile/authconfig.dart';
import '../dashboard_home.dart';
import '../model_class/status_user_item.dart';
import 'status_video.dart';

String user_id_cur = '',
    cur_id = '',
    created_time_cur = '',
    total_view_cur = '',
    name_cur = '',
    image_cur = '';
String user_id = '', user_status_stat = '', user_status_stats_counts = '';

class Status_view extends StatefulWidget {
  Status_view({Key? key}) : super(key: key);

  @override
  _Status_viewState createState() => _Status_viewState();
}

class _Status_viewState extends State<Status_view> {
  final ImagePicker _picker = ImagePicker();
  bool _validate = false;
  late File imageFile;
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    //  getOwnStatuslist();
    getStatus_List();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(7),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Status",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'poppins'))),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                /*    Status_box_item(
                        '',
                        '','1'),*/
                    Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        height: 125,
                        child: FutureBuilder<StatusUserItem>(
                          future: getStatus_List(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: status_progress_bar());
                            }
                            return  InkWell(
                                    onTap: () async {
                                      if (snapshot.data!.userStatus.status == 'not_found') {
                                        final pickedFile =
                                            await _picker.pickImage(
                                          source: ImageSource.gallery,
                                          imageQuality: 80,
                                        );
                                        setState(() {
                                          banner_image_name =
                                              pickedFile!.name.toString();
                                          imageFile = File(pickedFile.path);
                                        });
                                        //  print(pickedFile!.name.toString());
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Status_upload_confirmation(
                                                        File(pickedFile!
                                                            .path))));
                                      } else {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    User_status_video(snapshot.data!.userStatus.user.media,
                                                        snapshot.data!.userStatus.user.name,
                                                        snapshot.data!.userStatus.user.userId)));
                                      }
                                    },
                                    child: Status_box_item(
                                        snapshot.data!.userStatus.user.media,
                                        snapshot.data!.userStatus.user.name,'1'));  SizedBox();
                          }
                        )
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        child: FutureBuilder<StatusUserItem>(
                            future: getStatus_List(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(child: status_progress_bar());
                              }
                              return snapshot.data == null
                                  ? Center(
                                      child: SizedBox(),
                                    )
                                  : Row(
                                      children: List.generate(
                                          snapshot.data?.followerStatus
                                                  .length ??
                                              0,
                                          (index) => InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            User_status_video(snapshot
                                                                .data!
                                                                .followerStatus[index]
                                                                .user
                                                                .media,
                                                                snapshot
                                                                    .data!
                                                                    .followerStatus[index]
                                                                    .user
                                                                    .name,
                                                                   snapshot
                                                                    .data!
                                                                    .followerStatus[index]
                                                                    .user.userId)));
                                              },
                                              child: Status_box_item(
                                                  snapshot
                                                      .data!
                                                      .followerStatus[index]
                                                      .user
                                                      .media,
                                                  snapshot
                                                      .data!
                                                      .followerStatus[index]
                                                      .user
                                                      .name,''))));
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Creator_status extends StatefulWidget {
  const Creator_status({Key? key}) : super(key: key);

  @override
  _Creator_statusState createState() => _Creator_statusState();
}

class _Creator_statusState extends State<Creator_status> {
  final ImagePicker _picker = ImagePicker();
  bool _validate = false;
  late File imageFile;
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    getStatus_List();
    // getStatus_List();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
              height: 95,
              child: FutureBuilder(
                  future: getStatus_List(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return status_progress_bar();
                    }
                    return snapshot.data == null
                        ? Center(
                            child: SizedBox(),
                          )
                        : ListView.builder(
                            itemCount: snapshot.data.followerStatus.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (Context, ct) {
                              return GestureDetector(
                                onTap: () {
                                  //  Navigator.push(context, MaterialPageRoute(builder: (context)=> User_status_video()));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(55)),
                                          child: CachedNetworkImage(
                                            imageUrl: Base_url().status_image +
                                                snapshot
                                                    .data!
                                                    .followerStatus[ct]
                                                    .user
                                                    .statusImage,
                                            width: 75,
                                            height: 75,
                                            fit: BoxFit.cover,
                                            errorWidget:
                                                (context, url, error) =>
                                                    Container(
                                              color: Colors.grey,
                                              height: 75,
                                              width: 75,
                                              child: ClipRRect(
                                                child: AspectRatio(
                                                  aspectRatio: 22 / 5,
                                                  child: Container(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                              );
                            });
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
