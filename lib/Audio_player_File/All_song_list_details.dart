import 'dart:convert';

import 'package:http/http.dart' as http;
abstract class PlaylistRepository {
  Future<List<Map<String, String>>> fetchInitialPlaylist();
  Future<Map<String, String>> fetchAnotherSong();
}

class DemoPlaylist extends PlaylistRepository {
  @override
  Future<List<Map<String, String>>> fetchInitialPlaylist(
      {int length = 3}) async {
    return List.generate(length, (index) => _nextSong());
  }

  @override
  Future<Map<String, String>> fetchAnotherSong() async {
    return _nextSong();
  }

  var _songIndex = 0;
  static const _maxSongNumber = 16;

     _nextSong() async {
       var jsonResponse = null;
       Map datas = {
         'movie_id':'0',
       };
       var response = await http.post(
           Uri.parse('https://www.itexpress4u.tech/taranaApi/MasterValue_Api/songsList'),
           body: datas);
       jsonResponse = json.decode(response.body);
       var streetsFromJson = jsonResponse['songs_list'];

  }
}

/*Map<String, String> _nextSong() {
    _songIndex = (_songIndex % _maxSongNumber) + 1;
    return {
      'id': _songIndex.toString().padLeft(3, '0'),
      'title': 'Song $_songIndex',
      'album': 'SoundHelix',
      'url':
          'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-$_songIndex.mp3',
    };
  }*/