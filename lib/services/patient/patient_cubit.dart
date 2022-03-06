import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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



  List<Widget>MainScreens=[
    PatientHome(),
    PatientAppointment(),
    DoctorsScreen(),
    PatientProfile(),
  ];


  List<BottomNavigationBarItem> bottomItems =
  [
    BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home'),

    BottomNavigationBarItem(
        icon: Icon(Icons.alarm),
        label: 'Appointments'),

    BottomNavigationBarItem(
        icon: Icon(Icons.message_outlined),
        label: 'Messages'),

    BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'Profile'),
  ];

  //Actions
  void changeIndex(int newIndex){
    currentIndex = newIndex;
    if(currentIndex==0){
      emit(BottomNavBarItemMovedToHome());
    }
    else if(currentIndex==1){
      emit(BottomNavBarItemMovedToAppointments());
    }
    else if(currentIndex==2){
      emit(BottomNavBarItemMovedToMessages());
    }
    else{
      emit(BottomNavBarItemMovedToProfile());
    }

  }
  TextDirection appDirection = TextDirection.ltr;





}