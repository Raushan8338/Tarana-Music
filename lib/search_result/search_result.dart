import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Audio_player_File/album_profile.dart';
import '../Profile/creator_song_profile.dart';
import '../auth_configFile/authconfig.dart';
import '../components/progress_bar.dart';
import '../model_class/CategoryList.dart';
import '../model_class/music_item.dart';

class Search_result extends StatefulWidget {
  String _search_id, search_name,uiCategory;

  Search_result(this._search_id, this.search_name,this.uiCategory, {Key? key})
      : super(key: key);

  @override
  _Search_resultState createState() =>
      _Search_resultState(_search_id, search_name,uiCategory);
}

class _Search_resultState extends State<Search_result> {
  String _search_id, search_name,uiCategory;

  _Search_resultState(this._search_id, this.search_name,this.uiCategory);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Search result for '" + search_name + "'",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_sharp,
              color: Colors.white,
            )),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: FutureBuilder<CategoryList>(
            future: getDashboardData(_search_id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: progress_bar());
              }
              return snapshot.data == null
                  ? Container(
                        height: MediaQuery.of(context).size.height,
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 55),
                            child: Center(
                              child: SizedBox(
                                child: Text(
                                  "No Data Found",
                                  style: TextStyle(color: Colors.white, fontSize: 22),
                                ),
                              ),
                            ),
                      )
                  : Padding(
                   padding: const EdgeInsets.only(left: 20, right: 10),
                   child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      snapshot.data?.catagoryWiseAlbumList.length ?? 0,
                          (index) => Column(children: [
                        GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            // gridview slider
                            itemCount: snapshot
                                .data
                                ?.catagoryWiseAlbumList[index]
                                .album
                                .length,
                            gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: MediaQuery.of(context)
                                  .size
                                  .width /
                                  (MediaQuery.of(context).size.height /
                                      2),
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 15,
                            ),
                            itemBuilder: (context, ct) =>
                                InkWell(
                                  onTap: (){
                                    if(uiCategory=="1") {
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context) =>
                                              Creator_song_profile(
                                                  snapshot.data!
                                                      .catagoryWiseAlbumList[index]
                                                      .album[ct].cBy,
                                                  snapshot.data!
                                                      .catagoryWiseAlbumList[index]
                                                      .album[ct].id)));
                                    }
                                    else {
                                      Navigator.push(context,MaterialPageRoute(builder: (context) => Album_profile(image_data: snapshot.data!.catagoryWiseAlbumList[index].album[ct].image,catagoryName:snapshot.data!.catagoryWiseAlbumList[index].catagoryName,movie_title:snapshot.data!.catagoryWiseAlbumList[index].album[ct].movieName,catagory_ids:snapshot.data!.catagoryWiseAlbumList[index].album[ct].catagoryId,album_ids:snapshot.data!.catagoryWiseAlbumList[index].album[ct].id,created_by_id:snapshot.data!.catagoryWiseAlbumList[index].album[ct].cBy,creator_name:snapshot.data!.catagoryWiseAlbumList[index].album[ct].name,creator_images:snapshot.data!.catagoryWiseAlbumList[index].album[ct].user_image)));
                                    }

                                  },
                                  child: Stack(
                              children: [
                                  Positioned.fill(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(Base_url()
                                              .album_image_url +
                                              snapshot
                                                  .data!
                                                  .catagoryWiseAlbumList[
                                              index]
                                                  .album[ct]
                                                  .image),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned.fill(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.transparent,
                                            Colors.transparent,
                                            Colors.black54,
                                            Colors.black
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          stops: [0, 0, 0.8, 1],
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(0,0,0,18),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          mainAxisSize:
                                          MainAxisSize.max,
                                          mainAxisAlignment:
                                          MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              snapshot
                                                  .data!
                                                  .catagoryWiseAlbumList[
                                              index]
                                                  .album[ct]
                                                  .movieName,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight:
                                                  FontWeight.bold),
                                            ),

                                            // Text("50 Songs|10M Listeners",
                                            //   style: TextStyle(
                                            //     color: Colors.white,
                                            //     fontSize: 12,
                                            //   ),
                                            // )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                                ))
                      ]),
                    )),
              );
            },
          ),
        ),
      ),
    );
  }
}
