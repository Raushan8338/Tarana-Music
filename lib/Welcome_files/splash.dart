import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../auth_configFile/authconfig.dart';
import '../components/commonUI.dart';
import '../home.dart';
import 'login.dart';
import 'package:http/http.dart' as http;

class SplashPage extends StatefulWidget {
  String isSwitched,switch_mode;
  SplashPage(this.isSwitched,this.switch_mode, {Key? key}) : super(key: key);
  @override
  _SplashPageState createState() => _SplashPageState(this.isSwitched,this.switch_mode);
}
String is_creators='';
var user_ids='';
class _SplashPageState extends State<SplashPage> {
  String isSwitched,switch_mode;
  _SplashPageState(this.isSwitched,this.switch_mode);
  bool isLoading = true;
  Login_shared() async {
    final SharedPreferences sharedPreferences = await SharedPreferences
        .getInstance();
    if (sharedPreferences.getString("logged_in") == null) {
      Future.delayed(Duration(seconds: 3), () =>
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder:
                  (context) =>
                  SignInScreen()
              )
          )
      );
    }
    else {
      if (isSwitched == "" && switch_mode =="switch_mode") {
        Future.delayed(Duration(seconds: 3), () =>
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomeScreen()
            )
            )
        );
      }
      else if (switch_mode =="switch_mode"){
        print("sdfsdfsdfdsfsd--elseif");
        isLoading = true;
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        user_ids = sharedPreferences.getString("user_id")!;
        Map data = {
          'user_id':user_ids,
          'status':isSwitched
        };
        var jsonResponse = null;
        print(data);
        print("data");
        var response = await http.post(Uri.parse('https://www.itexpress4u.tech/taranaApi/TaranaUser_Api/switch_to_creator'),
            body: data);
        if(response.statusCode == 200) {
          setState(() {
            isLoading = false;
            sharedPreferences.setString("is_creator",isSwitched);
          });
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => SplashPage("", "")));
          //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
        }
      }
      else {
        print("sdfsdfsdfdsfsd--else");
        isLoading = true;
        SharedPreferences sharedPreferences = await SharedPreferences
            .getInstance();
        user_ids = sharedPreferences.getString("user_id")!;
       // print(user_id);
        Map data = {
          'user_id': user_ids
        };
        print(data);
        var jsonResponse = null;
        var response = await http.post(Uri.parse(
            Base_url().baseurl + 'user_details'),
            body: data);
        // print("data");
        print(Base_url().baseurl + 'user_details');
        if (response.statusCode == 200) {
          jsonResponse = json.decode(response.body);
          print(jsonResponse);
          var is_creator = jsonResponse['is_creator'];
          setState(() {
            isLoading = false;
            sharedPreferences.setString("is_creator", jsonResponse['is_creator']);
            is_creators = is_creator;
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          }
          );
        }
      }
    }
  }
  @override
  void initState() {
    super.initState();
    Login_shared();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.black87,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Container(
                  margin: EdgeInsets.fromLTRB(0, 65, 0, 0),
                  child: CommonUI.getlogoWithTextUI()),
              Spacer(),
              CircularProgressIndicator(
              ),
              SizedBox(
                height: 45,
              ),
              Center(
                  child:(isSwitched == "") ? SizedBox():(isSwitched == "0" && switch_mode=="switch_mode") ? Text("Switching to user mode",
                    style: TextStyle(fontSize: 15, color: Colors.white),): (isSwitched == "1" && switch_mode=="switch_mode") ? Text("Switching to creator mode",
                    style: TextStyle(fontSize: 15, color: Colors.white),):SizedBox()),
              SizedBox(
                height: 60,
              )
            ],
          )
        // const Icon(
        //   Icons.music_note,
        // )
      ),
    );
  }
}


// class SecondScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("GeeksForGeeks")),
//       body: Center(
//           child: Text(
//         "Home page",
//         textScaleFactor: 2,
//       )),
//     );
//   }
// }
