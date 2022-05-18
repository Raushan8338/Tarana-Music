import 'package:flutter/material.dart';

import '../Profile/creator_song_profile.dart';
import '../auth_configFile/authconfig.dart';
import '../components/progress_bar.dart';

class Follower_following_details extends StatefulWidget {
  String page_type;
  Follower_following_details(this.page_type, {Key? key}) : super(key: key);

  @override
  _follower_following_details createState() => _follower_following_details(this.page_type);
}

class _follower_following_details extends State<Follower_following_details> {
  String page_type;
  _follower_following_details(this.page_type);
  @override
  void initState() {
    super.initState();
    recently_played_song();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black87,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          actions: [],
          centerTitle: true,
          title: Center(
            child: (page_type=="0")?Text(
              "Follower List",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20),
            ):Text(
              "Following List",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20),
            )
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
            child: FutureBuilder(
              future: folower_following_data(page_type),
              //initialData: null,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(child: progress_bar());
                }
                return snapshot.data == null ? Center(
                  child: SizedBox(
                    child: Text("No Data Found",style: TextStyle(color: Colors.white,fontSize: 22),),
                  ),
                ):
                ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context,ct)

                    {
                      return InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Creator_song_profile(snapshot.data[ct].id,"")));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(Base_url().image_profile_url+snapshot.data[ct].image),
                            ),
                            title: Text(
                              snapshot.data[ct].name,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18),
                            ),
                          /*  subtitle: Text(
                              snapshot.data[ct].release_year,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14),
                            ),*/
                            trailing: Icon(
                              Icons.more_vert,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    }
                );
              },

            )
        ));
  }
}
