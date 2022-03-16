

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:graduation_dr_brain/Model/model.dart';
import 'package:graduation_dr_brain/helpers/constants.dart';
import 'package:graduation_dr_brain/services/patient/patient_cubit.dart';
import 'package:graduation_dr_brain/widgets/login_components.dart';



Widget book(context, DoctorModel model ){

  var appointmentKey = GlobalKey<FormState>();
  var dateController = TextEditingController(text: DateTime.now().toString());
  var timeController = TextEditingController(
      text:
      '${TimeOfDay.now().hour.toString()}:${TimeOfDay.now().minute.toString()}');
  var descriptionController = TextEditingController();
  TimeOfDay time = TimeOfDay.now();
  PatientCubit myCubit = PatientCubit.get(context);

  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Container(
              color: Colors.white,
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: 290,
                child: Column(
                  children: [
                    Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Description',
                            hintText: 'Type your password',
                            prefixIcon: Icon(Icons.lock),
                            border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(25.0)),
                          ),
                        ),

                      ],

                    ),

                  ],
                ),
              ),
            ),
          )
        ],
      ),
    ),
  );
}
Future<void> show(context)async {
  return showDialog(context: context, builder: (BuildContext context){
    String apiStringDate = "yyyy-mm-dd";
    String apiStringTime = "1:00 AM";
    return AlertDialog(
      content: MaterialApp(
        home: Scaffold(
          body: SizedBox(

            child: Column(
                children: [Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: SingleChildScrollView(
                      child: SizedBox(
                        width: 300,
                        child: Column(
                          children: [
                            TextFormField(
                              maxLines: 6,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'Description',
                                focusColor: Colors.black,

                              ),
                            ),
                            TextFormField(
                              onTap: () {
                                DatePicker.showDatePicker(context,
                                    showTitleActions: true,
                                    minTime: DateTime(2022, 3, 13),
                                    maxTime: DateTime(2022, 12, 31),
                                    onChanged: (date) {
                                      apiStringDate = date.year.toString() +
                                          "-" +
                                          date.month.toString() +
                                          "-" +
                                          date.day.toString();
                                      print('change ' + apiStringDate);
                                    }, onConfirm: (date) {
                                      apiStringDate = date.year.toString() +
                                          "-" +
                                          date.month.toString() +
                                          "-" +
                                          date.day.toString();
                                      print('confirm ' +
                                          date.year.toString() +
                                          "-" +
                                          date.month.toString() +
                                          "-" +
                                          date.day.toString());
                                    },
                                    currentTime: DateTime.now(),
                                    locale: LocaleType.en);
                              },

                              decoration: InputDecoration(
                                labelText: "Date",
                                prefixIcon: Icon(Icons.event,
                                    color: Colors.deepPurple),
                              ),
                            ),
                            TextFormField(
                              cursorColor: Colors.deepPurple,
                              onTap: () {
                                DatePicker.showTime12hPicker(context,
                                  showTitleActions: true,
                                  onChanged: (date) {
                                    final dt = DateTime(
                                        date.year,
                                        date.month,
                                        date.day,
                                        date.hour,
                                        date.minute);
                                    var formatTime =
                                    DateFormat.jm();
                                    apiStringTime = formatTime.format(date).toString();
                                    print('change $date in time zone ' +apiStringTime);

                                  }, onConfirm: (date) {
                                    final dt = DateTime(
                                        date.year,
                                        date.month,
                                        date.day,
                                        date.hour,
                                        date.minute);
                                    var formatTime =
                                    DateFormat.jm();
                                    apiStringTime = formatTime.format(date).toString();//"6:00 AM"
                                    print('confirm $apiStringTime');
                                    print(formatTime.format(date));
                                  }, );
                              },
                              decoration: InputDecoration(
                                labelText: "Time",
                                prefixIcon: Icon(Icons.access_time,
                                    color: Colors.deepPurple),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: SizedBox(
                          width: 300,
                          height: 60,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                            ),
                            onPressed: () {

                            },
                            child: Text('Book Appointment'),
                          )),
                    ),
                  ),
                ]

            ),
          ),
        ),
      ),
    );
  });
}