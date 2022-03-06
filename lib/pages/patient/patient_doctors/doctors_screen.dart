import 'dart:convert';
import 'package:graduation_dr_brain/helpers/constants.dart';
import 'package:graduation_dr_brain/pages/patient/patient_doctors/model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'doctor_details.dart';

class DoctorsScreen extends StatefulWidget {
  const DoctorsScreen({Key? key}) : super(key: key);

  @override
  _DoctorsScreenState createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends State<DoctorsScreen> {
  List? listOfMaps;
  List listOfDrs = [];

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
          actions: [
            IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.filter_list_outlined,
                    color: Colors.deepPurple)),
          ],
        ),
        body: GridView.builder(
          padding: const EdgeInsets.all(16.0),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 300,
              childAspectRatio: 1,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10),
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
              child: Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 15.0 / 8.0,
                      child: CircleAvatar(
                        radius: 45,
                        backgroundImage: NetworkImage(
                          // listOfDrs[index].avatar.toString(),
                          "https://health.gov/sites/default/files/styles/topic_card_image/public/2020-01/regular-checkups_banner.jpg?itok=2HIjcA3h",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                      child: Container(
                        alignment: Alignment.center,
                        child: Column(
                          children: <Widget>[
                            Text(listOfDrs[index].full_name ,style: TextStyle(fontSize: 15 , fontWeight: FontWeight.bold ,  ),),
                            const SizedBox(height: 8.0),
                            Text("Neurosurgery"),
                          ],
                        ),
                      ),
                    ),
                  ],
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
        for (int i = 0; i < listOfMaps!.length; i++) {
          listOfDrs.add(DoctorModel(
              listOfMaps![i]['id'],
              listOfMaps![i]['full_name'],
              listOfMaps![i]['email'],
              listOfMaps![i]['phone'] ,
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
