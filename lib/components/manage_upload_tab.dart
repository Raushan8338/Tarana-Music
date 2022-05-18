import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tarana_app_live/components/list_tile.dart';
import 'package:tarana_app_live/components/progress_bar.dart';
import '../Profile/user_library/add_song_his.dart';
import '../Profile/user_library/create_album.dart';
import '../Profile/user_library/create_library.dart';
import '../auth_configFile/authconfig.dart';

class Manage_upload_placeholder extends StatelessWidget {
   String image,upload_type;
   Manage_upload_placeholder(this.image,this.upload_type, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            InkWell(
              onTap: (){
                Navigator.push(context,MaterialPageRoute(builder: (context)=>Create_album()));
              },
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  height: 40,
                  color: Colors.white12,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Icon(
                          Icons.cloud_upload_outlined,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),

                      Container(
                        width: 315,
                        height: 40,
                        color: Colors.transparent,
                        child: Center(
                          child: Text(
                            "Upload More",
                            style: TextStyle(
                                color: Colors.deepOrange,
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),

           SingleChildScrollView(
            //  physics:NeverScrollableScrollPhysics(),
              child: FutureBuilder(
                  future: getCategory_wise_album_List(user_id),
                  builder: (BuildContext context,
                      AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child: progress_bar());
                    }
                    return snapshot.data == null ?
                    Column(

                      children: [

                        Center(
                          child: Lottie.network(
                              image,width: 200),
                        ),

                        Text(
                          "No content uploaded. Tap to upload more.",
                          style: TextStyle(
                            color: Colors.white60,
                            fontSize: 14,
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            Navigator.push(context,MaterialPageRoute(builder: (context)=>Create_library()));
                          },
                          child: Container(
                            height: 37,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(5),
                              color: Color(0xffF65F22),
                            ),

                            child: Center(
                              child: Text(
                                "Upload",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight:
                                    FontWeight.bold
                                ),
                              ),
                            ),

                          ),
                        ),

                      ],
                    )

                   /* Center(
                      child: SizedBox(
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context,MaterialPageRoute(builder: (context)=>Create_album()));                        },
                          child: Card(
                            color: Colors.deepOrange,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Container(
                              height: 40,
                              margin: EdgeInsets.fromLTRB(22,22,22,0),
                              child: Center(
                                child: Text(
                                  "Create Library",
                                  style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )*/
                        : ListView.builder(
                        itemCount: snapshot.data.length,
                        shrinkWrap: true,
                        physics:ScrollPhysics(),
                        itemBuilder: (Context, ct) {
                          return GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> Add_song_history(snapshot.data[ct].movie_name,snapshot.data[ct].id,snapshot.data[ct].c_by,snapshot.data[ct].creator_name,snapshot.data[ct].creator_image,"")));
                            },
                            child: BuildListTile(
                                image:"https://www.itexpress4u.tech/taranaApi/assets/album_image/"+snapshot.data[ct].image,
                                song_id: "",
                                text:snapshot.data[ct].movie_name,
                                audio_video_type:"",
                                v_location:"",
                                v_name:"",
                                c_by:"",
                                c_name:"",
                                user_image:"",
                               // onTap : ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> Add_song_history(snapshot.data[ct].movie_name,snapshot.data[ct].id)))
                               )
                          );
                        });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
