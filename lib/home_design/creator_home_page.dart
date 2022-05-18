import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../Audio_player_File/album_profile.dart';
import '../auth_configFile/authconfig.dart';
import '../components/cached_network_image.dart';
import '../components/download_file.dart';
import '../components/like_dislike_page.dart';
import '../components/progress_bar.dart';
import '../pages/status_details_page.dart';
import '../model_class/creator_home_page_item.dart';

class Creator_home_page extends StatefulWidget {
  String current_user_id;
   Creator_home_page(this.current_user_id, {Key? key}) : super(key: key);
  @override
  _Creator_home_pageState createState() => _Creator_home_pageState(this.current_user_id);
}

class _Creator_home_pageState extends State<Creator_home_page> {
  String current_user_id;
  _Creator_home_pageState(this.current_user_id);

  @override
  void initState() {
    super.initState();
    getCreator_dashboard_data();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Status_view(),
        SizedBox(
          height: 10,
        ),
        Container(
          child: FutureBuilder<CreatorHomePageItem>(
             future: getCreator_dashboard_data(),
             builder: (context,snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(child: progress_bar());
              }
              return snapshot.data == null ? Center(
                child: SizedBox(
                  child: Text("No Data Found",style: TextStyle(color: Colors.white,fontSize: 22),),
                ),
              ):
              Column(
                children: List.generate(snapshot.data?.catagoryWiseAlbumList.length??0, (index) =>
                  InkWell(
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context) =>Album_profile(image_data: snapshot.data!.catagoryWiseAlbumList[index].movie_image,catagoryName:snapshot.data!.catagoryWiseAlbumList[index].audioVideoType,movie_title:snapshot.data!.catagoryWiseAlbumList[index].movieName,catagory_ids:snapshot.data!.catagoryWiseAlbumList[index].id,album_ids:snapshot.data!.catagoryWiseAlbumList[index].id,created_by_id:snapshot.data!.catagoryWiseAlbumList[index].id,creator_name:snapshot.data!.catagoryWiseAlbumList[index].name,creator_images:snapshot.data!.catagoryWiseAlbumList[index].userImage)));
                    },
                    child: Container(
                      margin: EdgeInsets.fromLTRB(12,0,12,8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white12),
                      child: Column(
                           children :  [
                            Container(
                              height: 180,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    image: NetworkImage(Base_url().album_image_url+snapshot.data!.catagoryWiseAlbumList[index].movie_image),fit: BoxFit.cover
                                  ),
                                  color: Colors.white12),
                              child:  Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: (snapshot.data!.catagoryWiseAlbumList[index].audioVideoType == '0')? Icon(
                                    Icons.music_note,
                                    color: Colors.white,
                                  ):
                                  (snapshot.data!.catagoryWiseAlbumList[index].audioVideoType == '1')? Icon(
                                    Icons.videocam,
                                    color: Colors.white,
                                   ) : Icon(
                                    Icons.my_library_books_sharp,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: RichText(
                                          overflow: TextOverflow.ellipsis,
                                          strutStyle: StrutStyle(fontSize: 18.0),
                                          text: TextSpan(
                                              style: TextStyle(color: Colors.white),
                                              text: snapshot.data!.catagoryWiseAlbumList[index].movieName),
                                        ),
                                      ),
                                      Text("10M Listeners",
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 16))
                                    ],
                                  ),
                                ),

                                Row(
                                  children: [
                                    Download_file(),
                                    IconButton(
                                        onPressed: () {

                                        },
                                        icon: Icon(
                                          Icons.more_vert,
                                          color: Colors.white,
                                        )),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Cached_Network_Image(Base_url().image_profile_url+snapshot.data!.catagoryWiseAlbumList[index].userImage,38,38,8)
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data!.catagoryWiseAlbumList[index].name,
                                          style: TextStyle(color: Colors.white,fontSize: 15),
                                        ),
                                        Text(
                                          "ar_rahman",
                                          style: TextStyle(color: Colors.white54,fontSize: 12),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0,0,12,0),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InkWell(
                                          onTap: (){
                                          },
                                          child: Like_dislike_page("album",snapshot.data!.catagoryWiseAlbumList[index].id,snapshot.data!.catagoryWiseAlbumList[index].audioVideoType),
                                        ),
                                      ),
                                     /* Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InkWell(
                                          onTap: (){
                                          },
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.comment,
                                                color: Colors.white,
                                                size: 16,
                                              ),
                                              Text(
                                                snapshot.data!.catagoryWiseAlbumList[index].dislikeBy,
                                                style: TextStyle(color: Colors.white),
                                              )
                                            ],
                                          ),
                                        ),
                                      )*/
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                ),
                    ),
                  ))

              );
             },
          )
        ),

      ],
    );
  }
}
