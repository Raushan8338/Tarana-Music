import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Audio_player_File/album_profile.dart';
import '../../auth_configFile/authconfig.dart';
import '../../components/progress_bar.dart';
import 'add_song_his.dart';

class Create_album extends StatefulWidget {
  Create_album({Key? key}) : super(key: key);

  @override
  _Create_albumState createState() => _Create_albumState();
}

String chose_category_name = '',
    category_value = '',
    chose_language_name = '',
    language_value = '',
    banner_image = '',
    banner_image_name = '';

class _Create_albumState extends State<Create_album> {
  TextEditingController album_name = TextEditingController();
  TextEditingController release_year = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  bool isLoading = false;
  bool _validate = false;
  late File imageFile;

  String memoryImageToBase64(File myfile) {
    List<int> imageBytes = myfile.readAsBytesSync();
    String base64String = base64Encode(imageBytes);
    String header = "data:video/mp4;base64,";
    banner_image = base64String;
    // updateProfile_pic(user_id,image_url);
    // print(base64String);
    return header + base64String;
  }

  saveCreateProfile() async {
    isLoading = true;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var user_ids = sharedPreferences.getString("user_id");
    Map data = {
      'user_id': user_ids,
      'catagory_id': category_value,
      'language_id': language_value,
      'album_name': album_name.text,
      'release_year': release_year.text,
      'image': banner_image
    };
    var jsonResponse = null;
    print(data);
    var response = await http.post(
        Uri.parse(
            "https://www.itexpress4u.tech/taranaApi/TaranaUser_Api/create_album"),
        body: data);

    if (response.statusCode == 200) {
      print(response.body);
      jsonResponse = json.decode(response.body);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Add_song_history(
                  album_name.text, jsonResponse['album_id'], "", "", "","")));
      print(response.body);
      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black87,
        appBar: AppBar(
          title: Text("Create Album"),
          actions: [],
        ),
        body: SingleChildScrollView(
            child: Stack(
          children: [
            Padding(
                padding: const EdgeInsets.all(20),
                child: Column(children: [
                  TextFormField(
                      maxLines: 1,
                      controller: album_name,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        fillColor: Colors.white24,
                        filled: false,
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 0.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 0.0),
                        ),
                        hintStyle: TextStyle(color: Colors.white, fontSize: 17),
                        hintText: "Album Name...",
                      )),
                  SizedBox(
                    height: 14,
                  ),
                  TextFormField(
                      maxLines: 1,
                      controller: release_year,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        fillColor: Colors.white24,
                        filled: false,
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 0.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 0.0),
                        ),
                        hintStyle: TextStyle(color: Colors.white, fontSize: 17),
                        hintText: "Release Year...",
                      )),
                  SizedBox(
                    height: 14,
                  ),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.white,
                        builder: (context) => SingleChildScrollView(
                          physics: ScrollPhysics(),
                          child: Column(
                            children: [
                              FutureBuilder(
                                  future: getsongCategory_list(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(child: progress_bar());
                                    }
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: snapshot.data.length,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (BuildContext, index) {
                                        return InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                            chose_category_name = snapshot
                                                .data[index].catagory_name;
                                            category_value =
                                                snapshot.data[index].id;
                                            print(snapshot.data[index].id);
                                            setState(() {});
                                          },
                                          child: ListTile(
                                            title: Text(
                                              snapshot
                                                  .data[index].catagory_name,
                                              style: TextStyle(
                                                  color: Colors.black87),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  })
                            ],
                          ),
                        ),
                      );
                    },
                    child: Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.white38,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: (chose_category_name == '')
                                  ? Text("Choose Catagory",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ))
                                  : Text(chose_category_name,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      )),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 3),
                              child: IconButton(
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.white,
                                  size: 28,
                                ),
                                onPressed: () {},
                              ),
                            )
                          ],
                        )),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.white,
                        builder: (context) => SafeArea(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            physics: ScrollPhysics(),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                FutureBuilder(
                                    future: getLanguage_list(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Center(child: progress_bar());
                                      }
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: snapshot.data.length,
                                        itemBuilder: (BuildContext, index) {
                                          return InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                              chose_language_name =
                                                  snapshot.data[index].language;
                                              language_value =
                                                  snapshot.data[index].id;
                                              // print(snapshot.data[index].id);
                                              setState(() {});
                                            },
                                            child: ListTile(
                                              title: Text(
                                                snapshot.data[index].language,
                                                style: TextStyle(
                                                    color: Colors.black87),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    })
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    child: Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.white38,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: (chose_language_name == '')
                                  ? Text("Choose Language",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ))
                                  : Text(chose_language_name,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      )),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 3),
                              child: IconButton(
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.white,
                                  size: 28,
                                ),
                                onPressed: () {},
                              ),
                            )
                          ],
                        )),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    child: Container(
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white38,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: new Center(
                          child: (banner_image_name == '')
                              ? Text("Choose Banner",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20))
                              : Image.file(
                                  imageFile,
                                  fit: BoxFit.cover,
                                ),
                        )),
                    onTap: () async {
                      final pickedFile = await _picker.pickImage(
                        source: ImageSource.gallery,
                        maxWidth: 512,
                        maxHeight: 512,
                        imageQuality: 80,
                      );
                      setState(() {
                        banner_image_name = pickedFile!.name.toString();
                        imageFile = File(pickedFile.path);
                      });
                      // print(pickedFile!.path.toString());
                      memoryImageToBase64(File(pickedFile!.path));
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        album_name.text.isEmpty
                            ? _validate = true
                            : _validate = false;
                      });
                      if (album_name.text.isEmpty) {
                        // print(mobileController.text);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.red,
                          content: Text("Please enter all details..."),
                        ));
                        return;
                      } else
                        setState(() {
                          isLoading = true;
                        });
                      saveCreateProfile();
                    },
                    child: Card(
                      color: Colors.deepOrange,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        height: 40,
                        width: 140,
                        child: Center(
                          child: Text(
                            "Submit",
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 23,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ])),
            Container(
              child: (isLoading == true)
                  ? Positioned(
                      left: 0,
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: Container(
                        child: AlertDialog(
                          insetPadding: EdgeInsets.symmetric(horizontal: 90),
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircularProgressIndicatorApp(),
                              Text("Please wait...")
                            ],
                          ),
                        ),
                      ))
                  : SizedBox(),
            ),
          ],
        )));
  }
}
