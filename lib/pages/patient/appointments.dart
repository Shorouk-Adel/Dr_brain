import 'dart:convert';
import 'dart:math';
import 'package:graduation_dr_brain/Model/doctor.dart';
import 'package:graduation_dr_brain/pages/patient/patient_appointments/appointment_details.dart';
import 'package:graduation_dr_brain/widgets/loading.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:graduation_dr_brain/Model/meeting.dart';
import 'package:graduation_dr_brain/helpers/constants.dart';

import 'Chat/chat.dart';

class PatientAppointment extends StatefulWidget {
  const PatientAppointment({Key? key}) : super(key: key);

  @override
  _PatientAppointmentState createState() => _PatientAppointmentState();
}

class _PatientAppointmentState extends State<PatientAppointment>
    with SingleTickerProviderStateMixin {
  bool isLoading = true;
  List? listOfMaps;
  var now = new DateTime.now();
  List<MeetingModel> appoinments = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: isLoading
          ? Loading()
          : Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0.0,
                title: Text(
                  'Appointment',
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 20,
                  ),
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Chat()));
                      },
                      icon: const Icon(Icons.messenger_outlined,
                          color: Colors.black)),
                ],
              ),
              body: DefaultTabController(
                length: 2,
                child: Column(
                  children: <Widget>[
                    Container(
                      constraints: BoxConstraints.expand(height: 50),
                      child: TabBar(labelColor: Colors.black87, tabs: [
                        Tab(text: "UpComing"),
                        Tab(text: "Past"),
                      ]),
                    ),
                    Expanded(
                      child: Container(
                        child: TabBarView(children: [
                          UpcomingUi(),
                          PastUi(),
                        ]),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }

  Future<void> getData(String id, int index) async {
    final response = await http.get(
      Uri.parse('https://dr-brains.com/api/doctors/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      print(response.body);
      var listOfMaps = jsonDecode(response.body);
      doctorModel = DoctorModel(
          listOfMaps['id'].toString(),
          listOfMaps['full_name'],
          listOfMaps['email'],
          listOfMaps['avatar'].toString().replaceAll('\/', "/"));

      print(doctorModel.full_name);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AppointmentDeteails(appoinments[index])));
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

  Future<void> getPatientAppointments(String id) async {
    final response = await http.get(
      Uri.parse('https://dr-brains.com/api/p-appointments/$id'),
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

      print(patientModel.avatarUrl);
    } else {
      //showToast(text:jsonDecode(response.body)['error'] , state: ToastStates.ERROR);
      throw Exception('Failed to getData');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getPatientAppointments(patientModel.id);
  }

  Widget UpcomingUi() {
    return Container(
      child: getCountUpComing() == 0
          ? Center(child: Text("No Appointments UpComing"))
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: appoinments.length,
              itemBuilder: (BuildContext context, int index) {
                return DateTime.parse(
                                appoinments[index].meetingDateTime.toString())
                            .compareTo(now) >
                        0
                    ? InkWell(
                        onTap: () {
                          getData(
                              appoinments[index].doctorId.toString(), index);
                        },
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
                                              appoinments[index]
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
                                                      appoinments[index]
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
                      )
                    : Container();
              },
            ),
    );
  }

  Widget PastUi() {
    return Container(
      child: appoinments.length - getCountUpComing() == 0
          ? Center(child: Text("No Past Appointments"))
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: appoinments.length,
              itemBuilder: (BuildContext context, int index) {
                return DateTime.parse(
                                appoinments[index].meetingDateTime.toString())
                            .compareTo(now) <
                        0
                    ? InkWell(
                        onTap: () {
                          getData(
                              appoinments[index].doctorId.toString(), index);
                        },
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
                                              appoinments[index]
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
                                                      appoinments[index]
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
                      )
                    : Container();
              },
            ),
    );
  }
}
