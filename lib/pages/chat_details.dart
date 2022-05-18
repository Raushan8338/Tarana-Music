import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../auth_configFile/authconfig.dart';
import '../components/progress_bar.dart';
import 'package:http/http.dart' as http;
import '../dashboard_home.dart';
import '../model_class/chat_user_model_item.dart';
class ChatScreen extends StatefulWidget {
  String c_partner_id,name;
  ChatScreen(this.c_partner_id,this.name);
  @override
  _ChatScreenState createState() => _ChatScreenState(this.c_partner_id,this.name);
}
var user_ids;
class _ChatScreenState extends State<ChatScreen> {
  String c_partner_id,name;
  _ChatScreenState(this.c_partner_id,this.name);
  TextEditingController messageController = new TextEditingController();
  @override
  void initState() {
    super.initState();
    getSharedData();
  }
  getSharedData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    user_ids = sharedPreferences.getString("user_id");
  }

  InsertMessageData() async {
    Map data = {
      'user_id':user_ids,
      'sent_to':c_partner_id,
      'message':messageController.text
    };
    var jsonResponses = null;
    var response = await http.post(Uri.parse('https://www.itexpress4u.tech/taranaApi/TaranaUser_Api/user_chat'),
        body: data);
    if (response.statusCode == 200) {
      messageController.clear();
    }
  }

  _sendMessageArea() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      height: 70,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.photo),
            iconSize: 25,
            color: Theme.of(context).primaryColor,
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              controller: messageController,
              decoration: InputDecoration.collapsed(
                hintText: 'Write message..',
              ),
              textCapitalization: TextCapitalization.sentences,
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25,
            color: Theme.of(context).primaryColor,
            onPressed: () {
              InsertMessageData();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int? prevUserId;
    return Scaffold(
      backgroundColor: Color(0xFFE2E2E2),
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        centerTitle: true,
        title: RichText(
          textAlign: TextAlign.left,
          text: TextSpan(
            children: [
              TextSpan(
                  text: name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  )),
              TextSpan(text: '\n'),
              true ?
              TextSpan(
                text: 'Online',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                ),
              )
                  :
              TextSpan(
                text: 'Offline',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: FutureBuilder(
              future: getChatHistory_Details(c_partner_id),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(child: progress_bar());
                }
                return  snapshot.data == null ? Center(
                  child: SizedBox(
                    child: Text("No Data Found",style: TextStyle(color: Colors.black87,fontSize: 22),),
                  ),
                ):
                ListView.builder(
                    itemCount: snapshot.data.length,
                    reverse: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: <Widget>[
                            (snapshot.data[index].send_by != user_ids)?
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      constraints: BoxConstraints(
                                        maxWidth: MediaQuery.of(context).size.width * 0.80,
                                      ),

                                      padding: EdgeInsets.all(10),
                                      margin: EdgeInsets.symmetric(vertical: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                          ),
                                        ],
                                      ),

                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              snapshot.data[index].message,
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black45,
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: Text(
                                              snapshot.data[index].message_date_time,
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black45,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                /*  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        snapshot.data[index].message,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black45,
                                        ),
                                      ),
                                      Text(
                                        snapshot.data[index].message_date_time,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black45,
                                        ),
                                      ),
                                    ],*/
                                 // )

                                ],
                              ),
                            ):
                            Container(
                              alignment: Alignment.topRight,
                              child: Container(
                                constraints: BoxConstraints(
                                  maxWidth: MediaQuery.of(context).size.width * 0.80,
                                ),

                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                    ),
                                  ],
                                ),

                                child: Text(
                                  snapshot.data[index].message,
                                  style: TextStyle(
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            ),
                              ],
                            ),
                      );
                        });
                  },

            )
          ),
          _sendMessageArea(),
        ],
      ),
    );
  }
}
/*ListView.builder(
              reverse: true,
              padding: EdgeInsets.all(20),
              itemCount: 13,
              itemBuilder: (BuildContext context, int index) {
             /*   final Message message = messages[index];
                final bool isMe = message.sender.id == currentUser.id;
                final bool isSameUser = prevUserId == message.sender.id;
                prevUserId = message.sender.id;*/
                return _chatBubble(true,true);
              },
            ),*/