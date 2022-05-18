import 'dart:convert';
import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarana_app_live/Welcome_files/splash.dart';
import '../auth_configFile/authconfig.dart';
import '../components/progress_bar.dart';
import '../model_class/comment_list_item.dart';

class Comment_box extends StatefulWidget {
  String album_type,id,audioVideoType;
  Comment_box(this.album_type,this.id,this.audioVideoType, {Key? key}) : super(key: key);

  @override
  _Comment_boxState createState() => _Comment_boxState(this.album_type,this.id,this.audioVideoType);
}

var name,image,user_id_;
class _Comment_boxState extends State<Comment_box> {
  String album_type,id,audioVideoType;
  _Comment_boxState(this.album_type,this.id,this.audioVideoType);
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  List filedata =[];
  var album_type_id;
  @override
  void initState() {
    super.initState();
    getCommentData();
    if(audioVideoType == "0"){
      album_type_id="2";
    }
    else if(audioVideoType == "1"){
      album_type_id="3";
    }
    else {
      album_type_id="1";
    }
  }

  getCommentData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      name= sharedPreferences.getString("user_name");
      image= sharedPreferences.getString("user_id");
      user_id_= sharedPreferences.getString("user_id");
    Map data = {
      'type':album_type_id,
       'type_id':id
    };
    var jsonResponse = null;
    var jsonResponses = null;
    print(data);
    print("asdasdasd");
    var response = await http.post(Uri.parse('https://www.itexpress4u.tech/taranaApi/MasterValue_Api/view_all_comments'),
        body: data);
    if (response.statusCode == 200) {
      jsonResponses=jsonDecode(response.body);
      var response_data = jsonResponses['comment'];
      List<Comment_list_item> comment_list=[];
      for(var list_data in response_data){
        Comment_list_item notification_model_item=Comment_list_item(list_data['comment'],list_data['commented_on'],list_data['name'],list_data['image']);
        comment_list.add(notification_model_item);
      }
      return comment_list;
    }

  }
  InsertCommentData() async {
    Map data = {
      'user_id':user_id_,
      'category':album_type_id,
      'cate_id':id,
       'comment':commentController.text
    };
    var jsonResponses = null;
    print(data);
    print("rtyuytredgf");
    var response = await http.post(Uri.parse('https://www.itexpress4u.tech/taranaApi/TaranaUser_Api/user_comment'),
        body: data);
    if (response.statusCode == 200) {
      jsonResponses=jsonDecode(response.body);
      var response_data = jsonResponses['comment'];
      List<Comment_list_item> comment_list=[];
      for(var list_data in response_data){
        Comment_list_item notification_model_item=Comment_list_item(list_data['comment'],list_data['commented_on'],list_data['name'],list_data['image']);
        comment_list.add(notification_model_item);
      }
      return comment_list;
    }
  }

  Widget commentChild(data) {

    return FutureBuilder(
        future: getCommentData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: progress_bar());
          }
          return  snapshot.data == null ? Center(
            child: SizedBox(
              child: Text("No Data Found",style: TextStyle(color: Colors.white,fontSize: 22),),
            ),
          ):ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context,index){
               return Padding(
                  padding: const EdgeInsets.fromLTRB(2, 8, 2, 0),
                  child: ListTile(
                    leading: GestureDetector(
                      onTap: () async {
                        print("Comment Clicked");
                      },

                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: new BoxDecoration(
                            color: Colors.blue,
                            borderRadius: new BorderRadius.all(Radius.circular(50)
                            )
                        ),
                        child: CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(Base_url().image_profile_url+snapshot.data[index].image + "")
                        ),
                      ),
                    ),

                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data[index].name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          ),
                        ),
                         Text(
                           snapshot.data[index].comment,
                           style: TextStyle(
                               color: Colors.white
                           ),
                         ),
                      ],
                    ),

                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Text(snapshot.data[index].commented_on,
                          style: TextStyle(
                              color: Colors.white54
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                );
              }
    );
        }
    );

    /*return ListView(
      children: [
        for (var i = 0; i < data.length; i++)
          Padding(
            padding: const EdgeInsets.fromLTRB(2, 8, 2, 0),
            child: ListTile(
              leading: GestureDetector(
                onTap: () async {
                  print("Comment Clicked");
                },

                child: Container(
                  height: 50,
                  width: 50,
                  decoration: new BoxDecoration(
                      color: Colors.blue,
                      borderRadius: new BorderRadius.all(Radius.circular(50)
                      )
                  ),

                  child: CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(data[i]['pic'] + "$i")
                  ),
                ),
              ),

              title: Text(
                data[i]['name'],
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
              ),

              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data[i]['message'],
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          )
      ],
    );*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        },
            icon: Icon(Icons.keyboard_arrow_down_outlined,
              color: Colors.white,
              size: 20,)),

      ),
      backgroundColor: Color(0xff14192A),
      body: Container(
        child: CommentBox(
          userImage:
          "https://lh3.googleusercontent.com/a-/AOh14GjRHcaendrf6gU5fPIVd8GIl1OgblrMMvGUoCBj4g=s400",
          child: commentChild(filedata),
          labelText: 'Write a comment...',
          withBorder: false,
          errorText: 'Comment cannot be blank',
          sendButtonMethod: () {
            if (formKey.currentState!.validate()) {

              setState(() {
                var value = {
                  InsertCommentData()
                };

                filedata.insert(0, value);
              }
              );

              commentController.clear();
              FocusScope.of(context).unfocus();
            } else {
              print("Not validated");
            }
          },
          formKey: formKey,
          commentController: commentController,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          sendWidget: Icon(
              Icons.send_sharp,
              size: 30,
              color: Colors.white
          ),
        ),
      ),
    );
  }
}
