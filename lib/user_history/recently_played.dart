import 'package:flutter/material.dart';

import '../auth_configFile/authconfig.dart';
import '../components/progress_bar.dart';

class Recently_played_his extends StatefulWidget {
  const Recently_played_his({Key? key}) : super(key: key);

  @override
  _Recently_played_his createState() => _Recently_played_his();
}

class _Recently_played_his extends State<Recently_played_his> {

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
            child: Text(
              "Recent History",
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
            future: recently_played_song(),
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
                    return Container(
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
                    );
                  }
              );
            },

          )
        ));
  }
}
