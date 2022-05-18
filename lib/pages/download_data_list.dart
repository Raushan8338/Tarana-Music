import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Download_audio_file extends StatefulWidget {
  const Download_audio_file({Key? key}) : super(key: key);

  @override
  _Download_audio_fileState createState() => _Download_audio_fileState();
}

class _Download_audio_fileState extends State<Download_audio_file> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        leading:  InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back,color: Colors.white,)),
      ),
      body: Center(
        child: SizedBox(
          child: Text("No Data Found",style: TextStyle(color: Colors.white,fontSize: 22),),
        ),
      ),
    );
  }
}
