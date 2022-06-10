import 'dart:math';

import 'package:flutter/material.dart';
import 'package:graduation_dr_brain/Model/meeting.dart';
import 'package:graduation_dr_brain/helpers/constants.dart';
import 'package:graduation_dr_brain/widgets/loading.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DoctorHome extends StatefulWidget {
  const DoctorHome({Key? key}) : super(key: key);

  @override
  _DoctorHomeState createState() => _DoctorHomeState();
}

class _DoctorHomeState extends State<DoctorHome> {
  @override
  void initState() {
    getDoctorAppointments(doctorModel.id);

  }
  bool isLoading = true;
  List<MeetingModel> appoinments = [];
  var now = new DateTime.now();
  var last ;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home:  isLoading
          ? Loading()
          :Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "Home",
            style: TextStyle(color: Colors.deepPurple, fontSize: 20),
          ),
          actions: [
            IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.circle_notifications,
                    color: Colors.black)),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Text(
                "Meetings",
                style: TextStyle(
                    color: Colors.deepPurpleAccent,
                    fontSize: 20,
                    fontWeight: FontWeight.normal),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Card(
                    color: Colors.deepPurple,
                    child: Container(
                      width: 150,
                      height: 150,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            getCountUpComing().toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 50,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "UpComing",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Card(
                    color: Colors.orange,
                    child: Container(
                      width: 150,
                      height: 150,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            getCountPast().toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 50,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Past",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Text(
                "Next Patient",
                style: TextStyle(
                    color: Colors.deepPurpleAccent,
                    fontSize: 20,
                    fontWeight: FontWeight.normal),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    height: 100,
                    child: Card(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              width: 5.0,
                              color: Colors.primaries[Random()
                                  .nextInt(Colors.primaries.length)],
                            ),
                          ),
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text("Meeting Name"),
                                  Text(
                                    appoinments[last]
                                        .meetingName
                                        .toString(),
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: Colors.deepPurple,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text("Time"),
                                          Text(
                                            appoinments[last]
                                                .meetingDateTime
                                                .toString(),
                                            style: TextStyle(
                                              color:
                                              Colors.deepPurple,
                                              fontSize: 12,
                                              fontWeight:
                                              FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  Future<void> getDoctorAppointments(String id) async {
    final response = await http.get(
      Uri.parse('https://dr-brains.com/api/dr-appointments/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      print(response.body);
      List listOfMaps = jsonDecode(response.body);
      setState(() {
        for (int i = 0; i < listOfMaps.length; i++) {
          appoinments.add(MeetingModel(
            id: listOfMaps[i]['id'],
            doctorEmail: listOfMaps[i]['doctor_email'].toString(),
            doctorId: listOfMaps[i]['doctor_id'].toString(),
            meetingDate: listOfMaps[i]['meeting_date'].toString(),
            meetingDateTime: listOfMaps[i]['meeting_date_time'].toString(),
            meetingDescription: listOfMaps[i]['meeting_description'].toString(),
            meetingId: listOfMaps[i]['meeting_id'].toString(),
            meetingLink: listOfMaps[i]['meeting_link'].toString(),
            meetingName: listOfMaps[i]['meeting_name'].toString(),
            meetingTime: listOfMaps[i]['meeting_time'].toString(),
            patientEmail: listOfMaps[i]['patient_email'].toString(),
            patientId: listOfMaps[i]['patient_id'].toString(),
          ));
          isLoading = false;
          print(appoinments[i].meetingLink);
        }
      });
      last = appoinments.length-1;
      print(doctorModel.avatarUrl);
      print(doctorModel.full_name);

    } else {
      //showToast(text:jsonDecode(response.body)['error'] , state: ToastStates.ERROR);
      throw Exception('Failed to getData');
    }
  }
  int getCountUpComing() {
    int count = 0;
    DateTime nowTime = new DateTime.now();

    for (int i = 0; i < appoinments.length; i++) {
      if (appoinments[i]
          .meetingDateTime
          .toString()
          .compareTo(nowTime.toString()) >
          0) {
        count++;
      }
    }
    print(count);
    return count;
  }
  int getCountPast() {
    int count = 0;
    DateTime nowTime = new DateTime.now();
    count = appoinments.length - getCountUpComing();
    print(count);
    return count;
  }







}
