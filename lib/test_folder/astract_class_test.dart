import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model_class/CategoryList.dart';
abstract class TestClass{
  Future<dynamic> Test_details(String album_ids);
}
class Give_user_details extends TestClass {
  @override
  Future<dynamic> Test_details(album_ids) async {
    Map datas = {
      'movie_id': album_ids,
    };

    var jsonResponse=null;
    var response = await http.post(
        Uri.parse(
            'https://www.itexpress4u.tech/taranaApi/MasterValue_Api/songsList'),
        body: datas);
    jsonResponse = json.decode(response.body);
    var streetsFromJson = jsonResponse['songs_list'];
    print("album_ids");
    print(streetsFromJson);
    return streetsFromJson;
  }
}