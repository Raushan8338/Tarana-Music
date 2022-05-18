import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../Profile/user_library/Add_song_file.dart';
import '../Profile/user_library/status_upload_confirmation.dart';
import '../auth_configFile/authconfig.dart';
import '../pages/status_details_page.dart';

class Status_box_item extends StatelessWidget {
  String statusImage, name,page_type;
   Status_box_item(this.statusImage, this.name,this.page_type, {Key? key}) : super(key: key);
  final ImagePicker _picker = ImagePicker();
  late File imageFile;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          child: ClipRRect(
              borderRadius:
              const BorderRadius
                  .all(
                  Radius.circular(
                      5.0)),
              child: Container(
                  color: Colors.grey,
                  child: CachedNetworkImage(
                    imageUrl:
                    Base_url().status_image+statusImage,
                    width: 75,
                    height: 95,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) =>  Container(
                        margin: EdgeInsets.fromLTRB(6, 0, 6, 0),
                        height: 95,
                        width: 75,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        child: Container(
                          width: 95,
                          height: 95,
                          color: Colors.grey,
                          child: Icon(Icons.add,color: Colors.white,),
                        )
                    ),
                  )
              )),
          //   child: Image.network(snapshot.data!.catagoryWiseAlbumList[index1].album[i].image),
        ),
        (page_type == '1') ?
       Container(
              margin: EdgeInsets.fromLTRB(50, 68, 6, 0),
              height: 22,
              width: 22,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: InkWell(
                onTap: ()  async {
                  final pickedFile =
                  await _picker.pickImage(
                    source: ImageSource.gallery,
                    imageQuality: 80,
                  );
                  /*   setState(() {*/
                  banner_image_name =
                      pickedFile!.name.toString();
                  imageFile = File(pickedFile.path);
                  /* });*/
                  //  print(pickedFile!.name.toString());
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Status_upload_confirmation(
                                  File(pickedFile.path))));
                },
                child: Container(
                  width: 20,
                  height: 20,
                  color: Colors.grey,
                  child: Icon(Icons.add,color: Colors.white,),
                ),
              )
          ):SizedBox(),
        Padding(
          padding: EdgeInsets.all(2),
          child: Container(
            height: 20,
            width: 78,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black87
            ),
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 10,
                    backgroundImage: NetworkImage(
                        "https://st.depositphotos.com/1092255/2892/i/600/depositphotos_28923971-stock-photo-dear.jpg"),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0,0,3,0),
                    width: 45,
                    child: RichText(
                      overflow: TextOverflow.ellipsis,

                      text: TextSpan(
                          style: TextStyle(color: Colors.white,fontSize: 8),
                          text: name),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
