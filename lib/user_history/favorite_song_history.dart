import 'package:flutter/material.dart';

import '../Audio_player_File/notifier/service_locator.dart';
import '../Audio_player_File/page_manager.dart';
import '../auth_configFile/authconfig.dart';
import '../components/progress_bar.dart';

class Favorite_played_his extends StatefulWidget {
  const Favorite_played_his({Key? key}) : super(key: key);

  @override
  _Favorite_played_his createState() => _Favorite_played_his();
}

class _Favorite_played_his extends State<Favorite_played_his> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Favorite_song_played_item();
  }
  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
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
            child: Text(
              "Favorite Song History",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20),
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
            child: FutureBuilder(
              future: Favorite_song_played_item(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(child: progress_bar());
                }
                return snapshot.data == null ? Center(
                  child: SizedBox(
                    child: Text("No Data Found",style: TextStyle(color: Colors.white,fontSize: 22),),
                  ),
                ): ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context,ct)
                    {
                      return Container(
                        child: InkWell(
                          onTap: () async {
                            getIt<PageManager>().init(snapshot.data[ct].id,'','','','','');
                            pageManager.skipToQueueItem(ct,snapshot.data[ct].title );
                          },
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(snapshot.data[ct].image),
                            ),
                            title: Text(
                              snapshot.data[ct].title,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18),
                            ),
                            subtitle: Text(
                              snapshot.data[ct].release_year,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14),
                            ),
                            trailing: Icon(
                              Icons.music_video,
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
