import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Welcome_files/splash.dart';
import '../dashboard_home.dart';
import '../pages/notification.dart';

class Header_toggle_view_buttom extends StatefulWidget {
  const Header_toggle_view_buttom({Key? key}) : super(key: key);

  @override
  _Header_toggle_view_buttomState createState() => _Header_toggle_view_buttomState();
}
String dayWishes='',is_creators_comp='';
class _Header_toggle_view_buttomState extends State<Header_toggle_view_buttom> {
  bool isSwitched = false;
  @override
  void initState() {
    super.initState();
    getUserinfo();
  }

  getUserinfo() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var user_names= sharedPreferences.getString("user_name");
    var is_creator= sharedPreferences.getString("is_creator");
    is_creators_comp=is_creator!;
    print(is_creator);
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('a').format(now);
    setState(() {
      (is_creators_comp == "1") ? isSwitched = true:isSwitched = false;
    });
    if(formattedDate == 'AM'){
      dayWishes='Good Morning';
     // user_name_for=user_names!;
    }
    else {
    //  user_name_for=user_names!;
      dayWishes='Good Afternoon';
    }
  }
  @override
  Widget build(BuildContext context) {
    return   Row(
      children: [
        Switch(
          value: isSwitched,
          onChanged: (value) {
            setState(() {
              isSwitched = value;
              String switch_data;
              if(isSwitched == false){
                switch_data="0";
              }
              else {
                switch_data = "1";
              }
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Are you sure you want to switched the account ...'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () =>
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => SplashPage(switch_data,"switch_mode")),
                                (Route<dynamic> route) => false,
                          ),
                      child: const Text('Yes'),

                    ),
                  ],
                ),
                // onTap: ()=>Logout(),
              );
              // print(switch_data);
              // print("isSwitched");
            });
          },
          activeTrackColor: Colors.deepOrangeAccent,
          activeColor: Colors.deepOrange,
          inactiveTrackColor: Colors.grey,
          inactiveThumbColor: Colors.grey,
        ),
       /* (is_creators == "1") ?

            :SizedBox()*/
      ],
    );
  }
}

class User_name_component extends StatelessWidget {
  const User_name_component({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
        margin: EdgeInsets.fromLTRB(6, 0,0,0),
        child: Row(
          children: [
            Text('Hello , ',style: TextStyle(color: Color(0xffFFC4C0C0),fontFamily: 'poppins',fontSize: 15)),
            Text(user_name_for,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16))
          ],
        ));
  }
}
