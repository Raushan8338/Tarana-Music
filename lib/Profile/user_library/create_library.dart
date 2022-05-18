import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarana_app_live/Profile/user_library/create_album.dart';
import '../../auth_configFile/authconfig.dart';
import '../../components/progress_bar.dart';
import 'add_song_his.dart';

class Create_library extends StatefulWidget {
   Create_library({Key? key}) : super(key: key);

  @override
  _Create_library createState() => _Create_library();
}
String user_id='';
class _Create_library extends State<Create_library> {
  @override
  void initState(){
    super.initState();
    getSessiondata();
  }
  getSessiondata() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var user_ids= sharedPreferences.getString("user_id");
    setState(() {
      user_id=user_ids!;
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Your Album"),
        actions: [
          IconButton(
              onPressed: (){
                Navigator.push(context,MaterialPageRoute(builder: (context)=>Create_album()));
              },
              icon: Icon(Icons.upload_file))
        ],
      ),
      backgroundColor: Colors.black87,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          children: [
            FutureBuilder(
                future: getCategory_wise_album_List(user_id),
                builder: (BuildContext context,
                    AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: progress_bar());
                  }
                  return snapshot.data == null ? Center(
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
                  ): ListView.builder(
                      itemCount: snapshot.data.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (Context, ct) {
                        return GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> Add_song_history(snapshot.data[ct].movie_name,snapshot.data[ct].id,snapshot.data[ct].c_by,snapshot.data[ct].name,snapshot.data[ct].user_image,"")));
                          },
                          child: ListTile(
                            leading: Image.network(
                              "https://www.itexpress4u.tech/taranaApi/assets/album_image/"+snapshot.data[ct].image,
                              width: 43,
                              height: 43,

                            ),
                            title:  Text(
                              snapshot.data[ct].movie_name, style: TextStyle(
                                fontSize: 17,
                                color: Colors
                                    .white),
                            ),
                            subtitle:Text(
                                snapshot.data[ct].movie_name,
                                style: TextStyle(fontSize: 14, color: Colors.grey),
                                textAlign:
                                TextAlign
                                    .left) ,
                            trailing: Icon(Icons.more_vert,color: Colors.white,),

                          ),
                        );
                      });
                }),
          ],
        ),
      ),
    );
  }
}
