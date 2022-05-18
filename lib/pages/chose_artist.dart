import 'dart:collection';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../auth_configFile/authconfig.dart';
import '../home.dart';

class Chose_artist extends StatefulWidget {
  const Chose_artist({Key? key}) : super(key: key);

  @override
  _Chose_artistState createState() => _Chose_artistState();
}

String cur_user_id = '';

class _Chose_artistState extends State<Chose_artist> {
  HashSet selectItems = new HashSet();
  bool isMultiSelectionEnabled = false;
  var colors = [
    Colors.red,
    Colors.blue,
    Colors.cyan,
    Colors.green,
    Colors.yellow,
    Colors.red,
    Colors.blue,
    Colors.cyan,
    Colors.green,
    Colors.yellow,
  ];

  //bool _value = false;

  @override
  void initState() {
    super.initState();
    getSharedata();
  }

  getSharedata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var cur_users_id = prefs.getString('user_id');
    cur_user_id = cur_users_id!;
  }

  Update_singer_details(singer_list) async {
    // print(album_user_id+"--"+current_user_id+"--"+status);
    Map data = {
      'singer_list': singer_list,
      'user_id': cur_user_id,
    };
    var jsonResponse = null;
    var response = await http.post(
        Uri.parse(
            'https://www.itexpress4u.tech/taranaApi/MasterValue_Api/update_favriote_art'),
        body: data);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black87,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text("Select your favorite Artist",
              style: TextStyle(
                  color: Colors.white, fontSize: 20, fontFamily: 'poppins')),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
        ),
        // backgroundColor: Color(0xff14192A),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: FutureBuilder(
                  future: getFavriote_sing_list(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return /*snapshot.data == null ? Center(
                      child: SizedBox(
                        child: Text("Please wait...",style: TextStyle(color: Colors.white,fontSize: 22),),
                      ),
                    ): */
                        GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    childAspectRatio: 2.8 / 3,
                                    crossAxisSpacing: 4.0,
                                    mainAxisSpacing: 4.0),
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext ctx, index) {
                              return GridTile(
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      isMultiSelectionEnabled = true;
                                    });
                                    doMultiSelection(snapshot.data[index].id);
                                  },
                                  /*   onLongPress: () {
                                  isMultiSelectionEnabled = true;
                                  doMultiSelection(snapshot.data[index].language);
                                },*/
                                  child: Stack(
                                    children: [
                                      Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(100)),
                                                  child: CachedNetworkImage(
                                                    imageUrl: Base_url()
                                                            .singer_image_url +
                                                        snapshot
                                                            .data[index].image,
                                                    height: 90.0,
                                                    width: 90.0,
                                                    fit: BoxFit.cover,
                                                    color: Colors.grey
                                                        .withOpacity(selectItems
                                                                .contains(snapshot
                                                                    .data[index]
                                                                    .id)
                                                            ? 1
                                                            : 0),
                                                    colorBlendMode:
                                                        BlendMode.color,
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Container(
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              6, 0, 6, 0),
                                                      height: 90.0,
                                                      width: 90.0,
                                                      decoration: BoxDecoration(
                                                          color: Colors.grey,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10))),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10)),
                                                        child: AspectRatio(
                                                          aspectRatio: 22 / 5,
                                                          child: Container(
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                  /*Image.network(
                                               'https://usersbkp.s3.ap-south-1.amazonaws.com/ATTENDANCE_USERS_IMAGES/035168100_1608352422.jpg',
                                                color: Colors.grey.withOpacity(selectItems.contains(snapshot.data[index].language) ? 1 : 0),
                                                colorBlendMode:BlendMode.color,
                                                height: 90.0,
                                                width: 90.0,
                                                  fit: BoxFit.cover
                                               ),*/
                                                  ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                snapshot
                                                    .data[index].singer_name,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Visibility(
                                          visible: selectItems.contains(
                                              snapshot.data[index].id),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Icon(
                                              Icons.check,
                                              color: Colors.white,
                                              size: 30,
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                              );
                            });
                  }),
            ),
            // Spacer(),
            (isMultiSelectionEnabled)
                ? Container(
                    height: 50,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            print(selectItems);
                            if (selectItems.isEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                backgroundColor: Colors.red,
                                content: Text("Please Select Any two"),
                              ));
                            } else {
                              Update_singer_details(selectItems.toString());
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  selectItems.length.toString() +
                                      " Language selected",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontFamily: 'poppins')),
                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 9, 0),
                                    child: Text('Next',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25,
                                            fontFamily: 'poppins')),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : SizedBox()
          ],
        ));
  }

  void doMultiSelection(String path) {
    if (isMultiSelectionEnabled) {
      setState(() {
        if (selectItems.contains(path)) {
          selectItems.remove(path);
        } else {
          selectItems.add(path);
        }
      });
    } else {
      print(selectItems);
    }
  }
}
