import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:graduation_dr_brain/Model/model.dart';
import 'package:graduation_dr_brain/helpers/constants.dart';
import 'package:graduation_dr_brain/services/patient/patient_cubit.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:graduation_dr_brain/services/patient/patient_states.dart';
import 'package:graduation_dr_brain/widgets/login_components.dart';
import 'package:intl/intl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class BookAppointment extends StatelessWidget {
  var appointmentKey = GlobalKey<FormState>();
  var dateController = TextEditingController(text: DateTime.now().toString());
  var timeController = TextEditingController(
      text:
          '${TimeOfDay.now().hour.toString()}:${TimeOfDay.now().minute.toString()}');
  var descriptionController = TextEditingController();
  TimeOfDay time = TimeOfDay.now();
  DoctorModel model;

  BookAppointment(this.model);

  String apiStringDate = "yyyy-mm-dd";
  String apiStringTime = "1:00 AM";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => PatientCubit(),
      child: BlocConsumer<PatientCubit, PatientStates>(
        listener: (context, state) {},
        builder: (context, state) {
          PatientCubit myCubit = PatientCubit.get(context);
          return MaterialApp(
            home: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0.0,
                title: Text(
                  'New Appointment',
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 20,
                  ),
                ),
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios, color: Colors.deepPurple),
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Container(
                          alignment: Alignment.topCenter,
                          child: SizedBox(
                            width: 290,

                            child: Form(
                              key: appointmentKey,
                              child: Column(
                                children: [
                                  Column(
                                    children: [
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
                                        controller: dateController,

                                        decoration: InputDecoration(
                                          labelText: "Date",
                                          prefixIcon: Icon(Icons.event,
                                              color: Colors.deepPurple),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      TextFormField(
                                        cursorColor: Colors.deepPurple,
                                        onTap: () {},
                                        controller: descriptionController,
                                        decoration: InputDecoration(
                                          labelText: "Description",
                                          prefixIcon: Icon(Icons.edit,
                                              color: Colors.deepPurple),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15.0,
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


                                      const SizedBox(
                                        height: 20,
                                      ),

                                      CustomButton(
                                        function: () {
                                          if (appointmentKey.currentState!
                                              .validate()) {
                                            myCubit.bookAppointment(
                                              context : context,
                                                date: apiStringDate,
                                                patientId: patientModel.id,
                                                DoctorId: model.id.toString(),
                                                DoctorEmail: model.email,
                                                PatientEmail: patientModel.email,
                                                description: descriptionController.text,
                                                time: apiStringTime);
                                          }
                                        },
                                        text: 'Book Appointment',
                                        isUpperCase: true,
                                      ),
                                    ],

                                  ),

                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
