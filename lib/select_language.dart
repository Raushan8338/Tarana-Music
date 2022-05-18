import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarana_app_live/pages/chose_artist.dart';

import 'auth_configFile/authconfig.dart';

class Select_language extends StatefulWidget {
  const Select_language({Key? key}) : super(key: key);

  @override
  _Select_languageState createState() => _Select_languageState();
}

String cur_user_id = '';

class _Select_languageState extends State<Select_language> {
  HashSet hashSet = new HashSet();
  bool isMultiSelectionEnabled = false;

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

  Update_language_details(language_list) async {
    // print(album_user_id+"--"+current_user_id+"--"+status);
    Map data = {
      'lang_list': language_list,
      'user_id': cur_user_id,
    };
    var jsonResponse = null;
    var response = await http.post(
        Uri.parse(
            'https://www.itexpress4u.tech/taranaApi/MasterValue_Api/update_language'),
        body: data);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Chose_artist()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black87,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text("Select your Language",
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
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: FutureBuilder(
              future: getLanguage_list(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                return snapshot.data == null
                    ? Center(
                        child: SizedBox(
                          child: Text(
                            "Please wait...",
                            style: TextStyle(color: Colors.white, fontSize: 22),
                          ),
                        ),
                      )
                    : GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 2 / 2,
                            crossAxisSpacing: 4.0,
                            mainAxisSpacing: 4.0),
                        itemCount: snapshot.data.length, //CHANGED
                        itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            isMultiSelectionEnabled = true;
                            addMultiselectValue(snapshot.data[index].language);
                            // hashSet.add(snapshot.data[index].language);
                            // print(snapshot.data[index].language);
                          },
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  margin: EdgeInsets.zero,
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  elevation: 4,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.primaries[Random()
                                          .nextInt(Colors.primaries.length)],
                                    ),
                                    // color: Colors.grey.withOpacity(hashSet.contains(snapshot.data[index].language) ? 1 : 0),
                                    child: Card(
                                      margin: EdgeInsets.zero,
                                      clipBehavior: Clip.antiAlias,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(0),
                                      ),
                                      elevation: 0,
                                      color: Colors.grey.withOpacity(
                                          hashSet.contains(
                                                  snapshot.data[index].language)
                                              ? 1
                                              : 0),
                                      // color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                                      child: Center(
                                          child: Text(
                                        snapshot.data[index].language,
                                        style: TextStyle(color: Colors.white),
                                      )),
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                  visible: hashSet
                                      .contains(snapshot.data[index].language),
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
              },
            ),
          ),
          (isMultiSelectionEnabled)
              ? Container(
                  height: 50,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          print(hashSet);
                          if (hashSet.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.red,
                              content: Text("Please Select Any two"),
                            ));
                          } else {
                            Update_language_details(hashSet.toString());
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                hashSet.length.toString() +
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
      ),
    );
  }

  void addMultiselectValue(language) {
    if (isMultiSelectionEnabled) {
      setState(() {
        if (hashSet.contains(language)) {
          hashSet.remove(language);
        } else {
          //print(hashSet.length);
          hashSet.add(language);
        }
      });
    }
  }
}
