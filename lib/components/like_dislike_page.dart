import 'dart:convert';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:http/http.dart' as http;
import '../auth_configFile/authconfig.dart';
import '../pages/comment_box.dart';

class Like_dislike_page extends StatefulWidget {
   String album,id,audioVideoType;
   Like_dislike_page(this.album, this.id,this.audioVideoType, {Key? key}) : super(key: key);
  @override
  _Like_dislike_pageState createState() => _Like_dislike_pageState(this.album, this.id,this.audioVideoType);
}
/*int like_count='',dislike='';*/
int like_count=0,dislike=0,comment_count=0,user_response=0;
bool? is_liked;
class _Like_dislike_pageState extends State<Like_dislike_page> {
    String album,id,audioVideoType;
    _Like_dislike_pageState(this.album, this.id,this.audioVideoType);
    int _selected=0;
    @override
  void initState() {
    super.initState();
   // getSesseionuserid();
    LikeDislike_count();
  }

  LikeDislike_count() async {
      // print("fssdfsfsdfsdf");
      Map data = {
        'user_id':'1',
        'type_id':id,
        'type':album,
      };
      var jsonResponse = null;
      var response = await http.post(Uri.parse(
          Base_url().baseurl+'like_dislike_comment_count'),
          body: data);

      if (response.statusCode == 200) {
        jsonResponse = json.decode(response.body);
        print("fssdfsfsdfsdf");
        var count_result=jsonResponse['count_result'];
        user_response=count_result['user_response'];
        // is_liked = true;
        setState(() {
          if(user_response==1) {
              is_liked = true;
          }
          else {
              is_liked = false;
          }
          like_count=count_result['like_count'];
          dislike=count_result['dislike_count'];
          comment_count=count_result['comment_count'];

        });
      }
    }
  updateLikeDislikeCount(album_type,album_id,selected) async {
      Map like_data = {
        'user_id':"1",
        'type':album_type,
        'response':selected,
        'response_id':album_id,
      };
      var jsonResponse = null;

      var response = await http.post(Uri.parse(
          Base_url().newBaseUrl+'update_like_dislike'),
          body: like_data);
      print(like_data);
    //  print(response);
      print("sdfsdfsdfsdf");
      print(Base_url().newBaseUrl+'update_like_dislike');
      if (response.statusCode == 200) {
        jsonResponse = json.decode(response.body);
      //  print(jsonResponse);
        LikeDislike_count();
      //  print(is_liked);
      }
    }

  @override
  Widget build(BuildContext context) {
      return  Row(
        children: [
          InkWell(
            onTap: (){
              setState(() {
                is_liked = true;
                 updateLikeDislikeCount(album,id,"1");
              });
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                  20, 0, 20, 0),
              child: Column(
                children: [
                  Icon(
                    Icons.thumb_up_off_alt,
                    color: (is_liked == true)?Colors.deepOrange:Colors.white,
                    size: 22,
                  ),
                  Text(
                    '$like_count',
                    style: TextStyle(
                        color:Colors.white,
                        fontSize: 10),
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: (){
              setState(() {
                is_liked = false;
                updateLikeDislikeCount(album,id,"0");
              });
            },
            child: Padding(
              padding:  EdgeInsets.fromLTRB(
                  20, 0, 20, 0),
              child: Column(
                children: [
                  Icon(
                    Icons.thumb_down_alt_rounded,
                    color: (is_liked == false)?Colors.deepOrange:Colors.white,
                    size: 22,
                  ),
                  Text(
                    dislike.toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10),
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: (){
              showCupertinoModalPopup(
                  context: context,
                  builder: (context){
                    return Comment_box(album,id,audioVideoType);
                  });
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                  20, 0, 10, 0),
              child: Column(
                children: [
                  Icon(
                    Icons.forum,
                    color: Colors.white,
                    size: 22,
                  ),
                  Text(
                    comment_count.toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10),
                  )
                ],
              ),
            ),
          ),
        /*  FavoriteButton(
            isFavorite: is_liked,
            valueChanged: (_isFavorite) {
              setState(() {
                if(_isFavorite){
                  updateLikeDislikeCount(album,id,"1");
                }
                else {
                  updateLikeDislikeCount(album,id,"0");
                }
              });
              print('Is Favorite : $_isFavorite');
            },
          ),*/
        //  Text(is_liked.toString(),style: TextStyle(color: Colors.white),)
        ],
      );
    /*return Row(
      children: [
       *//*  Column(
           children: [
             Icon(Icons.thumb_up,size: 16,),
             Text("12", style: TextStyle(color:Colors.white,fontSize: 12)),
           ],
         ),
        Icon(Icons.thumb_down_off_alt),*//*
         _icon(_selected, icon: Icons.thumb_up),
        _icon(_selected, icon: Icons.thumb_down_off_alt),
      ],
    );*/
  }
  Widget _icon(int index, {required IconData icon}) {
    return Padding(
      padding: const EdgeInsets.all(9),
      child: InkWell(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: _selected == index ? Colors.red : null,
            ),
           // Text("12", style: TextStyle(color:Colors.white,fontSize: 12)),
          ],
        ),
        onTap: () => setState(
              () {
                _selected = index;
                updateLikeDislikeCount(album,id,_selected);
          },
        ),
      ),
    );
  }
}
