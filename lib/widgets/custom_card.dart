import 'package:flutter/material.dart';

Widget CustomCard(
{required Color mark,required IconData icon,required String number, required String text}) {


  return Stack(
      alignment: Alignment.topCenter,
      children: [
    Container(
        height: 150,
        width: 120,
        decoration: BoxDecoration(
            boxShadow:[
              BoxShadow(
                color: Colors.grey.withOpacity(0.1), //color of shadow
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 2), // changes position of shadow
                //first paramerter of offset is left-right
                //second parameter is top to down
              ),
            ],
            borderRadius: BorderRadius.circular(20.0), color: Colors.white),
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0,30,0,0),
              child: Icon(icon),
            ),
            const SizedBox(height: 20.0),
            Text(
              number,
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              text,
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
              ),
            ),

          ],
        )),
        Container(
          alignment: Alignment.center,
          height: 75,
          width: 50,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only( bottomRight: Radius.circular(15), bottomLeft: Radius.circular(15),),
              color: mark.withOpacity(0.4)),
        ),
  ]);
}
