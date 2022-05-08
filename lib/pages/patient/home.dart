import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_dr_brain/pages/patient/reports/reports.dart';
class PatientHome extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: Text('Home',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          // IconButton( onPressed: () => Navigator.of(context).pop(),
          //     icon: const Icon(Icons.messenger_outlined,
          //         color: Colors.black)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: Image.asset("assets/healt.jpg")
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [

                  Container(
                    width: 120,
                    height: 120,
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.date_range , color: Colors.deepOrange,),
                          SizedBox(height: 5,),
                          Text("Appoinments"),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 120,
                    height: 120,
                    child: InkWell(
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Reports()));
                      },
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.paste_outlined  , color: Colors.green,),
                            SizedBox(height: 10,),
                            Text("Reports"),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 120,
                    height: 120,
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.medication , color: Colors.indigo,),
                          SizedBox(height: 5,),
                          Text("Medicines"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(

                child: Card(
                  child: Container(
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Find Your Doctor Now"),
                          Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}