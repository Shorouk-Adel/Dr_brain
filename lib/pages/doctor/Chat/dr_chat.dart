import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:graduation_dr_brain/helpers/constants.dart';
import 'package:graduation_dr_brain/pages/patient/Chat/single_chat.dart';

import 'dr_single_chat.dart';

class DrChat extends StatefulWidget {
  const DrChat({Key? key}) : super(key: key);

  @override
  State<DrChat> createState() => _DrChatState();
}

class _DrChatState extends State<DrChat> {
  final database = FirebaseDatabase.instance.reference().child("chats").child(doctorModel.id+"d");

  final mykey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: mykey,
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          flexibleSpace: SafeArea(
            child: Container(
              padding: EdgeInsets.only(right: 16),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 2,
                  ),

                  SizedBox(
                    width: 12,
                  ),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Chats",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),


                      ],
                    ),
                  ),
                  Icon(
                    Icons.settings,
                    color: Colors.black54,
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              FirebaseAnimatedList(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                query: database,
                itemBuilder: (BuildContext context, DataSnapshot snapshot,
                    Animation<double> animation, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DrSingleChat(snapshot.value['name'].toString() ,snapshot.value["image"] , snapshot.value["id"])));
                    },
                    child: Card(
                      child: ListTile(
                        leading: SizedBox(
                          height: 50.0,
                          width: 50.0,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(snapshot.value["image"]),
                            maxRadius: 10,
                          ),
                        ),
                        title: Text(
                          snapshot.value['name'].toString(),
                          style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),

                      ),
                    ),
                  );
                },
              ),

            ],
          ),
        ),

      ),
    );
  }

}
