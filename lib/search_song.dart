import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tarana_app_live/auth_configFile/authconfig.dart';
import 'package:tarana_app_live/search_result/search_result.dart';
import 'Audio_player_File/notifier/service_locator.dart';
import 'Audio_player_File/page_manager.dart';
import 'components/header_component.dart';
import 'model_class/CategoryList.dart';
import 'components/progress_bar.dart';
import 'model_class/search_model_item.dart';
import 'model_class/select_lang_model.dart';

class Search_song extends StatefulWidget {
  const Search_song({Key? key}) : super(key: key);
  @override
  _Search_songState createState() => _Search_songState();
}

class _Search_songState extends State<Search_song> {
  List<Data> songDetails = [];
  @override
  void initState() {
    super.initState();
    getLanguage_list();
    _loadPlaylist();
  }

  _loadPlaylist() async {
    var jsonResponse = null;
    Map datas = {
      'movie_id':'all',
    };
    var response = await http.post(
        Uri.parse(
            "https://www.itexpress4u.tech/taranaApi/MasterValue_Api/songsList"),
        body: datas);
    jsonResponse = json.decode(response.body);
    var streetsFromJson = jsonResponse['songs_list'];
    // final playlist = streetsFromJson;

    for (var list_datas in streetsFromJson) {
      Data recently_played_iteme = Data(
          name: list_datas['title'], Artist: list_datas['release_year'], Id_current: list_datas['id'], Movie_name: list_datas['movie_name'], singer_name: list_datas['singer_name'], image: list_datas['image']
          , file_name: list_datas['file_name'], colour: list_datas['colour'], language: list_datas['language']);
      songDetails.add(recently_played_iteme);
    }
    return songDetails;
  }

  Future<SearchModelItem> getSearchFeedItem() async {
    Map data = {
    };
    var jsonResponse = null;
    var jsonResponses = null;
    var response = await http.get(Uri.parse(
        Base_url().baseurl+'search_feed'));
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      // print(SearchModelItem.fromJson(jsonResponse));
      return SearchModelItem.fromJson(jsonResponse);
    }
    else {
      // print(SearchModelItem.fromJson(jsonResponse));
      return SearchModelItem.fromJson(jsonResponse);
      print(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black87,
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.fromLTRB(0,10,0,0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    User_name_component(),
                    Header_toggle_view_buttom(),
                  ],
                ),
                InkWell(
                  onTap: (){
                    showSearch(context: context, delegate: SongSearch(songDetails));
                  },
                  child:  Container(
                    height: 45,
                    margin: EdgeInsets.fromLTRB(15,0,15,10),
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextFormField(
                      enabled: false,
                      style: TextStyle(fontSize: 20, color: Colors.black),
                      maxLines: 1,
                      cursorColor: Colors.black,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        contentPadding: new EdgeInsets.symmetric(vertical: 0.0),
                        border: InputBorder.none,
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(10),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                          ), // icon is 48px widget.
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Flexible(
                      child: FutureBuilder<SearchModelItem>(
                          future: getSearchFeedItem(),
                          builder: (context, snapshot){
                            if(snapshot.connectionState == ConnectionState.waiting){
                              return Center(child: progress_bar());
                            }
                            return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: List.generate(
                                    snapshot.data?.searchFeedData.length??0, (index) =>
                                    Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(snapshot.data!.searchFeedData[index].headerTitle,style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: 'poppins')),
                                          ),
                                        ),
                                        SingleChildScrollView(
                                          // scrollDirection: Axis.horizontal,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              GridView.builder(
                                                shrinkWrap: true,
                                                physics: NeverScrollableScrollPhysics(), // gridview slider
                                                itemCount: snapshot.data?.searchFeedData[index].catagories.length,
                                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 3,
                                                  childAspectRatio: MediaQuery.of(context).size.width /
                                                      (MediaQuery.of(context).size.height /2),
                                                ),
                                                itemBuilder: (context,ct) => Container(
                                                    child:   GestureDetector(
                                                      onTap: (){
                                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Search_result(snapshot.data!.searchFeedData[index].catagories[ct].id,snapshot.data!.searchFeedData[index].catagories[ct].name,snapshot.data!.searchFeedData[index].uiCategory)));
                                                      },
                                                      child: (snapshot.data!.searchFeedData[index].uiCategory == "1") ?
                                                      Column(
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius: BorderRadius.all(Radius.circular(100)),
                                                            child: CachedNetworkImage(
                                                              imageUrl:Base_url().image_profile_url+
                                                                  snapshot.data!.searchFeedData[index].catagories[ct].image,
                                                              height: 90.0,
                                                              width: 90.0,
                                                              fit: BoxFit.cover,
                                                              colorBlendMode:BlendMode.color,
                                                              errorWidget: (context, url, error) =>  Container(
                                                                margin: EdgeInsets.fromLTRB(6, 0, 6, 0),
                                                                height: 90.0,
                                                                width: 110.0,
                                                                decoration: BoxDecoration(
                                                                    color: Colors.grey,
                                                                    borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                child: ClipRRect(
                                                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                                                  child: AspectRatio(
                                                                    aspectRatio: 22 / 5,
                                                                    child: Container(
                                                                      color: Colors.grey,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                       /*   Text(
                                                            snapshot.data!.searchFeedData[index].catagories[ct].name,
                                                            style: TextStyle(
                                                                fontSize: 15, color: Colors.white),
                                                            textAlign: TextAlign.center,
                                                          ),*/
                                                        ],
                                                      ):
                                                      Column(
                                                        children: [
                                                          CachedNetworkImage(
                                                            imageUrl: Base_url().image_profile_url+snapshot.data!.searchFeedData[index].catagories[ct].image,
                                                            height: 90.0,
                                                            width: 110.0,
                                                            fit: BoxFit.cover,
                                                            colorBlendMode:BlendMode.color,
                                                            errorWidget: (context, url, error) =>  Container(
                                                              margin: EdgeInsets.fromLTRB(6, 0, 6, 0),
                                                              height: 90.0,
                                                              width: 110.0,
                                                              decoration: BoxDecoration(
                                                                  color: Colors.grey,
                                                                  borderRadius: BorderRadius.all(Radius.circular(10))),
                                                              child: ClipRRect(
                                                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                                                child: AspectRatio(
                                                                  aspectRatio: 22 / 5,
                                                                  child: Container(
                                                                    color: Colors.grey,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Text(
                                                            snapshot.data!.searchFeedData[index].catagories[ct].name,
                                                            style: TextStyle(
                                                                fontSize: 15, color: Colors.white),
                                                            textAlign: TextAlign.center,
                                                          ),
                                                        ],
                                                      )
                                                    )
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],

                                    ))
                            );
                          }
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
class SongSearch extends SearchDelegate<Data> {
  List<Data> songDetails = [];
  SongSearch(this.songDetails);
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(Icons.navigate_before),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Align(alignment: Alignment.topLeft,
      child: Text(""),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final pageManager = getIt<PageManager>();

    final listItems = query.isEmpty
        ? songDetails
        : songDetails
        .where((element) => element.name
        .toLowerCase()
        .startsWith(query.toLowerCase().toString()))
        .toList();
    return listItems.isEmpty
        ? Center(child: Text("No Data Found!"))
        : ListView.builder(
        itemCount: listItems.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.green,
                    backgroundImage: NetworkImage(Base_url().image_url+listItems[index].image),
                  ),
                  title: Text(listItems[index].name),
                  subtitle: Text(listItems[index].singer_name),
                  onTap: () {
                   // getIt<PageManager>().init('all','https://www.itexpress4u.tech/taranaApi/MasterValue_Api/songsList');
                    pageManager.skipToQueueItem(index, listItems[index].name);
                    // showResults(context);
                  }

              ),
              Divider(),
            ],
          );
        }
    );
  }
}

class Data {
  final String name;
  final String Artist;
  final String Id_current;
  final String Movie_name;
  final String singer_name;
  final String image;
  final String file_name;
  final String colour;
  final String language;

  Data({required this.Artist, required this.name,required this.Id_current, required this.Movie_name,required this.singer_name, required this.image,required this.file_name, required this.colour,required this.language});
}