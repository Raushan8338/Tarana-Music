import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Cached_Network_Image extends StatelessWidget {
  String Image;
  double height, width, radius;
  Cached_Network_Image(this.Image, this.height, this.width, this.radius,
      {Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        child: CachedNetworkImage(
          imageUrl: Image,
          height: height,
          width: width,
          fit: BoxFit.cover,
          colorBlendMode: BlendMode.color,
          errorWidget: (context, url, error) => Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            height: height,
            width: width,
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: AspectRatio(
                aspectRatio: 15,
                child: Container(
                  width: 25,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
