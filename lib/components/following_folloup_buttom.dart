import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../auth_configFile/authconfig.dart';

class Following_follow_button extends StatefulWidget {
  String floowing_status,catagory_ids;
  double radius;
   Following_follow_button(this.floowing_status,this.catagory_ids,this.radius, {Key? key}) : super(key: key);

  @override
  _Following_follow_buttonState createState() => _Following_follow_buttonState(this.floowing_status,this.catagory_ids,this.radius);
}
String cur_user_ids='';
bool follow_check=false;
class _Following_follow_buttonState extends State<Following_follow_button> {
  String floowing_status,catagory_ids;
  double radius;
  _Following_follow_buttonState(this.floowing_status,this.catagory_ids,this.radius);
  @override
  void initState() {
    super.initState();
    getSessionData();
  }
  getSessionData() async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    var users_id =sharedPreferences.getString('user_id');
    setState(() {
      cur_user_ids=users_id!;
    });
    if (floowing_status == '1'){
      setState(() {
        follow_check = true;
      });
    }
    else {
      setState(() {
        follow_check = false;
      });
    }
    /// print(follow_check);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0,0,3,0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            (follow_check == true)?
            TextButton(
              onPressed: () {
                updateFollowerCount(catagory_ids,cur_user_ids);
                setState(() {
                  follow_check=false;
                });
              },
              child: Center(
                child: Text(
                  "Follow".toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12),
                ),
              ),
              style:(radius==0)?  ButtonStyle(
                  shape: MaterialStateProperty
                      .all<
                      RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                  )):
              ButtonStyle(
                  shape: MaterialStateProperty
                      .all<
                      RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(
                          12.0),
                      side: const BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                  ))
               ,
            )
            :
            TextButton(
                onPressed: () {
                  updateFollowerCount(catagory_ids,cur_user_ids);
                  setState(() {
                    follow_check=true;
                  });
                },
                child: Center(
                  child: Text(
                    "Following".toString(),
                    style: TextStyle(
                        color: (radius==1)?Colors.deepOrange:Colors.white,
                        fontSize: 12),
                  ),
                ),
                style: (radius==0)? ButtonStyle(
                    shape: MaterialStateProperty
                        .all<
                        RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                    ))  : ButtonStyle(
                    shape: MaterialStateProperty
                        .all<
                        RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(
                            12.0),
                        side: const BorderSide(
                          color: Colors.deepOrange,
                        ),
                      ),
                    )))
          ]),
    );
  }
}
