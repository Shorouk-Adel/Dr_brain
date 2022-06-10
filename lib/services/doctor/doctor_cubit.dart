import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_dr_brain/pages/doctor/Chat/dr_chat.dart';
import 'package:graduation_dr_brain/pages/doctor/d_profile.dart';
import 'package:graduation_dr_brain/pages/doctor/doctor_home.dart';
import 'package:graduation_dr_brain/pages/doctor/dr_appointment.dart';
import 'package:graduation_dr_brain/pages/patient/patient_doctors/doctors_screen.dart';
import 'package:graduation_dr_brain/pages/profile.dart';
import 'package:graduation_dr_brain/widgets/custom_radio.dart';
import 'doctor_states.dart';

class DoctorCubit extends Cubit<DoctorStates> {
  // call Super constructor with initial State
  DoctorCubit() : super(AppInitialState());


  static DoctorCubit get(context) => BlocProvider.of(context);
  //Data

  int total = 0;
  int currentIndex = 0;



  List<Widget>MainScreens=[
    DoctorHome(),
    DoctorAppointment(),
    DrChat(),
    DoctorProfile(),
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