import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:tarana_app_live/Welcome_files/splash.dart';

class Add_to_favourite extends StatefulWidget {
  String current_song_id;
   Add_to_favourite(this.current_song_id, {Key? key}) : super(key: key);
  @override
  _Add_to_favouriteState createState() => _Add_to_favouriteState(this.current_song_id);
}

class _Add_to_favouriteState extends State<Add_to_favourite> {
  String current_song_id;
  _Add_to_favouriteState(this.current_song_id);
  bool is_favourite=false;

  @override
  void initState() {
    super.initState();
    Check_favorite_song(current_song_id);
  }

  Add_favorite_song(current_song_id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var user_ids= sharedPreferences.getString("user_id");
    Map data = {
      'user_id':user_ids,
      'song_id':current_song_id,
    };
    print(data);
    print("song_id");
    var jsonResponse = null;
    var response = await http.post(Uri.parse("https://www.itexpress4u.tech/taranaApi/TaranaUser_Api/user_favourite"),
        body: data);
    // print(Base_url().baseurl+'update_profile_image');
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print(jsonResponse);
      setState(() {
        is_favourite = true;
      });
    }
    else {
      setState(() {
        is_favourite = false;
      });

    }
  }
  Check_favorite_song(current_song_id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var user_ids= sharedPreferences.getString("user_id");
    Map data = {
      'user_id':user_ids,
      'song_id':current_song_id,
    };
   // print(data);
  //  print("song_id");
    var jsonResponse = null;
    var response = await http.post(Uri.parse("https://www.itexpress4u.tech/taranaApi/TaranaUser_Api/check_user_favourite"),
        body: data);
    // print(Base_url().baseurl+'update_profile_image');
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      var check_result=jsonResponse['check'];
      print(check_result);
      print("jsonResponse");
      setState(() {
        if(check_result==1){
          is_favourite = true;
        }
        else {
          is_favourite = false;
        }
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: ()
      {
        if (is_favourite) {
          setState(() {
            is_favourite = false;
              Add_favorite_song(current_song_id);
          });
        } else {
          setState(() {
            is_favourite = true;
             Add_favorite_song(current_song_id);
          });
        }
      },
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Icon(
          Icons.favorite,
          color: is_favourite ? Colors.red : Colors.grey,
          size: 30,
        ),
      ),
    );
  }
}

