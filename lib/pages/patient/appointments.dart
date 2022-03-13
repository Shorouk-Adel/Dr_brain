import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:graduation_dr_brain/Model/meeting.dart';
import 'package:graduation_dr_brain/helpers/constants.dart';
class PatientAppointment extends StatefulWidget {
  const PatientAppointment({Key? key}) : super(key: key);
  @override
  _PatientAppointmentState createState() => _PatientAppointmentState();
}
class _PatientAppointmentState extends State<PatientAppointment> {
  List? listOfMaps;
  List <MeetingModel>appoinments = [];
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
          elevation: 0.0,
          title: Text('Appointment',
            style: TextStyle(
              color: Colors.deepPurple,
              fontSize: 20,
            ),
          ),
          actions: [
            IconButton( onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.messenger_outlined,
                    color: Colors.black)),
          ],
        ),
        body: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 150.0,
                ),
                MaterialButton(onPressed: (){},
                  child: Text('current',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.deepPurple,
                    ),),
                ),
                MaterialButton(onPressed: (){},
                  child: Text('Past',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
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
                                  'https://jooinn.com/images/specialist-doctor.jpg'),
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
                            Text("Doctor Name"),
                            Text(appoinments[0].meetingLink.toString(),
                              maxLines: 1,
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
                                    Text("Rate"),
                                    Text(
                                      "4.5",
                                      style: TextStyle(
                                          color: Colors.deepPurple,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
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
                                    Text("20:45",
                                      style: TextStyle(
                                        color: Colors.deepPurple,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
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
                                  child: Text("Confirmed" ,
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
          ],
        ),
      ),
    );
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
            id:listOfMaps[i]['id'],
            doctorEmail:listOfMaps[i]['doctor_email'].toString(),
            doctorId:listOfMaps[i]['doctor_id'].toString(),
            meetingDate:listOfMaps[i]['meeting_date'].toString(),
            meetingDateTime:listOfMaps[i]['meeting_date_time'].toString(),
            meetingDescription:listOfMaps[i]['meeting_description'].toString(),
            meetingId:listOfMaps[i]['meeting_id'].toString(),
            meetingLink:listOfMaps[i]['meeting_link'].toString(),
            meetingName:listOfMaps[i]['meeting_name'].toString(),
            meetingTime:listOfMaps[i]['meeting_time'].toString(),
            patientEmail:listOfMaps[i]['patient_email'].toString(),
            patientId:listOfMaps[i]['patient_id'].toString(),
          ));
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


}