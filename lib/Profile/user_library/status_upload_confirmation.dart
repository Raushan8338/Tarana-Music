import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Audio_player_File/album_profile.dart';

class Status_upload_confirmation extends StatefulWidget {
  File file;

  Status_upload_confirmation(this.file, {Key? key}) : super(key: key);

  @override
  _Status_upload_confirmationState createState() =>
      _Status_upload_confirmationState(this.file);
}

String banner_image = '';
TextEditingController TextController = new TextEditingController();
class _Status_upload_confirmationState
    extends State<Status_upload_confirmation> {
  File file;

  _Status_upload_confirmationState(this.file);
  bool isLoading = false;
  uploadStatus() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var users_id = sharedPreferences.getString('user_id');
    List<int> imageBytes = file.readAsBytesSync();
    String base64String = base64Encode(imageBytes);
    String header = "data:video/mp4;base64,";
    banner_image = base64String;
    Map data = {
      'user_id': users_id,
      'media_type': 'image',
      'media': banner_image,
      'caption': TextController.text,
      'duration': '',
      'color':''
    };
    var jsonResponse = null;
    print(file);
    print("data_sfdsfs");
   var response = await http.post(
        Uri.parse(
            'https://www.itexpress4u.tech/taranaApi/TaranaUser_Api/upload_status'),
        body: data);
    print(response);
    if (response.statusCode == 200) {
      isLoading = false;
      jsonResponse = json.decode(response.body);
      print(jsonResponse.toString());
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black87,
        body: Stack(
          children: [
            Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 20),
                        child: IconButton(
                          icon: Icon(
                            Icons.clear,
                            color: Colors.white,
                          ),

                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      )
                    ],
                  ),

                  Spacer(),

                  Container(
                      child: ClipRRect(
                        child: Image.file(
                          file,
                          fit: BoxFit.cover,
                        ),
                      )
                  ),

                  Spacer(),

                  Container(
                    margin: EdgeInsets.only(
                        left: 5,
                        right: 5,
                        bottom: 5
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white,
                    ),

                    height: 50,
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.photo),
                          iconSize: 25,
                          color: Colors.deepOrange,
                          onPressed: () {},
                        ),

                        Expanded(
                          child: TextField(
                            controller: TextController,
                            decoration: InputDecoration.collapsed(
                              hintText: 'Write Caption..',
                            ),

                            textCapitalization: TextCapitalization.sentences,
                          ),
                        ),

                        IconButton(
                          icon: Icon(Icons.send),
                          iconSize: 25,
                          color: Colors.deepOrange,
                          onPressed: () {
                            setState(() {
                              isLoading = true;
                            });

                            uploadStatus();
                          },
                        ),
                      ],
                    ),
                  )
                ]
            ),
            Container(
              child: (isLoading==true)?
              Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: Container(
                    child:AlertDialog(
                      insetPadding: EdgeInsets.symmetric(horizontal: 90),
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircularProgressIndicatorApp(),
                          SizedBox(),
                          SizedBox(),
                          Text("Please wait...")
                        ],
                      ),
                    ),
                  )):
              SizedBox(),
            ),
          ],
        )
    );
  }
}
