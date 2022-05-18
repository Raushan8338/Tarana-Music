import 'dart:collection';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarana_app_live/pages/chose_artist.dart';
import 'auth_configFile/authconfig.dart';
import 'components/progress_bar.dart';
import 'package:http/http.dart' as http;

class Related_song_list_item extends StatefulWidget {
   Related_song_list_item({Key? key}) : super(key: key);
  @override
  _Related_song_list_item createState() => _Related_song_list_item();
}
String cur_user_id='';
class _Related_song_list_item extends State<Related_song_list_item> {
  @override
  void initState() {
    super.initState();
    getLanguage_list();
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: FutureBuilder(
        future: getLanguage_list(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return  snapshot.data == null ? Center(
            child: SizedBox(
              child: Text("Please wait...",style: TextStyle(color: Colors.white,fontSize: 22),),
            ),
          ): GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 2/2,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0
            ),
            itemCount: snapshot.data.length,//CHANGED
            itemBuilder: (context, index) =>
                InkWell(
                  onTap: (){
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      margin: EdgeInsets.zero,
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 4,
                      child: Container(
                        decoration: BoxDecoration(
                          color:Colors.primaries[Random().nextInt(Colors.primaries.length)],
                        ),
                        // color: Colors.grey.withOpacity(hashSet.contains(snapshot.data[index].language) ? 1 : 0),
                        child: Card(
                          margin: EdgeInsets.zero,
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                          elevation: 0,
                          // color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                          child: Center(child: Text(snapshot.data[index].language,style: TextStyle(color: Colors.white),)),
                        ),
                      ),
                    ),
                  ),
                ),
          );
        },
      ),
    );
  }
}
