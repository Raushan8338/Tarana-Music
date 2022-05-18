import 'package:flutter/material.dart';
import 'package:tarana_app_live/auth_configFile/authconfig.dart';
import 'package:video_player/video_player.dart';

import '../components/cached_network_image.dart';
import '../model_class/video_display_item.dart';
import 'video_details_page.dart';
class View_video_player extends StatefulWidget {
  String category_value;
  View_video_player(this.category_value, {Key? key}) : super(key: key);
  @override
  _View_video_player createState() => _View_video_player(this.category_value);
}

class _View_video_player extends State<View_video_player> {
  String category_value;
  _View_video_player(this.category_value);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black87,
      body: SingleChildScrollView(
       child: SafeArea(
         child: Container(
          width: MediaQuery.of(context).size.width,
          child: FutureBuilder<VideoDisplayItem>(
              future: getVideo_List(category_value),
              builder: (context,snapshot){
                return Column(
                    children: List.generate(
                        snapshot.data?.catagoryWiseVideoList.length??0,
                            (index) =>
                            SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: (snapshot.data!.catagoryWiseVideoList[index].catagoryType =='2')
                                    ? Column(
                                      mainAxisSize: MainAxisSize.min,
                                     children: List.generate(snapshot.data?.catagoryWiseVideoList[index].videos.length??0, (i) =>
                                      GestureDetector(
                                        onTap: (){
                                          Navigator.push(context,MaterialPageRoute(builder: (context) => Video_details_page(snapshot.data!.catagoryWiseVideoList[index].catagoryName,snapshot.data!.catagoryWiseVideoList[index].videos[i].file_name,snapshot.data!.catagoryWiseVideoList[index].videos[i].id,snapshot.data!.catagoryWiseVideoList[index].videos[i].userImage,snapshot.data!.catagoryWiseVideoList[index].videos[i].name)));
                                        },
                                        child:  Stack(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Container (
                                                  height: 200,
                                                  width: MediaQuery.of(context).size.width/1.05,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(12),
                                                    color: Colors.white,
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            snapshot.data!.catagoryWiseVideoList[index].videos[i].image),
                                                        fit:BoxFit.fitWidth ),
                                                  ),
                                                  child: Align(
                                                      alignment: Alignment.bottomCenter,
                                                      child: Container(
                                                        height: 50,
                                                        decoration: BoxDecoration(
                                                          gradient: LinearGradient(
                                                            colors: [Color(
                                                                0x56000000), Color(
                                                                0x56000000)],
                                                            begin: Alignment.bottomRight,
                                                            end: Alignment.topRight,
                                                          ),
                                                          borderRadius: BorderRadius.only(topRight:Radius.circular(15),topLeft: Radius.circular(15),bottomLeft: Radius.circular(12),bottomRight: Radius.circular(12)),
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [

                                                            Row(
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets.fromLTRB(4,4,0,4),
                                                                    child: Cached_Network_Image(Base_url().image_profile_url+snapshot.data!.catagoryWiseVideoList[index].videos[i].userImage,43,43,50),
                                                                    /*CircleAvatar(
                                                                      radius: 35 / 2,
                                                                      backgroundImage: NetworkImage(
                                                                        snapshot.data!.catagoryWiseVideoList[index].videos[i].thumbnail,),
                                                                    ),*/
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    children: [
                                                                      Text(
                                                                        snapshot.data!.catagoryWiseVideoList[index].videos[i].name,
                                                                        style: TextStyle(
                                                                            color: Colors.white,
                                                                            fontSize: 15,
                                                                            fontWeight: FontWeight.bold),
                                                                      ),
                                                                      Text(
                                                                        "AR Rahman- 12.1M Views",
                                                                        style: TextStyle(
                                                                          color: Colors.white54,
                                                                          fontSize: 12,
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ]),
                                                            Row(
                                                              children: [
                                                                Icon(
                                                                  Icons.file_download,
                                                                  color: Colors.white,
                                                                ),
                                                                Icon(
                                                                  Icons.more_vert,
                                                                  color: Colors.white,
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ))),
                                            ),
                                            Positioned(
                                              top: 0,
                                              right: 0,
                                              left: 0,
                                              bottom: 0,
                                              child: Icon(
                                                Icons.play_circle_fill,
                                                size: 30,
                                                color: Colors.orange,
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                  ),
                                ):
                                Container(
                                  // color: Colors.deepOrange,
                                  margin: EdgeInsets.fromLTRB(18,8,8,8),
                                  child: Row(
                                    children: List.generate(snapshot.data?.catagoryWiseVideoList[index].videos.length??0, (i) =>
                                        Column(
                                          children: [
                                            GestureDetector(
                                                onTap: (){
                                                  Navigator.push(context,MaterialPageRoute(builder: (context) => Video_details_page(snapshot.data!.catagoryWiseVideoList[index].catagoryName,snapshot.data!.catagoryWiseVideoList[index].videos[i].file_name,snapshot.data!.catagoryWiseVideoList[index].videos[i].id,snapshot.data!.catagoryWiseVideoList[index].videos[i].userImage,snapshot.data!.catagoryWiseVideoList[index].videos[i].name)));
                                                },
                                                child:  Stack(
                                                      children: [
                                                      Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                  child: Container (
                                                      height: 200,
                                                      width: MediaQuery.of(context).size.width/2,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(12),
                                                        color: Colors.white,
                                                        image: DecorationImage(
                                                            image: NetworkImage(
                                                                snapshot.data!.catagoryWiseVideoList[index].videos[i].image),
                                                            fit:BoxFit.fitWidth ),
                                                      ),
                                                      child: Align(
                                                          alignment: Alignment.bottomCenter,
                                                          child: Container(
                                                            height: 50,
                                                            width: MediaQuery.of(context).size.width,
                                                            decoration: BoxDecoration(
                                                              gradient: LinearGradient(
                                                                colors: [Color(
                                                                    0x56000000), Color(
                                                                    0x56000000)],
                                                                begin: Alignment.bottomRight,
                                                                end: Alignment.topRight,
                                                              ),
                                                              borderRadius: BorderRadius.only(topRight:Radius.circular(15),topLeft: Radius.circular(15),bottomLeft: Radius.circular(12),bottomRight: Radius.circular(12)),
                                                            ),
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Text(
                                                                  snapshot.data!.catagoryWiseVideoList[index].catagoryName,
                                                                  style: TextStyle(
                                                                      color: Colors.white,
                                                                      fontSize: 15,
                                                                      fontWeight: FontWeight.bold),
                                                                ),
                                                                Text(
                                                                  "AR Rahman- 12.1M Views",
                                                                  style: TextStyle(
                                                                    color: Colors.white54,
                                                                    fontSize: 12,
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ))),
                                                ),
                                                Positioned(
                                                  top: 0,
                                                  right: 0,
                                                  left: 0,
                                                  bottom: 0,
                                                  child: Icon(
                                                    Icons.play_circle_fill,
                                                    size: 30,
                                                    color: Colors.orange,
                                                  ),
                                                )
                                                ],
                                              ),

                                              /* Card(
                                                     child: ClipRRect(
                                                       borderRadius: const BorderRadius.all(
                                                           Radius.circular(5.0)),
                                                       child: Image.network(snapshot.data!.catagoryWiseVideoList[index].videos[i].thumbnail,
                                                         fit: BoxFit.cover,height: 95,),
                                                     ),
                                                     //   child: Image.network(snapshot.data!.catagoryWiseAlbumList[index1].album[i].image),
                                                   )*/
                                            ),
                                          ],
                                        )
                                      /*  Column(
                                       children: [
                                         GestureDetector(
                                             onTap: (){
                                               //  Navigator.push(context,MaterialPageRoute(builder: (context) => Album_profile(image_data: snapshot.data!.catagoryWiseAlbumList[index].album[i].image,catagoryName:snapshot.data!.catagoryWiseAlbumList[index].catagoryName,movie_title:snapshot.data!.catagoryWiseAlbumList[index].album[i].movieName,catagory_ids:snapshot.data!.catagoryWiseAlbumList[index].album[i].catagoryId)));
                                             },
                                             child: Expanded(
                                               child: Card(
                                                 color: Colors.transparent,
                                                 elevation: 1.0,
                                                 shape: RoundedRectangleBorder(
                                                   side: BorderSide(color: Colors.white70, width: 1),
                                                   borderRadius: BorderRadius.circular(10),
                                                 ),
                                                 child: ClipRRect(
                                                   borderRadius: const BorderRadius.all(
                                                       Radius.circular(5.0)),
                                                   child: Image.network(snapshot.data!.catagoryWiseVideoList[index].videos[i].thumbnail,
                                                     fit: BoxFit.cover,height: 95,),
                                                 ),
                                                 //   child: Image.network(snapshot.data!.catagoryWiseAlbumList[index1].album[i].image),
                                               ),
                                             )
                                         ),
                                         Text(snapshot.data!.catagoryWiseVideoList[index].videos[i].title,style: TextStyle(color: Colors.white,fontSize: 14)),
                                       ],
                                     )*/
                                    ),
                                  ),
                                )
                            )
                    )
                );
              })
      ),
    ),
  ),
);
}
}



/* Card(
                  color: Colors.transparent,
                  elevation: 0.5,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          /*Center(
                            child: _controller.value.isInitialized
                                ? AspectRatio(
                                aspectRatio: _controller.value.aspectRatio,
                                  child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: VideoPlayer(_controller)),
                            )
                                : Container(),
                          ),*/
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 88, 0, 85),
                            child: Align(
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.play_circle_fill,
                                size: 40,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(
                                    "https://usersbkp.s3.ap-south-1.amazonaws.com/ATTENDANCE_USERS_IMAGES/095523700_1628747120.jpg"),
                              ),
                            ),
                            Text(
                              "Aman Sharma",
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(95, 0, 5, 0),
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Icon(
                                        Icons.share,
                                        color: Colors.grey,
                                        size: 20,
                                      ),
                                      Text(
                                        "1K",
                                        style: TextStyle(color: Colors.white),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.favorite,
                                          color: Colors.grey,
                                          size: 20,
                                        ),
                                        Text(
                                          "90",
                                          style: TextStyle(color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.thumb_down_off_alt,
                                          color: Colors.grey,
                                          size: 20,
                                        ),
                                        Text(
                                          "20",
                                          style: TextStyle(color: Colors.white),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 2, 0, 0),
                    color: Colors.deepOrange,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            "Playlist for You",
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ),
                        Row(
                          children: [
                            Card(
                              color: Colors.transparent,
                              elevation: 0,
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Container(
                                  height: 140,
                                  width: 140,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Container(
                                          child: Icon(
                                            Icons.play_circle_fill,
                                            color: Colors.white,
                                            size: 30,
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              color: Colors.transparent,
                              elevation: 0,
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Container(
                                  height: 140,
                                  width: 140,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Container(
                                          child: Icon(
                                            Icons.play_circle_fill,
                                            color: Colors.white,
                                            size: 30,
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              color: Colors.transparent,
                              elevation: 0,
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Container(
                                  height: 140,
                                  width: 140,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Container(
                                          child: Icon(
                                            Icons.play_circle_fill,
                                            color: Colors.white,
                                            size: 30,
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              color: Colors.transparent,
                              elevation: 0,
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Container(
                                  height: 140,
                                  width: 140,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Container(
                                          child: Icon(
                                            Icons.play_circle_fill,
                                            color: Colors.white,
                                            size: 30,
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 17,
                        ),
                      ],
                    ),
                  ),
                ),*/