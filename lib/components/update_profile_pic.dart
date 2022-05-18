import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Profile/musician_profile.dart';
import '../Profile/profile_details_page.dart';
import '../auth_configFile/authconfig.dart';
class Update_profile_pic extends StatefulWidget {
   Update_profile_pic({Key? key}) : super(key: key);
  @override
  _Update_profile_picState createState() => _Update_profile_picState();
}

class _Update_profile_picState extends State<Update_profile_pic> {
  late AnimationController controller;
  final ImagePicker _picker = ImagePicker();
  bool isLoading=true;

  String memoryImageToBase64(File myfile) {
    List<int> imageBytes =myfile.readAsBytesSync();
    String base64String = base64Encode(imageBytes);
    String header = "data:video/mp4;base64,";
    updateProfile_pic(user_id,base64String);
    // print(base64String);
    return header + base64String;
  }
  updateProfile_pic(user_id, user_image) async {
    // print(user_id+"--"+user_image);
    Map data = {
      'user_id':user_id,
      'user_image':user_image,
    };
    var jsonResponse = null;
    var response = await http.post(Uri.parse("https://www.itexpress4u.tech/taranaApi/TaranaUser_Api/update_profile_image"),
        body: data);
    print(Base_url().baseurl+'update_profile_image');
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      setState(() {
        isLoading=false;
        //User_details_dwidget();
      });
      print(jsonResponse);
    }
  }


  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.fromLTRB(78,65,0,0),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: IconButton(
          onPressed: () async {
            final pickedFile = await _picker.pickImage(
              source: ImageSource.gallery,
              maxWidth: 512,
              maxHeight: 512,
              imageQuality: 80,
            );
            isLoading=true;
            memoryImageToBase64(File(pickedFile!.path));
          },
          icon: Icon(
            Icons.linked_camera_outlined,
            size: 32,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
