import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_dr_brain/Model/meeting.dart';
import 'package:graduation_dr_brain/helpers/constants.dart';
import 'package:graduation_dr_brain/pages/patient/Chat/chat.dart';
import 'package:graduation_dr_brain/pages/patient/reports/report_page.dart';
import 'package:graduation_dr_brain/services/doctor/doctor_layout.dart';
import 'package:graduation_dr_brain/services/patient/patient_cubit.dart';
import 'package:graduation_dr_brain/services/patient/patient_layout.dart';
import 'package:graduation_dr_brain/services/patient/patient_states.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import 'Chat/dr_chat.dart';

class DrAppointmentDetails extends StatelessWidget {
  MeetingModel appoinment;

  DrAppointmentDetails(this.appoinment, {Key? key}) : super(key: key);
  final datebaseRef = FirebaseDatabase.instance.reference();
  late PatientCubit myCubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => PatientCubit(),
      child: BlocConsumer<PatientCubit, PatientStates>(
          listener: (context, state) {},
          builder: (context, state) {
            myCubit = PatientCubit.get(context);

            return MaterialApp(
              home: Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  leading: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.arrow_back_ios,
                          color: Colors.black87)),
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  title: Text(
                    'Appointment Details',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  actions: [
                    IconButton(
                        onPressed: () {
                          Dialogs.materialDialog(
                              msg:
                                  'Are you sure to delete ? you can\'t undo this',
                              title: "Delete",
                              color: Colors.white,
                              context: context,
                              actions: [
                                IconsButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  text: 'Cancel',
                                  iconData: Icons.cancel_outlined,
                                  textStyle: TextStyle(color: Colors.grey),
                                  iconColor: Colors.grey,
                                ),
                                IconsButton(
                                  onPressed: () {
                                    deleteAppointment(
                                        appoinment.id.toString(), context);
                                  },
                                  text: 'Delete',
                                  iconData: Icons.delete,
                                  color: Colors.red,
                                  textStyle: TextStyle(color: Colors.white),
                                  iconColor: Colors.white,
                                ),
                              ]);
                        },
                        icon: const Icon(Icons.delete_forever_outlined,
                            color: Colors.black87)),
                  ],
                ),
                body: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appoinment.meetingName.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 25,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Icon(Icons.calendar_today_outlined,
                              color: Colors.black87),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            appoinment.meetingDateTime.toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text(
                            "Patient Email :",
                            style: TextStyle(
                              color: Colors.black38,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),

                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            appoinment.patientEmail.toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: Text("Desription :"),
                        children: [
                          Text(appoinment.meetingDescription.toString()),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      SizedBox(height: 10),
                      Divider(),
                      Row(
                        children: [
                          Icon(Icons.connect_without_contact_outlined,
                              color: Colors.black87),
                          SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Communication",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black38,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                "This Section To Communicate With Doctor",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black38,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 15,
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 50,
                            child: RaisedButton(
                              onPressed: () {
                                startChat();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DrChat()));
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              color: Colors.deepPurple[100],
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.chat_bubble_outline,
                                      color: Colors.black87,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Chat",
                                      style: TextStyle(color: Colors.black87),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          SizedBox(
                            height: 50,
                            child: RaisedButton(
                              onPressed: () {
                                _launchURL();
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              color: Colors.white,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.voice_chat_outlined,
                                      color: Colors.deepPurple[100],
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Meeting Call",
                                      style: TextStyle(color: Colors.black87),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Divider(),
                      Row(
                        children: [
                          Icon(Icons.paste_outlined, color: Colors.black87),
                          SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Reports",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black38,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                "All doctor reports shows here",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black38,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 15,
                          ),
                        ],
                      ),
                      SizedBox(height: 10),

                      InkWell(
                        onTap: () {
                          // _launchURL();
                          getReport(context);
                        },
                        child: ListTile(
                          leading: Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(
                                'assets/folder.png',
                                fit: BoxFit.fitWidth,
                                color: Colors.red[900],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  "PDF",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                          title:
                              Text("Report ${appoinment.meetingName}"),
                          subtitle: Text(
                            "Tap To Open",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black38,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  void _launchURL() async {
    if (!await launch(appoinment.meetingLink.toString()))
      throw 'Could not launch ${appoinment.meetingLink.toString()}';
  }

  void startChat() {
    String KEY = datebaseRef.child("chats").push().key;

    datebaseRef
        .child("chats")
        .child(appoinment.patientId.toString() + "p")
        .child(doctorModel.id.toString() + "d")
        .set({
      'FID': KEY,
      'name': doctorModel.full_name,
      'id': doctorModel.id.toString(),
      'status': "offline",
      'image': doctorModel.avatarUrl,
    });

    KEY = datebaseRef.child("chats").push().key;
    datebaseRef
        .child("chats")
        .child(appoinment.patientId.toString() + "p")
        .child(doctorModel.id.toString() + "d")
        .set({
      'FID': KEY,
      'name': patientModel.full_name,
      'id': patientModel.id,
      'status': "offline",
      'image': patientModel.avatarUrl,
    });
  }

  //move in cubit later
  Future<void> deleteAppointment(String id, context) async {
    final response = await http.delete(
      Uri.parse('https://dr-brains.com/api/appointments/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      print("Deleted");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => DoctorLayout()));
    } else {
      throw Exception('Failed to delete');
    }
  }

  Future<void> getReport(context) async {
    final response = await http.post(
      Uri.parse('https://dr-brains.com/api/testpdf'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'id': "21",
      }),
    );
    if (response.statusCode == 200) {
      print(response.body);
//Report
      var html = response.body;
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Report(html)));
    } else {
      throw Exception('Failed to getData');
    }
  }
}
