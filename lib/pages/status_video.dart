import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';
import 'package:tarana_app_live/auth_configFile/authconfig.dart';
import 'package:tarana_app_live/components/status_error.dart';
import 'package:tarana_app_live/model_class/status_details_model_item.dart';
import '../Profile/creator_song_profile.dart';
import '../components/favourite_buttom.dart';
import '../components/share_file.dart';

class User_status_video extends StatelessWidget {
  String media,name,userId;
  User_status_video(this.media,this.name, this.userId);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<WhatsappStory>>(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return StoryViewDelegate(
              stories: snapshot.data,
            );
          }

          if (snapshot.hasError) {
            return ErrorView();
          }
          return Center(
            child: SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(),
            ),
          );
        },
        future: Repository.getWhatsappStories(userId),
      ),
        bottomNavigationBar: Container(
            color: Color(0xfff0954f),
            child: ListTile(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Creator_song_profile(userId,"")));
              },
              leading: CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(
                    Base_url().status_image+media
                ),
              ),

              title: Text(
                name,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                ),
              ),
              subtitle: Text(
                "100M Followers",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),

              trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Add_to_favourite(userId),
                    Share_file(),
                    Icon(
                      Icons.more_vert,
                      color: Colors.white,
                      size: 25,
                    ),
                  ]
              ),
            )
        )
    );
  }
}

class StoryViewDelegate extends StatefulWidget {
  final List<WhatsappStory>? stories;

  StoryViewDelegate({this.stories});

  @override
  _StoryViewDelegateState createState() => _StoryViewDelegateState();
}

class _StoryViewDelegateState extends State<StoryViewDelegate> {
  final StoryController controller = StoryController();
  List<StoryItem> storyItems = [];

  String? when = "";

  @override
  void initState() {
    super.initState();
    widget.stories!.forEach((story) {
      // if (story.mediaType == MediaType.text) {
      //   storyItems.add(
      //     StoryItem.text(
      //       title: story.caption!,
      //       backgroundColor: HexColor(story.color!),
      //       duration: Duration(
      //         milliseconds: (story.duration! * 1000).toInt(),
      //       ),
      //     ),
      //   );
      // }

      if (story.mediaType == MediaType.image) {
        storyItems.add(StoryItem.pageImage(
          url: Base_url().status_image+story.media!,
          controller: controller,
          caption: story.caption,
          duration: Duration(
            milliseconds: (story.duration! * 1000).toInt(),
          ),
        ));
      }

      if (story.mediaType == MediaType.video) {
        storyItems.add(
          StoryItem.pageVideo(
            story.media!,
            controller: controller,
            duration: Duration(milliseconds: (story.duration! * 1000).toInt()),
            caption: story.caption,
          ),
        );
      }
    });

    when = widget.stories![0].when;
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        StoryView(
          storyItems: storyItems,
          controller: controller,
          onComplete: () {
            Navigator.of(context).pop();
          },
          onVerticalSwipeComplete: (v) {
            if (v == Direction.down) {
              Navigator.pop(context);
            }
          },
          onStoryShow: (storyItem) {
            int pos = storyItems.indexOf(storyItem);

            // the reason for doing setState only after the first
            // position is becuase by the first iteration, the layout
            // hasn't been laid yet, thus raising some exception
            // (each child need to be laid exactly once)
            if (pos > 0) {
              setState(() {
                when = widget.stories![pos].when;
              });
            }
          },
        ),
      ],
    );
  }
}
