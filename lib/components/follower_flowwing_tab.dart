import 'package:flutter/material.dart';

class Flower_flowwing_tab extends StatelessWidget {
  String creator_followerss,creator_followingss;
  Flower_flowwing_tab(this.creator_followerss,this.creator_followingss, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.black26
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                creator_followerss,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                ),
              ),

              Text(
                "Followers",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                ),
              ),
            ],
          ),

          SizedBox(
            height: 50,
            child: VerticalDivider(
              color: Colors.white,
              thickness: 1,
              indent: 3,
              endIndent: 3,
              width: 10,
            ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "0",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                ),
              ),

              Text(
                "Songs",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                ),
              ),
            ],
          ),

          SizedBox(
            height: 50,
            child: VerticalDivider(
              color: Colors.white,
              thickness: 1,
              indent: 3,
              endIndent: 3,
              width: 10,
            ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "0",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                ),
              ),

              Text(
                "Channels",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                ),
              ),
            ],
          ),

          SizedBox(
            height: 50,
            child: VerticalDivider(
              color: Colors.white,
              thickness: 1,
              indent: 3,
              endIndent: 3,
              width: 10,
            ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                creator_followingss,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                ),
              ),

              Text(
                "Following",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
