import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarana_app_live/Audio_player_File/album_profile.dart';
import 'package:tarana_app_live/Welcome_files/signup.dart';
import '../auth_configFile/authconfig.dart';
import '../home.dart';
import 'package:http/http.dart' as http;

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController mobileController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  bool _validate = false;
  @override
  void dispose() {
    mobileController.dispose();
    super.dispose();
  }
  bool isLoading = false;
  getLoginDetails() async {
    Map data = {
      'user' : mobileController.text
    };
    var jsonResponse =null;
    var response=await http.post(Uri.parse(Base_url().baseurl+'sign_in'),body:data);
    print(response);
    if(response.statusCode == 200){
      jsonResponse=json.decode(response.body);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>  singup(mobileController.text)));
      setState(() {
        isLoading=false;
      });
    }
    else
      setState(() {
        isLoading=false;
      });

  }

  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black87,
        resizeToAvoidBottomInset: false,
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
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0,65,0,0),
                              child:  Image.asset(
                                'assets/images/bg_logo.png',
                                height: 60,
                                width: 60,
                              ),
                            ),
                            Spacer(),
                            Container(
                              margin: EdgeInsets.fromLTRB(0,0,0,35),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(22.0),
                                    child: TextFormField(
                                      style: TextStyle(color: Colors.white),
                                      controller: mobileController,
                                      decoration: InputDecoration(
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
                                        contentPadding: EdgeInsets.all(10.0),
                                        hintText: 'Please enter your mobile No.',
                                        hintStyle: TextStyle(
                                            color: Color.fromARGB(255, 211, 210, 210)),
                                        labelText: 'Mobile no',
                                        labelStyle: TextStyle(
                                            color: Color.fromARGB(255, 230, 227, 227)),
                                      ),
                                      onFieldSubmitted: (mobileController) {},
                                      validator: (mobileController) {
                                        if (mobileController!.isEmpty) {
                                          return 'Enter a valid password!';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Container(
                                    width: 250,
                                    height: 48,
                                    margin: EdgeInsets.fromLTRB(0,45,0,0),
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(50.0),
                                              ))),
                                      onPressed: () {
                                        setState(() {
                                          mobileController.text.isEmpty ? _validate = true : _validate = false;
                                        });
                                        if(mobileController.text.isEmpty) {
                                          // print(mobileController.text);
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                            backgroundColor: Colors.red,
                                            content: Text("Please enter valid mobile no..."),
                                          ));
                                          return;
                                        }
                                        else
                                          setState(() {
                                            isLoading = true;
                                          });
                                        getLoginDetails();
                                      },
                                      child: const Text(
                                        "Login with OTP",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 32),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Center(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          child: Container(
                                            height: 1,
                                            width: 90,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          ' or Login with ',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          child: Container(
                                            height: 1,
                                            width: 90,
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                  color: Colors.white,

                                                ),
                                                borderRadius: BorderRadius.circular(40)
                                            ),
                                            child: Icon(Icons.facebook_rounded, color: Colors.blue,size: 40,)),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>singup('')));
                                        },
                                        child:Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                  color: Colors.white,
                                                ),
                                                borderRadius: BorderRadius.circular(40)
                                            ),
                                            child: Icon(Icons.email, color: Colors.deepOrange,size: 40,)),
                                      ),
                                      const SizedBox(
                                        height: 80,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            //  CommonUI.getlogoWithTextUI(),
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
        ),
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
