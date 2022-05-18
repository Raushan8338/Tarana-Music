import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarana_app_live/select_language.dart';
import '../Audio_player_File/album_profile.dart';
import 'package:http/http.dart' as http;
import '../auth_configFile/authconfig.dart';
import '../home.dart';
import 'login.dart';

class singup extends StatefulWidget {
  String mobileno;
   singup(this.mobileno, {Key? key}) : super(key: key);
  @override
  _singupState createState() => _singupState(this.mobileno);
}

class _singupState extends State<singup> {
  String mobileno;
  _singupState(this.mobileno);
  TextEditingController otpController = TextEditingController();
  late String dateTime;
  DateTime selectedDate = DateTime.now();
  bool isLoading = false;
  verifyOTP() async {
    Map data = {
      'user' : mobileno,
      'otp' : otpController.text
    };
    //  print(data);
    var jsonResponse =null;
    var jsonResponses =null;
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    var response=await http.post(Uri.parse(Base_url().baseurl+'varify_otp'),body:data);
    print(response.statusCode);
    if(response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print(jsonResponse);
      setState(() {
        isLoading=false;
        sharedPreferences.setString("user_name", jsonResponse['name']);
        sharedPreferences.setString("user_id", jsonResponse['id']);
        sharedPreferences.setString("user_email", jsonResponse['email']);
        sharedPreferences.setString("mobile", jsonResponse['phone']);
        sharedPreferences.setString("gender", jsonResponse['gender']);
        sharedPreferences.setString("dob", jsonResponse['dob']);
        sharedPreferences.setString("verification_code", jsonResponse['verification_code']);
        sharedPreferences.setString("is_verified", jsonResponse['is_verified']);
        sharedPreferences.setString("tarana_id", jsonResponse['tarana_id']);
        sharedPreferences.setString("created", jsonResponse['created_at']);
        sharedPreferences.setString("logged_in", "logged_in");
        sharedPreferences.setString("updated", jsonResponse['updated_at']);
        sharedPreferences.setString("language_select", jsonResponse['lang_id']);
        sharedPreferences.setString("singer_data", jsonResponse['singer_id']);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Select_language()),
              (Route<dynamic> route) => false,
        );
        // sharedPreferences.getBool("logged_in");+
      });
    }
    else {
      setState(() {
        isLoading=false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.black87,
         /*   appBar: AppBar(elevation: 0,
              leading: IconButton(
               onPressed: (){
                 Navigator.push(context,MaterialPageRoute(builder: (context) => SignInScreen()));
               },
                icon: Icon(
                  Icons.arrow_back,color: Colors.white,),
              ),
              backgroundColor: Colors.transparent,
            ),*/
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Opacity(
                opacity: 0.5,
                child: ClipPath(
                  clipper: BottomWaveClipper(),
                  child: Container(
                    color: Colors.black87,
                    height: MediaQuery.of(context).size.height,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: ClipPath(
                    clipper: BottomWaveClipper(),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.black87,
                                  Colors.black87,
                                  Colors.black87,
                                  Colors.black87,
                                ])),
                        child:    Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: IconButton(
                                  onPressed: (){
                                Navigator.push(context,MaterialPageRoute(builder: (context) => SignInScreen()));
                                 },
                                  icon: Icon(
                                      Icons.arrow_back,color: Colors.white)),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 55, 0, 0),
                              child:  Image.asset(
                                'assets/images/bg_logo.png',
                                height: 90,
                                width: 190,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0,100, 0, 0),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.fromLTRB(0, 0, 0, 90),
                                        child: TextFormField(
                                          controller: otpController,
                                          style: TextStyle(color: Colors.white),
                                          decoration: const InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                                borderSide: BorderSide(width: 1.0),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: Colors.white),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: Colors.white),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: Colors.white),
                                              ),
                                              focusedErrorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: Colors.white),
                                              ),
                                              disabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: Colors.white),
                                              ),
                                              labelText: 'OTP Here',
                                              labelStyle: TextStyle(
                                                  color: Colors.white),
                                              hintStyle: TextStyle(color: Colors.white),
                                              hintText: "Enter OTP",
                                              fillColor: Colors.white,
                                              focusColor: Colors.white
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(16, 0,16, 0),
                                        child: Container(
                                          height: 65,
                                          child: Card(
                                            margin: EdgeInsets.all(10),
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(25)),
                                            color: Colors.deepOrange,
                                            child: TextButton(
                                              style: TextButton.styleFrom(
                                                primary: Colors.deepOrange,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  isLoading=true;
                                                });
                                                verifyOTP();
                                                /*  Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const Select_language()));*/
                                              },
                                              child: Container(
                                                child: Center(
                                                  child: Text(
                                                    'Next',
                                                    style: TextStyle(fontSize: 20, color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                    ]
                                ),
                              ),
                            ),
                          ],

                        ),
                      ),
                    )),
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
                            Text("Please wait...")
                          ],
                        ),
                      ),
                    )):
                SizedBox(),
              ),
          ],
        ),
        )
      ),
    );

  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    debugPrint(size.width.toString());
    var path = new Path();
    path.lineTo(0, size.height - 25);
    var firstStart = Offset(size.width / 4, size.height);
    var firstEnd = Offset(size.width / 2.25, size.height - 20.0);
    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);
    var secondStart =
    Offset(size.width - (size.width / 3.24), size.height - 40);
    var secondEnd = Offset(size.width, size.height - 20);
    path.quadraticBezierTo(secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);
    path.lineTo(size.width, size.height - 40);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
