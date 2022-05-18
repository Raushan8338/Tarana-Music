import 'dart:convert';
import 'package:http/http.dart';

enum MediaType { image, video, text }

class WhatsappStory {
  final MediaType? mediaType;
  final String? media;
  final double? duration;
  final String? caption;
  final String? when;
  final String? color;

  WhatsappStory({
    this.mediaType,
    this.media,
    this.duration,
    this.caption,
    this.when,
    this.color,
  });
}

class Highlight {
  final String? image;
  final String? headline;

  Highlight({this.image, this.headline});
}


class Repository {
  static MediaType _translateType(String? type) {
    if (type == "image") {
      return MediaType.image;
    }

    if (type == "video") {
      return MediaType.video;
    }

    return MediaType.text;
  }

  static Future<List<WhatsappStory>> getWhatsappStories(userId) async {
    Map datas={
      'user_id':userId
    };
    final uri =
        "https://www.itexpress4u.tech/taranaApi/MasterValue_Api/user_status_by_id";
    final response = await post(Uri.parse(uri),body: datas);
     print(datas);
    print("sdfsdfsdfdsfsdf");
    final data = jsonDecode(utf8.decode(response.bodyBytes))[
    'status'];

    final res = data.map<WhatsappStory>((it) {
      return WhatsappStory(
          caption: it['caption'],
          media: it['media'],
          duration: double.parse('8'),
          when: it['created_time'],
          mediaType: _translateType(it['media_type']),
          color: "");
    }).toList();

    return res;
  }


}
