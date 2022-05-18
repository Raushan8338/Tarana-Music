import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class Share_file extends StatelessWidget {
   Share_file({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  IconButton(
        onPressed: (){
          Share.share('hey! check out this new app https://play.google.com/store/search?q=pub%3ADivTag&c=apps', subject: 'DivTag Apps Link');
        },
        icon: Icon(Icons.share,color: Colors.white,));
  }
}
