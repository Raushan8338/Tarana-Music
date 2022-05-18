import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import '../../Audio_player_File/album_profile.dart';
import '../../auth_configFile/authconfig.dart';
import '../../components/progress_bar.dart';

class Add_song_file extends StatefulWidget {
  String movie_name, id, audio_video_type;

  Add_song_file(this.movie_name, this.id, this.audio_video_type, {Key? key})
      : super(key: key);

  @override
  _Add_song_fileState createState() =>
      _Add_song_fileState(this.movie_name, this.id, this.audio_video_type);
}

String chose_category_name = '',
    category_value = '',
    chose_language_name = '',
    language_value = '',
    banner_image = '',
    banner_image_name = '',
    audio_file = '',
    chose_singer_name = '';
String file_name = '', singer_value = '';
File? imageFile;
String? progress,total_upl_byt;
class _Add_song_fileState extends State<Add_song_file> {
  AnimationController? controller;
  String movie_name, id, audio_video_type;

  _Add_song_fileState(this.movie_name, this.id, this.audio_video_type);

  TextEditingController song_name = TextEditingController();
  TextEditingController singer_name = TextEditingController();
  bool isLoading = false;
  bool _validate = false;

  final ImagePicker _picker = ImagePicker();

  String memoryImageToBase64(File myfile) {
    List<int> imageBytes = myfile.readAsBytesSync();
    String base64String = base64Encode(imageBytes);
    String header = "data:video/mp4;base64,";
    banner_image = base64String;
    // updateProfile_pic(user_id,image_url);
    // print(myfile);
    return header + base64String;
  }

  String memoryAudioToBase64(File myfile) {
    List<int> imageBytess = myfile.readAsBytesSync();
    String base64String_audio = base64Encode(imageBytess);
    String header = "data:video/mp4;base64,";
    audio_file = base64String_audio;
    // updateProfile_pic(user_id,image_url);
    // print(myfile);
    print(audio_file.length / (1024 * 1024));
    return header + base64String_audio;
  }

  saveCreateProfile() async {
    print(id);
    print("data_datatata");
    isLoading = true;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var user_ids = sharedPreferences.getString("user_id");
    print(banner_image);
    print(audio_file);
    Map data = {
      'user_id': user_ids,
      'catagory_id': category_value,
      'singer_id': singer_value,
      'lang_id': language_value,
      'song_id': id,
      'movie_id': id,
      'colour': 'blue',
      'release_year': '',
      'title': song_name.text,
      'image': banner_image,
      'song': audio_file
    };
    print(data);

    var jsonResponse = null;
    var response;
    (audio_video_type == "0") ?
  /*  response = await http.post(Uri.parse("https://www.itexpress4u.tech/taranaApi/TaranaUser_Api/upload_videos"), body: data).
    timeout(Duration(seconds: 90))*/
    response = await Dio().post(
      "https://www.itexpress4u.tech/taranaApi/TaranaUser_Api/upload_videos",
      data: data,
      onSendProgress: (int sent, int total) {
        String percentage = (sent/total*100).toStringAsFixed(2);
        setState(() {
          total_upl_byt="$total ";
          progress = percentage + " % uploading...";
        //  progress = "$sent" + " Bytes of " "$total Bytes - " +  percentage + " % uploaded";
          //update the progress
        });
      },)
        : response = await Dio().post(
      "https://www.itexpress4u.tech/taranaApi/TaranaUser_Api/upload_songs",
      data: data,
      onSendProgress: (int sent, int total) {
        String percentage = (sent/total*100).toStringAsFixed(2);
        setState(() {
          total_upl_byt="$total ";
          progress = percentage + " % uploading";
          //update the progress
        });
      },);

    print(response.body);
    if (response.statusCode == 200) {
      print(response.body);
      isLoading = false;
      //  jsonResponse = json.decode(response.body);
      showDoneDialog();
      // Navigator.push(context, MaterialPageRoute(builder: (context)=>Add_song_history(album_name.text,jsonResponse['album_id'])));
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

  void showDoneDialog() => showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.network(
                    "https://assets2.lottiefiles.com/private_files/lf30_z1sghrbu.json",
                    width: 150,
                    height: 150,
                    fit: BoxFit.fill,
                    repeat: true,
                    controller: controller, onLoaded: (composition) {
                  controller?.duration = composition.duration;
                  controller?.forward();
                }),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Done",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black87,
        appBar: AppBar(
          title: Text("Album Name " + movie_name),
          actions: [],
        ),
        body: SingleChildScrollView(
            child: Stack(
          children: [

            Padding(
                padding: const EdgeInsets.all(20),
                child: Column(children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                    child: Center(
                        child: Text(
                      "Add Song",
                      style: TextStyle(color: Colors.white, fontSize: 23),
                    )),
                  ),
                  TextFormField(
                      maxLines: 1,
                      controller: song_name,
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
                        hintText: "Song Title...",
                      )),
                  SizedBox(
                    height: 14,
                  ),

                  TextFormField(
                      maxLines: 1,
                      controller: singer_name,
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
                        hintText: "Singer Name...",
                      )),
                  SizedBox(
                    height: 14,
                  ),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
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
                        builder: (context) => SingleChildScrollView(
                          physics: ScrollPhysics(),
                          child: Column(
                            children: [
                              FutureBuilder(
                                  future: getFavriote_sing_list(),
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
                                      itemBuilder: (BuildContext, ct) {
                                        return InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                            chose_singer_name =
                                                snapshot.data[ct].singer_name;
                                            singer_value = snapshot.data[ct].id;
                                            print(snapshot.data[ct].id);
                                            setState(() {});
                                          },
                                          child: ListTile(
                                            title: Text(
                                              snapshot.data[ct].singer_name,
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
                              child: (chose_singer_name == '')
                                  ? Text("Choose Singer",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ))
                                  : Text(chose_singer_name,
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
                        // isScrollControlled: true,
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
                                              print(snapshot.data[index].id);
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
                    onTap: () async {
                      final pickedFile = await _picker.pickImage(
                        source: ImageSource.gallery,
                        maxWidth: 512,
                        maxHeight: 512,
                        imageQuality: 80,
                      );
                      setState(() {
                        imageFile = File(pickedFile!.path);
                        banner_image_name = pickedFile.name.toString();
                        //imageFile = File(pickedFile.path);
                      });
                      //  print(pickedFile!.name.toString());
                      memoryImageToBase64(File(pickedFile!.path));
                    },
                    child: Container(
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white38,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: new Center(
                            child: (banner_image_name == '')
                                ? Text("Choose Audio Banner",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20))
                                :
                                // Text("Selected")
                                Image.file(
                                    imageFile!,
                                    fit: BoxFit.cover,
                                  ))),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: RaisedButton.icon(
                        onPressed: () async {
                          FilePickerResult? result;
                          (audio_video_type == "0")
                              ? result = await FilePicker.platform
                                  .pickFiles(type: FileType.video)
                              : result = await FilePicker.platform
                                  .pickFiles(type: FileType.audio);
                          if (result != null) {
                            File file =
                                File(result.files.single.path.toString());
                            memoryAudioToBase64(file);
                            //  file_name='asdasd';
                            print("file.length()");
                            print(file.lengthSync() / (1024 * 1024));
                          } else {
                            file_name = '';
                            print("User canceled the picker");
                            // User canceled the picker
                          }
                        },
                        icon: Icon(Icons.folder_open),
                        label: (file_name == '')
                            ? (audio_video_type == "0")
                                ? Text("Choose Video File",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20))
                                : Text("Choose Audio File",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20))
                            : Text("File Selected",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20)),
                        color: Colors.redAccent,
                        colorBrightness: Brightness.dark,
                      )),
                  SizedBox(
                    height: 30,
                  ),
                  TextButton(
                    onPressed: () {
                      /* setState(() {
                            song_name.text.isEmpty ? _validate = true : _validate = false;
                          });
                          if(song_name.text.isEmpty) {
                            // print(mobileController.text);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.red,
                              content: Text("Please enter all details..."),
                            ));
                            return;
                          }
                          else
                            setState(() {
                              isLoading = true;
                            });*/
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
                  child:
                      AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.0)
                            )
                        ),
                        insetPadding: EdgeInsets.symmetric(horizontal: 90),
                        content:progress == null?
                        Text("Progress: 0%"):
                      /*  Text("Progress: $progress",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18),),*/
                       Column(
                         mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Total Size : $total_upl_byt b',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16),),
                            Text("Progress: $progress",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 18),),

                          ],
                        ),
                      ))
                  : SizedBox(),
            ),
          ],
        )));
  }
}
