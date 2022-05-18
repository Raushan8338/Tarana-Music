import 'dart:convert';

SearchModelItem searchModelItemFromJson(String str) =>
    SearchModelItem.fromJson(json.decode(str));

String searchModelItemToJson(SearchModelItem data) =>
    json.encode(data.toJson());

class SearchModelItem {
  SearchModelItem({
    required this.searchFeedData,
  });

  List<SearchFeedDatum> searchFeedData;

  factory SearchModelItem.fromJson(Map<String, dynamic> json) =>
      SearchModelItem(
        searchFeedData: List<SearchFeedDatum>.from(
            json["Search_feed_data"].map((x) => SearchFeedDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Search_feed_data":
            List<dynamic>.from(searchFeedData.map((x) => x.toJson())),
      };
}

class SearchFeedDatum {
  SearchFeedDatum({
    required this.headerTitle,
    required this.catagories,
    required this.uiCategory,
  });

  String headerTitle;
  List<Catagory> catagories;
  String uiCategory;

  factory SearchFeedDatum.fromJson(Map<String, dynamic> json) =>
      SearchFeedDatum(
        headerTitle: json["header_title"],
        catagories: List<Catagory>.from(
            json["catagories"].map((x) => Catagory.fromJson(x))),
        uiCategory: json["ui_category"],
      );

  Map<String, dynamic> toJson() => {
        "header_title": headerTitle,
        "catagories": List<dynamic>.from(catagories.map((x) => x.toJson())),
        "ui_category": uiCategory,
      };
}

class Catagory {
  Catagory({
    required this.id,
    required this.name,
    required this.image,
  });

  String id;
  String name;
  String image;

  factory Catagory.fromJson(Map<String, dynamic> json) => Catagory(
        id: json["id"],
        name: json["name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
      };
}
