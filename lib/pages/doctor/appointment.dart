import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppointmentDoctor extends StatefulWidget {
  const AppointmentDoctor({Key? key}) : super(key: key);

  @override
  _AppointmentDoctorState createState() => _AppointmentDoctorState();
}

class _AppointmentDoctorState extends State<AppointmentDoctor> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(
              "Appointment",
              style: TextStyle(color: Colors.deepPurple, fontSize: 20),
            ),
            actions: [
              IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.circle_notifications,
                      color: Colors.black)),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 150,
              child: Card(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 120,
                        height: 120,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4R4MFQR8vAkhxBlg_ZxTlHGo8nqwrk0Ua6g&usqp=CAU'),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Patient Name"),
                          Text(
                            "Kareem Hesham",
                            style: TextStyle(
                                color: Colors.deepPurple,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Age"),
                                  Text(
                                    "29",
                                    style: TextStyle(
                                        color: Colors.deepPurple,
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Time"),
                                  Text(
                                    "20:45",
                                    style: TextStyle(
                                        color: Colors.deepPurple,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Status"),
                              Container(
                                width: 100,
                                height: 20,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: Colors.green,
                                ),
                                child: Text(
                                  "Approved",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
