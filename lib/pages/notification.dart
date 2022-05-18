import 'dart:convert';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarana_app_live/auth_configFile/authconfig.dart';
import 'package:tarana_app_live/model_class/notification_model_item.dart';
import '../model_class/CategoryList.dart';
import '../Audio_player_File/album_profile.dart';
import '../components/commonUI.dart';
import '../components/progress_bar.dart';
class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);
  @override
  _Notofication createState()=> _Notofication();
}
String user_name='',user_id='';
class _Notofication extends State<Notifications> {
  @override
  void initState() {
    super.initState();
    getNotificationData();
  }

  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor:Colors.black87,
        elevation: 0,
        title: Text("Notification"),
      ),
        body: SafeArea(
          child: Container(
            color: Colors.black87,
            height: size.height,
          //  margin: EdgeInsets.fromLTRB(0, 0,0, 48),
          /*  decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/buttom_image.png"),
                fit: BoxFit.cover,
              ),
            ),*/
            child: Container(
              margin: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: FutureBuilder(
                      future: getNotificationData(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if(snapshot.connectionState == ConnectionState.waiting){
                          return Center(child: progress_bar());
                        }
                        return  snapshot.data == null ? Center(
                          child: SizedBox(
                            child: Text("No Data Found",style: TextStyle(color: Colors.white,fontSize: 22),),
                          ),
                        ): ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context,index) {
                           return Container(
                                   child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)
                                      ),
                                     child: Padding(
                                       padding: const EdgeInsets.all(10.0),
                                       child: Column(
                                           crossAxisAlignment:CrossAxisAlignment.start,
                                           children: [
                                           Padding(
                                             padding: const EdgeInsets.all(8.0),
                                             child: Row(
                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                               children: [
                                                 Text('Dear Siltu${user_name} ,'),
                                                 Text(snapshot.data[index].created_at),
                                               ],
                                             ),
                                           ),
                                           Padding(
                                             padding: const EdgeInsets.all(8.0),
                                             child: Text(snapshot.data[index].notification_name+' : '),
                                           ),
                                           Padding(
                                             padding: const EdgeInsets.all(8.0),
                                             child: Text(snapshot.data[index].notification_details),
                                           ),

                                         ],
                                       ),
                                     ),

                                   ),
                                );
                               }
                             );
                          }
                      ),
                  ),
                ],
              )
            ),
          ),
        ),
    );
  }
}

/// This is the stateless widget that the main application instantiates.
/*class CircularProgressIndicatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(   Text(snapshot.data[index].notification_name)
      backgroundColor: Colors.red,
      strokeWidth: 8,);
  }
}*//*
class User_category {
  final String catagory_name;
  User_category(this.catagory_name);
}
class User_category_album {
  final String movie_name;
  User_category_album(this.movie_name);
}
*/