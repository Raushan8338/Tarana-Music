import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../auth_configFile/authconfig.dart';
class Slider_banner_page extends StatefulWidget {
   Slider_banner_page({Key? key}) : super(key: key);
  @override
  _Slider_banner_pageState createState() => _Slider_banner_pageState();
}
class _Slider_banner_pageState extends State<Slider_banner_page> {
  List imagess_list=[];
  @override
  void initState() {
    super.initState();
    getSliderData();
  }

  getSliderData() async {
    var jsonResponses =null;
    Map data={
    };
    var response = await http.post(Uri.parse(Base_url().baseurl+'bannerlist'),body: data);
    if (response.statusCode == 200) {
      jsonResponses=jsonDecode(response.body);;
      imagess_list = jsonResponses['banner_list'];
      print(imagess_list);
      setState(() {

      });
      print("sadsad");
    }
    return imagess_list;
  }
  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      child: CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          enlargeCenterPage: true,
          aspectRatio: 15/8,
          viewportFraction: 1,
        ),
        items: imagess_list.map((e) {
          return Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(Base_url().banner_image+e['location'],fit: BoxFit.cover,),
            ),
            /* Image.network(e['location'])*/
          );
        }).toList(),
      ),
    );
  }
}
