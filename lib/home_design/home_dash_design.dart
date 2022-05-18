import 'package:flutter/material.dart';
import '../Audio_player_File/album_profile.dart';
import '../Audio_player_File/notifier/service_locator.dart';
import '../Audio_player_File/page_manager.dart';
import '../Profile/creator_song_profile.dart';
import '../Welcome_files/splash.dart';
import '../auth_configFile/authconfig.dart';
import '../components/progress_bar.dart';
import '../components/slider_banner_page.dart';
import '../pages/status_details_page.dart';
import '../components/user_home_design.dart';
import '../model_class/CategoryList.dart';

class Dashboard_home_design extends StatefulWidget {
  String current_user_id;

  Dashboard_home_design(this.current_user_id, {Key? key}) : super(key: key);

  @override
  _Dashboard_home_designState createState() =>
      _Dashboard_home_designState(this.current_user_id);
}

class _Dashboard_home_designState extends State<Dashboard_home_design> {
  String current_user_id;

  _Dashboard_home_designState(this.current_user_id);

  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return Column(
      children: [
        Slider_banner_page(),
        Status_view(),
        Container(
          child: (is_creators == '0')
              ? SizedBox()
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(7),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Recent Uploaded",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: 'poppins'))),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        height: 140,
                        child: FutureBuilder(
                            future:
                                getCategory_wise_album_List(current_user_id),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(child: status_progress_bar());
                              }
                              return snapshot.hasError
                                  ? Center(
                                      child: SizedBox(),
                                    )
                                  : ListView.builder(
                                      itemCount: snapshot.data.length,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (Context, ct) {
                                        return GestureDetector(
                                          onTap: () {

                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => Album_profile(
                                                        image_data: snapshot
                                                            .data[ct].image,
                                                        catagoryName: snapshot
                                                            .data[ct]
                                                            .movie_name,
                                                        movie_title: snapshot
                                                            .data[ct]
                                                            .movie_name,
                                                        catagory_ids: snapshot
                                                            .data[ct]
                                                            .catagory_id,
                                                        album_ids: snapshot
                                                            .data[ct].id,
                                                        created_by_id: snapshot
                                                            .data[ct].c_by,
                                                        creator_name: snapshot
                                                            .data[ct]
                                                            .creator_name,
                                                        creator_images: snapshot
                                                            .data[ct]
                                                            .creator_image)));
                                            //  Navigator.push(context, MaterialPageRoute(builder: (context)=> User_status_video(snapshot.data[ct].video_url,snapshot.data[ct].created_time,snapshot.data[ct].name,snapshot.data[ct].image)));
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Container(
                                                  width: 115,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                8.0)),
                                                    child: Image.network(
                                                      Base_url()
                                                              .album_image_url +
                                                          snapshot
                                                              .data[ct].image,
                                                      fit: BoxFit.cover,
                                                      height: 95,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          2, 4, 0, 0),
                                                  child: RichText(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    strutStyle: StrutStyle(
                                                        fontSize: 14.0),
                                                    text: TextSpan(
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                        text: snapshot.data[ct]
                                                            .movie_name),
                                                  ),
                                                )
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
        ),
        Container(
          margin: EdgeInsets.fromLTRB(8, 0, 0, 0),
          child: FutureBuilder<CategoryList>(
            future: getDashboardData(""),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: progress_bar());
              }
              return snapshot.data == null
                  ? Center(
                      child: SizedBox(
                        child: Text(
                          "No Data Found",
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                      ),
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        snapshot.data?.catagoryWiseAlbumList.length ?? 0,
                        (index) => Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                    snapshot.data!.catagoryWiseAlbumList[index]
                                        .catagoryName,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontFamily: 'poppins')),
                              ),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(
                                    snapshot.data?.catagoryWiseAlbumList[index]
                                            .album.length ??
                                        0,
                                    (i) => Column(
                                          children: [
                                            (snapshot.data!.catagoryWiseAlbumList[index].catagory_type == '6') ? InkWell(
                                                onTap: () async {
                                                  await getIt<PageManager>().init(snapshot
                                                      .data!
                                                      .catagoryWiseAlbumList[
                                                  index]
                                                      .album[i]
                                                      .id,'Raushan',creator_image, "", '', "");

                                                  Navigator.push(context,
                                                          MaterialPageRoute(builder: (context) => Album_profile(image_data: snapshot.data!.catagoryWiseAlbumList[index].album[i].image, catagoryName: snapshot.data!.catagoryWiseAlbumList[index].catagoryName, movie_title: snapshot
                                                                      .data!
                                                                      .catagoryWiseAlbumList[
                                                                          index]
                                                                      .album[i]
                                                                      .movieName,
                                                                  catagory_ids: snapshot
                                                                      .data!
                                                                      .catagoryWiseAlbumList[
                                                                          index]
                                                                      .album[i]
                                                                      .catagoryId,
                                                                  album_ids: snapshot
                                                                      .data!
                                                                      .catagoryWiseAlbumList[
                                                                          index]
                                                                      .album[i]
                                                                      .id,
                                                                  created_by_id: snapshot
                                                                      .data!
                                                                      .catagoryWiseAlbumList[
                                                                          index]
                                                                      .album[i]
                                                                      .cBy,
                                                                  creator_name: snapshot
                                                                      .data!
                                                                      .catagoryWiseAlbumList[
                                                                          index]
                                                                      .album[i]
                                                                      .name,
                                                                  creator_images: snapshot
                                                                      .data!
                                                                      .catagoryWiseAlbumList[
                                                                          index]
                                                                      .album[i]
                                                                      .user_image)));
                                                    },
                                                    child: Home_design_pattern(125, 135, Base_url().album_image_url + snapshot.data!.catagoryWiseAlbumList[index].album[i].image,8, snapshot.data!.catagoryWiseAlbumList[index].album[i].audio_video_type))
                                                : Container(
                                                    child: (snapshot
                                                                .data!
                                                                .catagoryWiseAlbumList[
                                                                    index]
                                                                .catagory_type ==
                                                            '3')
                                                        ? InkWell(
                                                        onTap: () async {
                                                          await getIt<PageManager>().init(snapshot
                                                              .data!
                                                              .catagoryWiseAlbumList[
                                                          index]
                                                              .album[i]
                                                              .id,'Raushan',creator_image, "", '', "");
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) => Album_profile(
                                                                          image_data: snapshot.data!.catagoryWiseAlbumList[index]
                                                                              .album[
                                                                                  i]
                                                                              .image,
                                                                          catagoryName: snapshot
                                                                              .data!
                                                                              .catagoryWiseAlbumList[
                                                                                  index]
                                                                              .catagoryName,
                                                                          movie_title: snapshot
                                                                              .data!
                                                                              .catagoryWiseAlbumList[
                                                                                  index]
                                                                              .album[
                                                                                  i]
                                                                              .movieName,
                                                                          catagory_ids: snapshot
                                                                              .data!
                                                                              .catagoryWiseAlbumList[
                                                                                  index]
                                                                              .album[
                                                                                  i]
                                                                              .catagoryId,
                                                                          album_ids: snapshot
                                                                              .data!
                                                                              .catagoryWiseAlbumList[
                                                                                  index]
                                                                              .album[
                                                                                  i]
                                                                              .id,
                                                                          created_by_id: snapshot
                                                                              .data!
                                                                              .catagoryWiseAlbumList[
                                                                                  index]
                                                                              .album[
                                                                                  i]
                                                                              .cBy,
                                                                          creator_name: snapshot
                                                                              .data!
                                                                              .catagoryWiseAlbumList[
                                                                                  index]
                                                                              .album[
                                                                                  i]
                                                                              .name,
                                                                          creator_images: snapshot
                                                                              .data!
                                                                              .catagoryWiseAlbumList[index]
                                                                              .album[i]
                                                                              .user_image)));
                                                            },
                                                            child: Home_design_pattern(
                                                                160,
                                                                130,
                                                                Base_url()
                                                                        .album_image_url +
                                                                    snapshot
                                                                        .data!
                                                                        .catagoryWiseAlbumList[
                                                                            index]
                                                                        .album[
                                                                            i]
                                                                        .image,
                                                                8,
                                                                snapshot
                                                                    .data!
                                                                    .catagoryWiseAlbumList[
                                                                        index]
                                                                    .album[i]
                                                                    .audio_video_type))
                                                        : Container(
                                                            child: (snapshot
                                                                        .data!
                                                                        .catagoryWiseAlbumList[
                                                                            index]
                                                                        .catagory_type ==
                                                                    '3')
                                                                ? InkWell(
                                                                onTap: () async {
                                                                  await getIt<PageManager>().init(snapshot
                                                                      .data!
                                                                      .catagoryWiseAlbumList[
                                                                  index]
                                                                      .album[i]
                                                                      .id,'Raushan',creator_image, "", '', "");
                                                                      Navigator.push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                              builder: (context) => Album_profile(image_data: snapshot.data!.catagoryWiseAlbumList[index].album[i].image, catagoryName: snapshot.data!.catagoryWiseAlbumList[index].catagoryName, movie_title: snapshot.data!.catagoryWiseAlbumList[index].album[i].movieName, catagory_ids: snapshot.data!.catagoryWiseAlbumList[index].album[i].catagoryId, album_ids: snapshot.data!.catagoryWiseAlbumList[index].album[i].id, created_by_id: snapshot.data!.catagoryWiseAlbumList[index].album[i].cBy, creator_name: snapshot.data!.catagoryWiseAlbumList[index].album[i].name, creator_images: snapshot.data!.catagoryWiseAlbumList[index].album[i].user_image)));
                                                                    },
                                                                    child: Home_design_pattern(
                                                                        165,
                                                                        140,
                                                                        Base_url().album_image_url +
                                                                            snapshot
                                                                                .data!
                                                                                .catagoryWiseAlbumList[
                                                                                    index]
                                                                                .album[
                                                                                    i]
                                                                                .image,
                                                                        8,
                                                                        snapshot
                                                                            .data!
                                                                            .catagoryWiseAlbumList[
                                                                                index]
                                                                            .album[
                                                                                i]
                                                                            .audio_video_type))
                                                                : Container(
                                                                    child: (snapshot.data!.catagoryWiseAlbumList[index].catagory_type ==
                                                                            '4')
                                                                        ? InkWell(
                                                                        onTap: () async {
                                                                          await getIt<PageManager>().init(snapshot
                                                                              .data!
                                                                              .catagoryWiseAlbumList[
                                                                          index]
                                                                              .album[i]
                                                                              .id,'Raushan',creator_image, "", '', "");
                                                                              Navigator.push(context, MaterialPageRoute(builder: (context) => Creator_song_profile(snapshot.data!.catagoryWiseAlbumList[index].album[i].cBy, snapshot.data!.catagoryWiseAlbumList[index].album[i].catagoryId)));
                                                                            },
                                                                            child: Home_design_pattern(
                                                                                85,
                                                                                85,
                                                                                Base_url().singer_image_url + snapshot.data!.catagoryWiseAlbumList[index].album[i].image,
                                                                                55,
                                                                                snapshot.data!.catagoryWiseAlbumList[index].album[i].audio_video_type))
                                                                        : InkWell(
                                                                        onTap: () async {
                                                                          await getIt<PageManager>().init(snapshot
                                                                              .data!
                                                                              .catagoryWiseAlbumList[
                                                                          index]
                                                                              .album[i]
                                                                              .id,'Raushan',creator_image, "", '', "");
                                                                              Navigator.push(context, MaterialPageRoute(builder: (context) => Album_profile(image_data: snapshot.data!.catagoryWiseAlbumList[index].album[i].image, catagoryName: snapshot.data!.catagoryWiseAlbumList[index].catagoryName, movie_title: snapshot.data!.catagoryWiseAlbumList[index].album[i].movieName, catagory_ids: snapshot.data!.catagoryWiseAlbumList[index].album[i].catagoryId, album_ids: snapshot.data!.catagoryWiseAlbumList[index].album[i].id, created_by_id: snapshot.data!.catagoryWiseAlbumList[index].album[i].cBy, creator_name: snapshot.data!.catagoryWiseAlbumList[index].album[i].name, creator_images: snapshot.data!.catagoryWiseAlbumList[index].album[i].user_image)));
                                                                            },
                                                                            child: Home_design_pattern(150, 130, Base_url().album_image_url + snapshot.data!.catagoryWiseAlbumList[index].album[i].image, 8, snapshot.data!.catagoryWiseAlbumList[index].album[i].audio_video_type))),
                                                          )),
                                            //singer_image
                                            Container(
                                              width: 120,
                                              child: Center(
                                                child: RichText(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  strutStyle: StrutStyle(
                                                      fontSize: 14.0),
                                                  text: TextSpan(
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                      text: snapshot
                                                          .data!
                                                          .catagoryWiseAlbumList[
                                                              index]
                                                          .album[i]
                                                          .movieName),
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                              ),
                            )
                          ],
                        ),
                      ));
            },
          ),
        ),
      ],
    );
  }
}
