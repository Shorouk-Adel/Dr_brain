import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:graduation_dr_brain/helpers/constants.dart';

class SingleChat extends StatefulWidget {
  SingleChat(this.name, this.image, this.id, {Key? key}) : super(key: key);
  String name;
  String image;
  String id;

  @override
  State<SingleChat> createState() =>
      _SingleChatState(this.name, this.image, this.id);
}

class _SingleChatState extends State<SingleChat> {
  _SingleChatState(this.chatName, this.chatImage, this.id);

  String id;
  String chatName;
  String chatImage;
  final datebaseRef = FirebaseDatabase.instance.reference();
  var text = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final database = FirebaseDatabase.instance.reference().child("messages").child("${patientModel.id}-$id").child("messages");
    print(id);
    return Scaffold(
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
                CircleAvatar(
                  backgroundImage: NetworkImage(chatImage),
                  maxRadius: 20,
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
                        chatName,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Online",
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 13),
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
      body: Stack(
        children: <Widget>[
          FirebaseAnimatedList(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            query: database,
            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation<double> animation, int index) {
              return Container(
                padding: EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
                child: Align(
                  alignment: (snapshot.value['sid'].toString()  != patientModel.id ?Alignment.topLeft:Alignment.topRight),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: (snapshot.value['sid'].toString()  != patientModel.id ?Colors.grey.shade200:Colors.deepPurple[200]),
                    ),
                    padding: EdgeInsets.all(16),
                    child: Text(snapshot.value['message'].toString(), style: TextStyle(fontSize: 15),),
                  ),
                ),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: text,
                      decoration: const InputDecoration(
                          hintText: "Write message...",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      if (text.text.isNotEmpty) {
                        sendMessage(text.text);
                      }
                    },
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
                    ),
                    backgroundColor: Colors.deepPurple,
                    elevation: 0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void sendMessage(String message) {
    DateTime now = DateTime.now();
    String KEY = datebaseRef.child("messages").child("${patientModel.id}-$id").child("messages").push().key;
    datebaseRef.child("messages").child("${patientModel.id}-$id").child("messages").child(KEY).set({
      'FID': KEY,
      'message': message,
      'sid': patientModel.id,
      'rid': id.toString(),
      'time': now.hour.toString() + ":" + now.minute.toString(),
    });
  }
}
