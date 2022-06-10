import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:graduation_dr_brain/Model/meeting.dart';
import 'package:graduation_dr_brain/Model/patient_model.dart';
import 'package:graduation_dr_brain/Network/dio_helper.dart';
import 'package:graduation_dr_brain/services/patient/patient_layout.dart';
import 'package:graduation_dr_brain/widgets/loading.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_dr_brain/helpers/constants.dart';
import 'package:graduation_dr_brain/pages/doctor/doctor_home.dart';
import 'package:graduation_dr_brain/pages/patient/appointments.dart';
import 'package:graduation_dr_brain/pages/patient/home.dart';
import 'package:graduation_dr_brain/pages/patient/patient_doctors/doctors_screen.dart';
import 'package:graduation_dr_brain/pages/patient/profile.dart';
import 'package:graduation_dr_brain/pages/profile.dart';
import 'package:graduation_dr_brain/services/patient/patient_states.dart';
import 'package:image_picker/image_picker.dart';

class PatientCubit extends Cubit<PatientStates> {
  // call Super constructor with initial State
  PatientCubit() : super(AppInitialState());

  static PatientCubit get(context) => BlocProvider.of(context);

  //Data
  bool isLoading = false;
  int total = 0;
  int currentIndex = 0;
  List<MeetingModel> appoinments = [];
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

  Future<dynamic> uploadMRI({
    required String meetingId,
    required XFile Mri,
  required context,
  }) async {
    emit(MriUploadStart());
    isLoading = true;
    FormData data = new FormData();
    data.fields.add(MapEntry('meeting_id', meetingId));
    data.files.add(MapEntry(
      'imagefile',
      await MultipartFile.fromFile(
        Mri.path,
        filename: Mri.path.split("/").last.toString(),
      ),
    ));
    DioHelper.dio.options.headers
        .addAll({"Authorization": "Bearer $token"});
    DioHelper.postData(url: "send-mri", data: data).then((value) {
      if (value.statusCode == 200) {
        emit(MriUploaded());
        isLoading = false;
        print("done");
        showSnackBar("Mri Uploaded",context,false);
      }else{
        emit(MrididntUploaded());
        isLoading = false;
        print("error");
        showSnackBar("Mri Upload Error",context,true);

      }
    });
  }

  void bookAppointment({
    required context,
    required String time,
    required String date,
    required String DoctorEmail,
    required String DoctorId,
    required String patientId,
    required String PatientEmail,
    required String description,
  }) async {
    emit(SelectingTimeAndDate());
    isLoading = true;
    final response = await http.post(
      Uri.parse('https://dr-brains.com/api/add-appointment'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, String>{
        'meeting_name': "Meeting $time",
        'meeting_date': date.toString(),
        'meeting_time': time.toString(),
        'meeting_description': description,
        'doctor_email': DoctorEmail,
        'patient_email': PatientEmail,
        'doctor_id': DoctorId,
        'patient_id': patientId,
      }),
    );
    if (response.statusCode == 201) {
      isLoading = false;
      print('Congratulations,you have booked the appointment successfully' +
          response.body);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => PatientLayout()));
      emit(TimeAndDateSelected());
    } else {
      emit(TimeAndDateSelectedError());
      isLoading = false;
      //showToast(text:jsonDecode(response.body)['error'] , state: ToastStates.ERROR);
      throw Exception('Failed to bookAppointment');
    }
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
      emit(GetPatientAppointmentsSuccess());
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
        print(appoinments[i].meetingLink);
        emit(GetPatientAppointmentsSuccess());
      }
      print(patientModel.avatarUrl);
    } else {
      emit(GetPatientAppointmentsError());
      //showToast(text:jsonDecode(response.body)['error'] , state: ToastStates.ERROR);
      throw Exception('Failed to getData');
    }
  }
}
