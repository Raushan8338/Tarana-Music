import 'package:flutter/material.dart';

class Download_file extends StatelessWidget {
  const Download_file({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  IconButton(
      icon: Icon(
        Icons.file_download,
        color: Colors.grey,
        size: 25,
      ),
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Download Not available"),
        ));
      },
    );
  }
}
