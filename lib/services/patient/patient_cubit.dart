import 'dart:convert';
import 'package:graduation_dr_brain/Model/patient_model.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_dr_brain/helpers/constants.dart';
import 'package:graduation_dr_brain/pages/doctor/appointment.dart';
import 'package:graduation_dr_brain/pages/doctor/doctor_home.dart';
import 'package:graduation_dr_brain/pages/patient/appointments.dart';
import 'package:graduation_dr_brain/pages/patient/home.dart';
import 'package:graduation_dr_brain/pages/patient/patient_doctors/doctors_screen.dart';
import 'package:graduation_dr_brain/pages/patient/profile.dart';
import 'package:graduation_dr_brain/pages/profile.dart';
import 'package:graduation_dr_brain/services/patient/patient_states.dart';

class PatientCubit extends Cubit<PatientStates> {
  // call Super constructor with initial State
  PatientCubit() : super(AppInitialState());

  static PatientCubit get(context) => BlocProvider.of(context);

  //Data

  int total = 0;
  int currentIndex = 0;

  List<Widget> MainScreens = [
    PatientHome(),
    PatientAppointment(),
    DoctorsScreen(),
    PatientProfile(),
  ];

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.alarm), label: 'Appointments'),
    BottomNavigationBarItem(
        icon: Icon(Icons.message_outlined), label: 'Doctors'),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
  ];

  //Actions
  void changeIndex(int newIndex) {
    currentIndex = newIndex;
    if (currentIndex == 0) {
      emit(BottomNavBarItemMovedToHome());
    } else if (currentIndex == 1) {
      emit(BottomNavBarItemMovedToAppointments());
    } else if (currentIndex == 2) {
      emit(BottomNavBarItemMovedToMessages());
    } else {
      emit(BottomNavBarItemMovedToProfile());
    }
  }

  TextDirection appDirection = TextDirection.ltr;

  void bookAppointment({
    required String time,
    required String date,
    required String DoctorEmail,
    required String DoctorId,
    required String patientId,
    required String PatientEmail,
    required String description,
  }) async {
    emit(SelectingTimeAndDate());
    //testing
    // print(
    //     time + " " +date+" "+DoctorEmail+" "+DoctorId+" "+patientId+" "+PatientEmail+" "+description + "token is" + token
    //
    // );
    //sending data to appointment api
    final response = await http.post(
      Uri.parse('https://dr-brains.com/api/add-appointment'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, String>{
        'meeting_name': "meeting$time$DoctorId",
        'meeting_date': date.toString(),
        'meeting_time': time.toString(),
        'meeting_description': description,
        'doctor_email': DoctorEmail,
        'patient_email': PatientEmail,
        'Doctor_id': DoctorId,
        'patient_id': patientId,
      }),
    );
    if (response.statusCode == 201) {
      print('Congratulations,you have booked the appointment successfully' +
          response.body);
      emit(TimeAndDateSelected());
    } else {
      emit(TimeAndDateSelectedError());
      //showToast(text:jsonDecode(response.body)['error'] , state: ToastStates.ERROR);
      throw Exception('Failed to bookAppointment');
    }
  }


}
