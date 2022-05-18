import 'dart:ui';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarana_app_live/Profile/user_library/Add_song_file.dart';

import '../../Audio_player_File/notifier/service_locator.dart';
import '../../Audio_player_File/page_manager.dart';
import '../../Audio_player_File/song_details_dialog.dart';
import '../../auth_configFile/authconfig.dart';
import '../../components/list_tile.dart';
import '../../components/progress_bar.dart';

class Add_song_history extends StatefulWidget {
  String movie_name,id,c_by,c_name,user_image,audio_video_type;
   Add_song_history(this.movie_name, this.id, this.c_by,this.c_name,this.user_image,this.audio_video_type,  {Key? key}) : super(key: key);
  @override
  _Add_song_history createState() => _Add_song_history(this.movie_name, this.id, this.c_by,this.c_name,this.user_image,this.audio_video_type);
}

class _Add_song_history extends State<Add_song_history> {
  String movie_name,id,c_by,c_name,user_image,audio_video_type;
  _Add_song_history(this.movie_name, this.id, this.c_by,this.c_name,this.user_image,this.audio_video_type);
  @override
  void initState() {
    super.initState();
    getIt<PageManager>().init(id,'','','','','');
  }

  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black87,
      appBar:(movie_name !="")?AppBar(
        title: Text(movie_name),
        actions: [],
      ):null,
      body: SingleChildScrollView(
        child: Column(
        children: [
          MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: FutureBuilder(
              future: all_song_list(id,"","",audio_video_type),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(child: progress_bar());
                }
                return snapshot.data == null ? Center(
                  child: SizedBox(
                    child: Text("No Data Found",style: TextStyle(color: Colors.white,fontSize: 22),),
                  ),
                ):
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics:NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Expanded(
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () async {
                              print(index);
                              pageManager.skipToQueueItem(index, snapshot.data[index].title);
                            },
                            child: BuildListTile(
                              image:Base_url().image_url+snapshot.data[index].image,
                              song_id:snapshot.data[index].id,
                              text:snapshot.data[index].title,
                              audio_video_type:snapshot.data[index].v_id,
                              v_location:snapshot.data[index].v_location,
                              v_name:snapshot.data[index].v_name,
                              c_by:c_by,
                              c_name:c_name,
                              user_image:user_image,

                              // onTap : ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> Add_song_history(snapshot.data[ct].movie_name,snapshot.data[ct].id)))
                            )

                           /* ListTile(
                              leading:
                              Image.network(Base_url().image_url+snapshot.data[index].image,width: 43,height: 43,),
                              title: Text(
                                snapshot.data[index].title,style: TextStyle(fontSize: 17,color: Colors.white
                              ),
                                //trailing: AddRemoveSongButtons(),
                              ),
                              subtitle:Text(
                                  snapshot.data[index].singer_name,
                                  style: TextStyle(fontSize: 14, color: Colors.grey),
                                  textAlign:
                                  TextAlign
                                      .left) ,
                              trailing: IconButton(icon: Icon(Icons.more_vert,color: Colors.white,),
                                onPressed: (){
                                  showCupertinoDialog(context: context,
                                      builder: (context){
                                        return Song_details_popup('','','','',"0");
                                      });
                                },),
                            ),*/
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: SizedBox(
                child: TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.deepOrange,
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Add_song_file(movie_name,id,audio_video_type)));
                    },
                    child: Card(
                      color: Colors.deepOrange,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      child: Container(
                        height: 42,
                        width: 150,
                        child: Center(
                          child: Text(
                            "Add songs",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ))),
          ),
        ]),
      ),
    );
  }
}