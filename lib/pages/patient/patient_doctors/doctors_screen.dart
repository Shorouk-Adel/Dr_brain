import 'dart:convert';
import 'package:graduation_dr_brain/helpers/constants.dart';
import 'package:graduation_dr_brain/Model/model.dart';
import 'package:graduation_dr_brain/widgets/custom_card.dart';
import 'package:graduation_dr_brain/widgets/loading.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'doctor_details.dart';

class DoctorsScreen extends StatefulWidget {
  const DoctorsScreen({Key? key}) : super(key: key);

  @override
  _DoctorsScreenState createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends State<DoctorsScreen> {
  bool isLoading = true;
  List? listOfMaps;
  List<DoctorModel> listOfDrs = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "Doctors",
            style: TextStyle(color: Colors.deepPurple, fontSize: 20),
          ),
        ),
        body: isLoading
            ? Loading()
            : ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: listOfDrs.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DoctorDetails(listOfDrs[index])));
                    },
                    child: SizedBox(
                      height: 100,
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 45,
                                backgroundImage: NetworkImage(
                                  // listOfDrs[index].avatar.toString(),
                                  listOfDrs[index].avatar,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    listOfDrs[index].full_name,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text("Neurosurgery"),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    "Avilable",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green[800],
                                      fontSize: 10,
                                    ),
                                  ),

                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }

  Future<void> fetchData() async {
    final response = await http
        .get(Uri.parse('https://dr-brains.com/api/doctors'), headers: {
      //'Content-Type': 'application/json',

      'Authorization': 'Bearer $token',
      //HttpHeaders.authorizationHeader: 'Bearer $token',
    });
    print('Token : $token');
    if (response.statusCode == 200) {
      print('response status code is: ${response.statusCode}');
      print('ok.. data is retrieved successfully');
      listOfMaps = jsonDecode(response.body);
      //  print(listOfMaps);

      setState(() {
        isLoading = false;
        for (int i = 0; i < listOfMaps!.length; i++) {
          listOfDrs.add(DoctorModel(
              listOfMaps![i]['id'],
              listOfMaps![i]['full_name'],
              listOfMaps![i]['email'],
              listOfMaps![i]['phone'],
              listOfMaps![i]['location'].toString(),
              listOfMaps![i]['avatar']));
        }
      });
    } else {
      throw Exception('unfortunately.. data has some problems');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchData();
  }
}
