import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:graduation_dr_brain/Model/doctor.dart';
import 'package:graduation_dr_brain/Model/meeting.dart';
import 'package:graduation_dr_brain/helpers/constants.dart';
import 'package:graduation_dr_brain/pages/patient/reports/report_page.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class Reports extends StatefulWidget {
  const Reports({Key? key}) : super(key: key);

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  List? listOfMaps;
  var now = new DateTime.now();
  List<MeetingModel> appoinments = [];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: Colors.white,
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
                        width: 15,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Reports",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 300,
                  childAspectRatio: 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
              itemCount: appoinments.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    getData(appoinments[index].doctorId.toString(), index);
                  },
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black38,
                      ),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.asset(
                              'assets/folder.png',
                              fit: BoxFit.fitWidth,
                              color: Colors.deepOrange,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            appoinments[index].meetingName.toString(),
                            style: TextStyle(fontSize: 18),
                          ),

                        ],
                      ),
                    ),
                  ),
                );
              },
            )));
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
          // isLoading = false;
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
      showBottom(index);
    } else {
      //showToast(text:jsonDecode(response.body)['error'] , state: ToastStates.ERROR);
      throw Exception('Failed to getData');
    }
  }

  void showBottom(int index) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.only(
          topEnd: Radius.circular(25),
          topStart: Radius.circular(25),
        ),
      ),
      builder: (context) => Container(
        padding: EdgeInsetsDirectional.only(
          start: 20,
          end: 20,
          bottom: 30,
          top: 8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 500,
              child: PageView(
                children: <Widget>[
                  SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Report Details",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              "Doctor :",
                              style: TextStyle(
                                color: Colors.black38,
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            CircleAvatar(
                              backgroundImage:
                                  NetworkImage(doctorModel.avatarUrl),
                              maxRadius: 15,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              doctorModel.full_name,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
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
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            // _launchURL();
                            getReport();
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
                            title: Text(
                                "Report ${appoinments[index].meetingName}"),
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
                        SizedBox(height: 30),
                        SizedBox(
                          height: 50,
                          child: RaisedButton(
                            onPressed: () {},
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color: Colors.deepPurple[100],
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.folder_shared_outlined,
                                    color: Colors.black87,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Share File With Doctor",
                                    style: TextStyle(color: Colors.black87),
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
          ],
        ),
      ),
    );
  }


  void _launchURL() async {
    if (!await launch("http://www.africau.edu/images/default/sample.pdf"))
      throw 'Could not launch ';
  }

  void _apiTest() {}

  Future<void> getReport() async {
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
          context,
          MaterialPageRoute(
              builder: (context) => Report(html)));
    } else {
      throw Exception('Failed to getData');
    }
  }

}
