import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tarana_app_live/Profile/musician_profile.dart';
import 'package:tarana_app_live/auth_configFile/authconfig.dart';

import '../components/update_profile_pic.dart';

class View_profile_pic extends StatelessWidget {
   String image;
   View_profile_pic(this.image, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: Text("Profile photo",
          style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold
          ),),

        actions: [
          Row(
            children: [
              Update_profile_pic(),

            IconButton(
                onPressed: () {
                  Share.share(
                      'hey! check out this new app https://play.google.com/store/search?q=pub%3ADivTag&c=apps',
                      subject: 'DivTag Apps Link');
                },
                icon: Icon(Icons.share_rounded,
                  color: Colors.white,
                )
            )
          ],
          )
        ],
      ),

      body: Center(
        child: Container(
            height: MediaQuery.of(context).size.height/2.5,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        image),
                    fit: BoxFit.fill)
            )
        ),
      ),
    );
  }
}