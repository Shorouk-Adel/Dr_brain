import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_dr_brain/services/patient/patient_cubit.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:graduation_dr_brain/services/patient/patient_states.dart';
import 'package:graduation_dr_brain/widgets/login_components.dart';
import 'package:intl/intl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class BookAppointment extends StatelessWidget {

  var appointmentKey = GlobalKey<FormState>();
  var dateController= TextEditingController(text: DateTime.now().toString());
  var timeController= TextEditingController(text: '${TimeOfDay.now().hour.toString()}:${TimeOfDay.now().minute.toString()}');
  var descriptionController= TextEditingController();
  TimeOfDay time=TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => PatientCubit(),
        child: BlocConsumer<PatientCubit, PatientStates>(
        listener: (context, state) {

    },
    builder: (context, state) {
    PatientCubit myCubit = PatientCubit.get(context);
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            title: Text('New Appointment',
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Container(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 290,
                      child: Form(
                        key: appointmentKey,
                        child: Column(
                          children: [
                            TextFormField(
                              onTap:(){
                                showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2100));
                              },
                            controller: dateController,
                            decoration: InputDecoration(
                                labelText: "Date",
                                prefixIcon: Icon(Icons.event,color: Colors.deepPurple),

                            ),),
                            SizedBox(
                              height: 15.0,
                            ),
                            //password form field
                            TextFormField(
                              cursorColor: Colors.deepPurple,
                              onTap:(){
                                showTimePicker(
                                    context: context,
                                    initialTime:time);
                                print(timeController.text);

                              },
                              controller: timeController,
                              decoration: InputDecoration(
                                labelText: "Time",
                                prefixIcon: Icon(Icons.access_time,color: Colors.deepPurple),

                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            //password form field
                            TextFormField(
                              cursorColor: Colors.deepPurple,
                              maxLines: 6,
                              onTap:(){},
                              controller: descriptionController,
                              decoration: InputDecoration(
                                labelText: "Description",
                                prefixIcon: Icon(Icons.edit,color: Colors.deepPurple),

                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),

                          /*  DateTimePicker(
                              type: DateTimePickerType.time,
                              //timePickerEntryModeInput: true,
                              initialValue: '',
                              //controller: timeController, //_initialValue,
                              icon: Icon(Icons.access_time),
                              timeLabelText: "Time",
                              use24HourFormat: false,
                            ),
                            const SizedBox(
                              height: 40,
                            ),*/
                            CustomButton(
                              function: () {
                                if (appointmentKey.currentState!.validate()) {
                                  myCubit.bookAppointment(
                                     date: dateController.text,
                                  description: descriptionController.text,
                                  time: timeController.text);
                                }
                             },
                              text: 'Book Appointment',
                              isUpperCase: true,
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
