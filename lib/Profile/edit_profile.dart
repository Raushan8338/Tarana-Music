import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:getwidget/types/gf_checkbox_type.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Edit_profile_info extends StatefulWidget {
  String creator_names, creator_dobs, creator_phones, creator_emails;

  Edit_profile_info(this.creator_names, this.creator_dobs, this.creator_phones,
      this.creator_emails,
      {Key? key})
      : super(key: key);

  @override
  _Edit_profile_infoState createState() => _Edit_profile_infoState(
      this.creator_names,
      this.creator_dobs,
      this.creator_phones,
      this.creator_emails);
}

class _Edit_profile_infoState extends State<Edit_profile_info> {
  String creator_names, creator_dobs, creator_phones, creator_emails;

  _Edit_profile_infoState(this.creator_names, this.creator_dobs,
      this.creator_phones, this.creator_emails);

  bool _isLoading = false;

  updateProfile_dob(user_id, phone, dob) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var user_ids = sharedPreferences.getString("user_id");
    Map data = {
      'user_id': user_ids,
      'phone': "6204571918",
      'dob': "04/03/1798",
    };
    var jsonResponse = null;
    print(data);
    var response = await http.post(
        Uri.parse(
            "https://www.itexpress4u.tech/taranaApi/TaranaUser_Api/update_profile"),
        body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);

      setState(() {
        _isLoading = false;
      });
      print(jsonResponse);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return new AlertDialog(
              title: Text(jsonResponse['message']),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Cancel'),
                ),
              ],
            );
          });
      // print(jsonResponse);
    }
  }

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Edit Profile"),
        actions: [],
      ),
      backgroundColor: Colors.black87,
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Stack(children: [
          _isLoading ? CircularProgressIndicator_cuastom() : Container(),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                  initialValue: creator_names,
                  keyboardType: TextInputType.name,
                  maxLines: 1,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    fillColor: Colors.white24,
                    filled: false,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 0.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 0.0),
                    ),
                    hintStyle: TextStyle(color: Colors.white, fontSize: 17),
                    hintText: 'Your Name',
                  )),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                  initialValue: creator_emails,
                  keyboardType: TextInputType.emailAddress,
                  maxLines: 1,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    fillColor: Colors.blueGrey,
                    filled: false,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 0.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 0.0),
                    ),
                    hintStyle: TextStyle(color: Colors.white, fontSize: 17),
                    hintText: "Your Email Id",
                  )),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                  initialValue: creator_phones,
                  keyboardType: TextInputType.number,
                  maxLines: 1,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    fillColor: Colors.blueGrey,
                    filled: false,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 0.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 0.0),
                    ),
                    hintStyle: TextStyle(color: Colors.white, fontSize: 17),
                    hintText: "Your Mobile no",
                  )),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                  initialValue: creator_dobs,
                  keyboardType: TextInputType.datetime,
                  maxLines: 1,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    fillColor: Colors.blueGrey,
                    filled: false,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 0.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 0.0),
                    ),
                    hintStyle: TextStyle(color: Colors.white, fontSize: 17),
                    hintText: "DOB",
                  )),
              SizedBox(
                height: 30,
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _isLoading = true;
                  });
                  updateProfile_dob('', '', '');
                  //  Center(child: CircularProgressIndicator());
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
              GFCheckbox(
                size: GFSize.SMALL,
                type: GFCheckboxType.custom,
                onChanged: (value) {
                  setState(() {
                    isChecked = value;
                  });
                },
                value: isChecked,
                inactiveIcon: null,
              ),
              GFCheckbox(
                type: GFCheckboxType.square,
                activeBgColor: GFColors.SECONDARY,
                activeIcon: Icon(Icons.sentiment_satisfied),
                onChanged: (value) {
                  setState(() {
                    isChecked = value;
                  });
                },
                value: isChecked,
                inactiveIcon: Icon(Icons.sentiment_dissatisfied),
              ),
              GFCheckbox(
                size: GFSize.MEDIUM,
                type: GFCheckboxType.custom,
                onChanged: (value) {
                  setState(() {
                    isChecked = value;
                  });
                },
                value: isChecked,
                //  custombgColor: GFColors.INFO,
              ),
            ],
          ),
        ]),
      )),
    );
  }
}

class CircularProgressIndicator_cuastom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      backgroundColor: Colors.red,
      strokeWidth: 8,
    );
  }
}
