import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarana_app_live/model_class/Select_fav_singer_model.dart';
import 'package:tarana_app_live/model_class/recently_played_item.dart';
import 'package:tarana_app_live/model_class/status_user_item.dart';
import 'package:tarana_app_live/model_class/video_display_item.dart';
import '../Welcome_files/splash.dart';
import '../dashboard_home.dart';
import '../model_class/CategoryList.dart';
import 'package:http/http.dart' as http;
import '../model_class/category_wise_album_item.dart';
import '../model_class/chat_details_item.dart';
import '../model_class/chat_user_model_item.dart';
import '../model_class/creator_home_page_item.dart';
import '../model_class/follower_following_user_list_item.dart';
import '../model_class/music_item.dart';
import '../model_class/notification_model_item.dart';
import '../model_class/select_lang_model.dart';
import '../model_class/song_category_list.dart';
class Base_url{
   String baseurl='https://www.itexpress4u.tech/taranaApi/MasterValue_Api/';
   String image_url="https://www.itexpress4u.tech/taranaApi/assets/song_banner/";
   String album_image_url="https://www.itexpress4u.tech/taranaApi/assets/album_image/";
   String singer_image_url="https://www.itexpress4u.tech/taranaApi/assets/singer_image/";
   String image_profile_url="https://www.itexpress4u.tech/taranaApi/assets/user_image/";
   String status_image="https://www.itexpress4u.tech/taranaApi/assets/user_status/";
   String banner_image="https://www.itexpress4u.tech/taranaApi/assets/banner_image/";
   String newBaseUrl='https://www.itexpress4u.tech/taranaApi/TaranaUser_Api/';
   String Video_file_location='https://www.itexpress4u.tech/taranaApi/assets/videos/';
}

Future<CategoryList> getDashboardData(String search_id) async {
  Map data = {
   'catagory_id':search_id
  };
  var jsonResponse = null;
  var response = await http.post(Uri.parse(
      Base_url().baseurl+'movie_album_catagoriwise'),
      body: data);
  print(Base_url().baseurl+'movie_album_catagoriwise');
  if (response.statusCode == 200) {
    jsonResponse = json.decode(response.body);
    print(jsonResponse);
   // print(CategoryList.fromJson(jsonResponse));
    return CategoryList.fromJson(jsonResponse);
  }
  else {
   // print(CategoryList.fromJson(jsonResponse));
    return CategoryList.fromJson(jsonResponse);
    // print(response.body);
  }
}
Future<StatusUserItem> getStatus_List() async {
  SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
  var users_id =sharedPreferences.getString('user_id');
  Map data = {
    'follower_id':users_id
  };
  print(data);
  print("response");
  var jsonResponse = null;
  var response = await http.post(Uri.parse(
      Base_url().baseurl + 'user_status'),
      body: data);
  print(Base_url().baseurl + 'user_status');

  if (response.statusCode == 200) {
    jsonResponse = json.decode(response.body);

    print(jsonResponse);
    return StatusUserItem.fromJson(jsonResponse);
  }
  else {
    return StatusUserItem.fromJson(jsonResponse);
  }
}
 Future<VideoDisplayItem> getVideo_List(catagory_id) async{
   Map data = {
     'catagory_id':catagory_id
   };
   var jsonResponse = null;
   var response = await http.post(Uri.parse("https://www.itexpress4u.tech/taranaApi/taranaVideo_Api/CatagoryWiseVideo"),
       body: data);
   print(data);

   if (response.statusCode == 200) {
     jsonResponse = json.decode(response.body);
     print(jsonResponse);
     print("data_dsfsdsdf");
     return VideoDisplayItem.fromJson(jsonResponse);
   }
   else {
     return VideoDisplayItem.fromJson(jsonResponse);
   }
}
String Session_user_data='',album_download_count='',song_download_count='',video_down_count='',playlist_down_count='';
getSesseionuserid() async {
  SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
  var users_id =sharedPreferences.getString('user_id');
  Session_user_data = users_id!;
}

 getCategory_wise_album_List(created_by) async {
  Map data = {
    'created_by':created_by
  };
  print(data);
  var jsonResponse = null;
  var response = await http.post(Uri.parse(
      Base_url().baseurl+'movie_album'),
      body: data);
  print(Base_url().baseurl+'movie_album');
  if (response.statusCode == 200) {
    print(response.body);
    jsonResponse = json.decode(response.body);
    var category_json_response = jsonResponse['movies_list'];
     List<Category_wise_album_list> category_album_list=[];
     for(var category_json_ in category_json_response){
       Category_wise_album_list category_wise_album_list=Category_wise_album_list(category_json_['id'], category_json_['movie_name'], category_json_['image'], category_json_['catagory_id'], category_json_['release_year'], "3e", category_json_['status'], category_json_['c_by'], category_json_['c_date'],category_json_['name'],category_json_['user_image']);
       category_album_list.add(category_wise_album_list);
     }
     return category_album_list;
  }
}
getNotificationData() async {
  Map data = {
  };
  var jsonResponse = null;
  var jsonResponses = null;
  var response = await http.post(Uri.parse(
      Base_url().baseurl+'notification'),
      body: data);
  if (response.statusCode == 200) {
    jsonResponses=jsonDecode(response.body);
    // print(jsonResponse);
    var notificatio_list = jsonResponses['notification_list'];
    List<Notification_model_item> notification_model=[];
    for(var list_data in notificatio_list){
      Notification_model_item notification_model_item=Notification_model_item(list_data['id'],list_data['notification_name'],list_data['notification_details'],list_data['value'],list_data['status'],list_data['created_at']);
      notification_model.add(notification_model_item);
    }
    return notification_model;
  }
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var user_names= sharedPreferences.getString("user_name");
  var user_ids= sharedPreferences.getString("user_id");
}


getChatListData() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var user_ids= sharedPreferences.getString("user_id");
  Map data = {
    'user_id':user_ids
  };
  var jsonResponses = null;
  print(data);
  print("sfdsfsdfsdfsdf");
  var response = await http.post(Uri.parse(
      Base_url().baseurl+'user_chat_list'),
      body: data);
  if (response.statusCode == 200) {
    jsonResponses=jsonDecode(response.body);
    // print(jsonResponse);
    var chat_user_list = jsonResponses['chats'];
    List<Chat_user_model_item> chat_model=[];
    for(var list_data in chat_user_list){
      Chat_user_model_item chat_model_item=Chat_user_model_item(list_data['name'],list_data['c_partner_id'],list_data['image'],list_data['unread']);
      chat_model.add(chat_model_item);
    }
    return chat_model;
  }
}

getChatHistory_Details(String c_partner_id) async{
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var user_ids= sharedPreferences.getString("user_id");
  Map data = {
    'user_id':user_ids,
    'c_partner_id':c_partner_id
  };
  var jsonResponses = null;


  var response = await http.post(Uri.parse(
      Base_url().baseurl+'user_chat_details'),
      body: data);

  if (response.statusCode == 200) {
    jsonResponses=jsonDecode(response.body);
    var chat_details_list = jsonResponses['text'];
    List<Chat_details_model_item> chat_details_model=[];
    for(var list_data in chat_details_list){
      Chat_details_model_item chat_model_details_item=Chat_details_model_item(list_data['send_by'],list_data['name'],list_data['message'],list_data['message_date_time']);
      chat_details_model.add(chat_model_details_item);
    }
    return chat_details_model;
  }
}
recently_played_song() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var user_ids= sharedPreferences.getString("user_id");
  Map data = {
    'user_id':user_ids
  };
  var jsonResponses = null;
  var response = await http.post(Uri.parse(
      'https://www.itexpress4u.tech/taranaApi/TaranaUser_Api/recently_playedBy_user'),
      body: data);
  if (response.statusCode == 200) {
    jsonResponses=jsonDecode(response.body);
    var recent_play_list = jsonResponses['no of songs'];
   // print(recent_play_list);
    List<Recently_played_item> recently_played_item=[];
    for(var list_data in recent_play_list){
      Recently_played_item recently_played_iteme=Recently_played_item(list_data['id'],list_data['cate_id'],list_data['singer_id'],list_data['lang_id'],list_data['movie_id'],list_data['colour']
          ,list_data['image'],list_data['file_name'],list_data['title'],list_data['release_year'],list_data['status'],list_data['c_by'],list_data['c_date']);
      recently_played_item.add(recently_played_iteme);
    }
    return recently_played_item;
  }
}
folower_following_data(page_type) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var user_ids= sharedPreferences.getString("user_id");
  Map data = {
    'user_id':user_ids
  };
  var jsonResponses = null;
  String page_url="";
  var ff_user_list;
  if(page_type=="1"){
    page_url="user_followings_details";
  }
  else {
    page_url="user_followers_details";
  }
  var response = await http.post(Uri.parse(
      Base_url().baseurl+page_url),
      body: data);
  if (response.statusCode == 200) {
    jsonResponses=jsonDecode(response.body);
    if(page_type=="1"){
      ff_user_list = jsonResponses['followings'];
    }
    else {
      ff_user_list = jsonResponses['followers'];
    }
    // print(recent_play_list);
    List<Follower_following_user_list_item> recently_ff_user_item=[];
    for(var list_data in ff_user_list){
      Follower_following_user_list_item follower_following_user_list_item=Follower_following_user_list_item(list_data['id'],list_data['name'],list_data['image']);
      recently_ff_user_item.add(follower_following_user_list_item);
    }
    return recently_ff_user_item;
  }
}


Favorite_song_played_item() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var user_ids= sharedPreferences.getString("user_id");
  Map data = {
    'user_id':user_ids
  };
  print(data);
  var jsonResponses = null;
  var response = await http.post(Uri.parse(
      'https://www.itexpress4u.tech/taranaApi/TaranaUser_Api/user_favourite_songs'),
      body: data);

  if (response.statusCode == 200) {
    jsonResponses=jsonDecode(response.body);
   // print(jsonResponses);
    var recent_fav_list = jsonResponses['favourite songs'];
    List<Recently_played_item> recently_favorite_item=[];
    for(var list_datas in recent_fav_list){
      Recently_played_item recently_played_iteme=Recently_played_item(list_datas['id'],list_datas['cate_id'],list_datas['singer_id'],list_datas['lang_id'],list_datas['movie_id'],list_datas['colour']
          ,list_datas['image'],list_datas['file_name'],list_datas['title'],list_datas['release_year'],list_datas['status'],list_datas['c_by'],list_datas['c_date']);
      recently_favorite_item.add(recently_played_iteme);
    }
    return recently_favorite_item;
  }
}

updateFollowerCount(album_user_id,current_user_id) async {
 // print(album_user_id+"--"+current_user_id+"--"+status);
  Map data = {
    'user_id':album_user_id,
    'current_user_id':current_user_id,
  };
  var jsonResponse = null;
  var response = await http.post(Uri.parse(
      Base_url().baseurl+'update_follower'),
      body: data);
  if (response.statusCode == 200) {
    jsonResponse = json.decode(response.body);
    print(jsonResponse);
  }
}

getsongCategory_list() async {
  Map data = {
  };
  var jsonResponses = null;
  var response = await http.post(Uri.parse(
      'https://www.itexpress4u.tech/taranaApi/MasterValue_Api/catagorylist'),
      body: data);
  if (response.statusCode == 200) {
    jsonResponses=jsonDecode(response.body);
    // print(jsonResponse);
    var song_category_list = jsonResponses['catagory_list'];
    List<Song_category_list_item> song_category_list_model=[];
    for(var list_data in song_category_list){
      Song_category_list_item song_category_list_item=Song_category_list_item(list_data['id'],list_data['catagory_name'],list_data['catagory_type']);
      song_category_list_model.add(song_category_list_item);
    }
    return song_category_list_model;
  }
}

List<Select_lang_model> select_lang =[];
List selecteddata=[];
getLanguage_list() async {
  Map data={
  };
  var jsonResponse=null;
  var response=await http.post(Uri.parse("https://www.itexpress4u.tech/taranaApi/MasterValue_Api/language_list"),body: data);
  print(response.body);
  if(response.statusCode==200){
    jsonResponse = json.decode(response.body);
    var streetsFromJson = jsonResponse['language_list'];
    print(jsonResponse);
    for (var u in streetsFromJson) {
      Select_lang_model user = Select_lang_model(u['id'], u['language'], u['status'],
          u['c_date']);
      select_lang.add(user);
    }
    // _isChecked = List<bool>.filled(select_lang.length, false);
    // print(select_lang.length);
    return select_lang;
  }
}

List<Select_fav_singer_model> select_fav_sing_lang =[];
List selected_sing_data=[];
getFavriote_sing_list() async {
  Map data={
  };
  var jsonResponse=null;
  var response=await http.post(Uri.parse("https://www.itexpress4u.tech/taranaApi/MasterValue_Api/singerslist"),body: data);
  print(response.body);
  if(response.statusCode==200){
    jsonResponse = json.decode(response.body);
    var streetsFromJsons = jsonResponse['singerslist'];
    for (var u_v in streetsFromJsons) {
      Select_fav_singer_model select_fav_singer_model = Select_fav_singer_model(u_v['id'], u_v['singer_name'], u_v['image']);
      select_fav_sing_lang.add(select_fav_singer_model);
    }
    // _isChecked = List<bool>.filled(select_lang.length, false);
    // print(select_lang.length);
    return select_fav_sing_lang;
  }
}

all_song_list(album_ids,audio_video_type,language,creator_id) async {
  Map data = {
    'movie_id':album_ids,
    'audio_video_type':audio_video_type,
    'lang_id':language,
    'singer_id':creator_id
  };
  print(data);
  print("category_json_response");
  var jsonResponse = null;
  var response = await http.post(Uri.parse('https://www.itexpress4u.tech/taranaApi/MasterValue_Api/songsList'),
      body: data);

  if (response.statusCode == 200) {
    jsonResponse = json.decode(response.body);
    var category_json_response = jsonResponse['songs_list'];
    print(category_json_response);
    List<Music> musics_list=[];
    for(var list_data in category_json_response){
      Music notification_model_item=Music(list_data['id'],list_data['title'],list_data['file_name'],list_data['image'],list_data['movie_name'],list_data['singer_name'],list_data['audio_video_type'],list_data['v_id'],list_data['v_location'],list_data['v_title']);
      musics_list.add(notification_model_item);
    }
    return musics_list;
  }

  /* final songRepository = getIt<TestClass>();
  var playlist = await songRepository.Test_details(album_ids);
    var category_json_response =playlist;
    List<Music> musics_list=[];
    for(var list_data in category_json_response){
      Music notification_model_item=Music(list_data['id'],list_data['title'],list_data['file_name'],list_data['image'],list_data['movie_name'],list_data['singer_name']);
      musics_list.add(notification_model_item);
    }
    return musics_list;*/
}

 Future<CreatorHomePageItem> getCreator_dashboard_data() async {
   Map data = {
     'user_id':Session_user_data
   };
   var jsonresponse=null;
   var response=await http.post(Uri.parse(Base_url().baseurl+'get_all_song_video_list'),body: data);
    print(Base_url().baseurl+'get_all_song_video_list');
   if(response.statusCode == 200){
     jsonresponse=jsonDecode(response.body);
     return CreatorHomePageItem.fromJson(jsonresponse);
   }
   else {
     return CreatorHomePageItem.fromJson(jsonresponse);
   }
   
}

getDownload_list_count() async {
  Map data ={
    'user_id':user_ids
  };
  var jsonResponse = null;
  var response = await http.post(Uri.parse(
      Base_url().baseurl+'user_downloads'),
      body: data);
  if (response.statusCode == 200) {
    print(response.body);
    jsonResponse = json.decode(response.body);
    album_download_count=jsonResponse['album'];
    song_download_count=jsonResponse['song'];
    video_down_count=jsonResponse['video'];
    playlist_down_count=jsonResponse['playlist'];
  }

}
