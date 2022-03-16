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