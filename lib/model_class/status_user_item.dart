
import 'dart:convert';
import 'dart:ui';

import 'package:tarana_app_live/model_class/status_details_model_item.dart';
import 'package:video_player/video_player.dart';

StatusUserItem statusUserItemFromJson(String str) => StatusUserItem.fromJson(json.decode(str));

String statusUserItemToJson(StatusUserItem data) => json.encode(data.toJson());

class StatusUserItem {
  StatusUserItem({
    required this.userStatus,
    required this.followerStatus,
  });

  ErStatus userStatus;
  List<ErStatus> followerStatus;

  factory StatusUserItem.fromJson(Map<String, dynamic> json) => StatusUserItem(
    userStatus: ErStatus.fromJson(json["user_status"]),
    followerStatus: List<ErStatus>.from(json["follower_status"].map((x) => ErStatus.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "user_status": userStatus.toJson(),
    "follower_status": List<dynamic>.from(followerStatus.map((x) => x.toJson())),
  };
}

class ErStatus {
  ErStatus({
    required this.user,
    required this.status,
  });

  User user;
  List<User> status;

  factory ErStatus.fromJson(Map<String, dynamic> json) => ErStatus(
    user: User.fromJson(json["user"]),
    status: List<User>.from(json["status"].map((x) => User.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
    "status": List<dynamic>.from(status.map((x) => x.toJson())),
  };
}

class User {
  User({
    required this.id,
    required this.userId,
    required this.media,
    required this.duration,
    required this.isExpired,
    required this.createdTime,
    required this.expiryTime,
    required this.totalView,
    required this.name,
  });

  String id;
  String userId;
  String media;
  String duration;
  String isExpired;
  DateTime createdTime;
  DateTime expiryTime;
  String totalView;
  String name;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    userId: json["user_id"],
    media: json["media"],
    duration: json["duration"],
    isExpired: json["is_expired"],
    createdTime: DateTime.parse(json["created_time"]),
    expiryTime: DateTime.parse(json["expiry_time"]),
    totalView: json["total_view"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "media": media,
    "duration": duration,
    "is_expired": isExpired,
    "created_time": createdTime.toIso8601String(),
    "expiry_time": expiryTime.toIso8601String(),
    "total_view": totalView,
    "name": name,
  };
}