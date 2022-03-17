import 'package:flutter/material.dart';

Widget Loading(){
  return Container(
    child: Center(
      child: Image.asset('assets/brain.gif'),

    ),
  );
}

Widget LoadingCircular(){
  return Container(
    child: Center(
      child: LinearProgressIndicator(),

    ),
  );
}

Future<void> showError(context)async {
  return showDialog(context: context, builder: (BuildContext context){
    return AlertDialog(
      content: SizedBox(
        width: 100,
        height: 150,
        child: Column(
            children: [
              Container(
                child: Center(
                  child: Column(
                    children: [
                      Text("Failed to Login" , style: TextStyle(fontSize: 25),),
                      SizedBox(height: 5,),
                      Text("Please check the password and email" , style: TextStyle(fontSize: 10),),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Container(
                child: Center(
                  child: SizedBox(
                      height: 70,
                      width: 70,
                      child: Image.asset('assets/error.gif' ,  gaplessPlayback: false), ),
                ),
              ),


            ]

        ),
      ),
    );
  });
}

Future<void> showSuccess(context)async {
  return showDialog(context: context, builder: (BuildContext context){
    return AlertDialog(
      content: SizedBox(
        width: 100,
        height: 150,
        child: Column(
            children: [
              Container(
                child: Center(
                  child: Column(
                    children: [
                      Text("Success" , style: TextStyle(fontSize: 25),),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Container(
                child: Center(
                  child: SizedBox(
                      height: 100,
                      width: 100,
                      child: Image.asset('assets/success.gif' ,  gaplessPlayback: false), ),
                ),
              ),


            ]

        ),
      ),
    );
  });
}


