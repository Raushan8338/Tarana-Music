import 'dart:convert';

CreatorHomePageItem creatorHomePageItemFromJson(String str) =>
    CreatorHomePageItem.fromJson(json.decode(str));

String creatorHomePageItemToJson(CreatorHomePageItem data) =>
    json.encode(data.toJson());

class CreatorHomePageItem {
  CreatorHomePageItem({
    required this.catagoryWiseAlbumList,
  });

  List<CatagoryWiseAlbumList> catagoryWiseAlbumList;

  factory CreatorHomePageItem.fromJson(Map<String, dynamic> json) =>
      CreatorHomePageItem(
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
    required this.id,
    required this.movieName,
    required this.language,
    required this.audioVideoType,
    required this.name,
    required this.userImage,
    required this.movie_image,
    required this.likedBy,
    required this.dislikeBy,
  });

  String id;
  String movieName;
  String language;
  String audioVideoType;
  String name;
  String userImage;
  String movie_image;
  String likedBy;
  String dislikeBy;

  factory CatagoryWiseAlbumList.fromJson(Map<String, dynamic> json) =>
      CatagoryWiseAlbumList(
        id: json["id"],
        movieName: json["movie_name"],
        language: json["language"],
        audioVideoType: json["audio_video_type"],
        name: json["name"],
        userImage: json["user_image"],
        movie_image: json["movie_image"],
        likedBy: json["liked_by"],
        dislikeBy: json["dislike_by"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "movie_name": movieName,
        "language": language,
        "audio_video_type": audioVideoType,
        "name": name,
        "user_image": userImage,
        "movie_image": movie_image,
        "liked_by": likedBy,
        "dislike_by": dislikeBy,
      };
}
