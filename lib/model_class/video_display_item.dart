import 'dart:convert';

VideoDisplayItem videoDisplayItemFromJson(String str) =>
    VideoDisplayItem.fromJson(json.decode(str));

String videoDisplayItemToJson(VideoDisplayItem data) =>
    json.encode(data.toJson());

class VideoDisplayItem {
  VideoDisplayItem({
    required this.catagoryWiseVideoList,
  });

  List<CatagoryWiseVideoList> catagoryWiseVideoList;

  factory VideoDisplayItem.fromJson(Map<String, dynamic> json) =>
      VideoDisplayItem(
        catagoryWiseVideoList: List<CatagoryWiseVideoList>.from(
            json["Catagory_wise_video_list"]
                .map((x) => CatagoryWiseVideoList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Catagory_wise_video_list":
            List<dynamic>.from(catagoryWiseVideoList.map((x) => x.toJson())),
      };
}

class CatagoryWiseVideoList {
  CatagoryWiseVideoList({
    required this.catagoryName,
    required this.catagoryType,
    required this.videos,
  });

  String catagoryName;
  String catagoryType;
  List<Video> videos;

  factory CatagoryWiseVideoList.fromJson(Map<String, dynamic> json) =>
      CatagoryWiseVideoList(
        catagoryName: json["catagory_name"],
        catagoryType: json["catagory_type"],
        videos: List<Video>.from(json["videos"].map((x) => Video.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "catagory_name": catagoryName,
        "catagory_type": catagoryType,
        "videos": List<dynamic>.from(videos.map((x) => x.toJson())),
      };
}

class Video {
  Video({
    required this.id,
    required this.cate_id,
    required this.lang_id,
    required this.colour,
    required this.image,
    required this.file_name,
    required this.title,
    required this.releaseYear,
    required this.status,
    required this.c_by,
    required this.c_date,
    required this.name,
    required this.userImage,
  });

  String id;
  String cate_id;
  String lang_id;
  String colour;
  String image;
  String file_name;
  String title;
  String releaseYear;
  String status;
  String c_by;
  DateTime c_date;
  String name;
  String userImage;

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        id: json["id"],
        cate_id: json["cate_id"],
        lang_id: json["lang_id"],
        colour: json["colour"],
        image: json["image"],
        file_name: json["file_name"],
        title: json["title"],
        releaseYear: json["release_year"],
        status: json["status"],
        c_by: json["c_by"],
        c_date: DateTime.parse(json["c_date"]),
        name: json["name"],
        userImage: json["user_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cate_id": cate_id,
        "lang_id": lang_id,
        "colour": colour,
        "image": image,
        "file_name": file_name,
        "title": title,
        "release_year": releaseYear,
        "status": status,
        "c_by": c_by,
        "c_date": c_date.toIso8601String(),
        "name": name,
        "user_image": userImage,
      };
}
