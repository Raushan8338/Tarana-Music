import 'package:flutter/material.dart';
import '../auth_configFile/authconfig.dart';
import '../components/header_component.dart';
import '../components/progress_bar.dart';
import 'chat_details.dart';

class Creator_chat extends StatefulWidget {
  String user_image;
  Creator_chat(this.user_image, {Key? key}) : super(key: key);
  @override
  _Creator_chatState createState() => _Creator_chatState(this.user_image);
}

class _Creator_chatState extends State<Creator_chat> {
  String user_image;
  _Creator_chatState(this.user_image);
  @override
  void initState() {
    super.initState();
    getChatListData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black87,
        appBar: AppBar(
          backgroundColor: Colors.black87,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Your Chats',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          actions: [
            Row(
              children: [
                Header_toggle_view_buttom(),
              ],
            )
          ],

        ),
        body: FutureBuilder(
             future: getChatListData(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(child: progress_bar());
                  }
                  return  snapshot.data == null ? Center(
                    child: SizedBox(
                      child: Text("No Data Found",style: TextStyle(color: Colors.white,fontSize: 22),),
                    ),
                  ):
                  ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        //  final Message chat = chats[index];
                        return InkWell(
                        onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChatScreen(snapshot.data[index].c_partner_id,snapshot.data[index].name),
                        ),
                      ),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 15,
                            ),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(2),
                                  decoration: true ? BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(40)),
                                    border: Border.all(
                                      width: 2,
                                      color: Colors.deepOrange,
                                    ),
                                    // shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                      ),
                                    ],
                                  )
                                      : BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                      ),
                                    ],
                                  ),
                                  child: CircleAvatar(
                                    radius: 25,
                                    backgroundImage: NetworkImage("https://navs.org/wp-content/uploads/bb-plugin/cache/bunny-landscape.jpg"),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.75,
                                  padding: EdgeInsets.only(
                                    left: 20,
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Text(
                                                snapshot.data[index].name,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              (snapshot.data[index].unread !="0")?Container(
                                                margin: EdgeInsets.only(left: 5),
                                                width: 7,
                                                height: 7,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.deepOrange,
                                                ),
                                              ): Container(
                                                child: null,
                                              ),

                                            ],
                                          ),
                                          (snapshot.data[index].unread !="0")? Text(
                                            snapshot.data[index].unread,
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ) : Container(
                                            child: null,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                     Container(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          snapshot.data[index].unread,
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.white,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                },

        ));
  }
}

