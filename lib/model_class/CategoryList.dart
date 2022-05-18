// To parse this JSON data, do
//
//     final categoryList = categoryListFromJson(jsonString);

import 'dart:convert';

CategoryList categoryListFromJson(String str) =>
    CategoryList.fromJson(json.decode(str));

String categoryListToJson(CategoryList data) => json.encode(data.toJson());

class CategoryList {
  CategoryList({
    required this.catagoryWiseAlbumList,
  });

  List<CatagoryWiseAlbumList> catagoryWiseAlbumList;

  factory CategoryList.fromJson(Map<String, dynamic> json) => CategoryList(
        catagoryWiseAlbumList: List<CatagoryWiseAlbumList>.from(
            json["Catagory_wise_album_list"]
                .map((x) => CatagoryWiseAlbumList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Catagory_wise_album_list":
            List<dynamic>.from(catagoryWiseAlbumList.map((x) => x.toJson())),
      };
}

class CatagoryWiseAlbumList {
  CatagoryWiseAlbumList({
    required this.catagoryName,
    required this.catagory_type,
    required this.album,
  });

  String catagoryName, catagory_type;
  List<Album> album;

  factory CatagoryWiseAlbumList.fromJson(Map<String, dynamic> json) =>
      CatagoryWiseAlbumList(
        catagoryName: json["catagory_name"],
        catagory_type: json["catagory_type"],
        album: List<Album>.from(json["album"].map((x) => Album.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "catagory_name": catagoryName,
        "album": List<dynamic>.from(album.map((x) => x.toJson())),
      };
}

class Album {
  Album(
      {required this.id,
      required this.movieName,
      required this.image,
      required this.catagoryId,
      required this.releaseYear,
      required this.status,
      required this.cBy,
      // required this.cDate,
      required this.name,
      required this.user_image,
      required this.audio_video_type});

  String id;
  String movieName;
  String image;
  String catagoryId;
  String releaseYear;
  String status;
  String cBy;

  // DateTime cDate;
  String audio_video_type, name, user_image;

  factory Album.fromJson(Map<String, dynamic> json) => Album(
      id: json["id"],
      movieName: json["movie_name"],
      image: json["image"],
      catagoryId: json["catagory_id"],
      releaseYear: json["release_year"],
      status: json["status"],
      cBy: json["c_by"],
      name: json["name"],
      user_image: json["user_image"],
      // cDate: DateTime.parse(json["c_date"]),
      audio_video_type: json["audio_video_type"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "movie_name": movieName,
        "image": image,
        "catagory_id": catagoryId,
        "release_year": releaseYear,
        "status": status,
        "c_by": cBy,
        "name": name,
        "user_image": user_image,
        //"c_date": cDate.toIso8601String(),
        "audio_video_type": audio_video_type,
      };
}
