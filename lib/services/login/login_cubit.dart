import 'dart:convert';

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:graduation_dr_brain/Network/dio_helper.dart';
import 'package:graduation_dr_brain/helpers/constants.dart';
import 'package:graduation_dr_brain/pages/patient/home.dart';
import 'package:graduation_dr_brain/services/doctor/doctor_layout.dart';
import 'package:graduation_dr_brain/services/patient/patient_layout.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_dr_brain/services/login/login_states.dart';
import 'package:image_picker/image_picker.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  void userLogin(
      {required String email,
      required String password,
      context,
      required String endPoint}) async {
    emit(LoginLoadingState());
    //sending data to login api
    //if(Profiles[index].name=="Patient")
    final response = await http.post(
      Uri.parse('https://dr-brains.com/api/$endPoint'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );
    if (response.statusCode == 200 && endPoint == LOGIN_PATIENT_ENDPOINT) {
      print('Congratulations,you have signed in successfully');
      emit(LoginSuccessState());

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => PatientLayout()));
      token = jsonDecode(response.body)['token'];
      print('Token : ${jsonDecode(response.body)['token']}');
      //showToast(text:'Logged in Successfully' , state: ToastStates.SUCCESS);
    } else if (response.statusCode == 200 &&
        endPoint == LOGIN_DOCTOR_ENDPOINT) {
      print('Congratulations,you have signed in successfully');
      emit(LoginSuccessState());
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) => DoctorLayout()));
      token = jsonDecode(response.body)['token'];

      print('Token : ${jsonDecode(response.body)['token']}');
      //showToast(text:'Logged in Successfully' , state: ToastStates.SUCCESS);
    } else {
      emit(LoginErrorState());
      //showToast(text:jsonDecode(response.body)['error'] , state: ToastStates.ERROR);
      throw Exception('Failed to login');
    }
  }



//changing password visibility
  bool isPassword = true;
  IconData? suffixIcon = Icons.visibility_off_outlined;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffixIcon =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(IsPasswordState());
  }



  Future<dynamic> register({
     required String password,
    required String email,
    required  String name,
    required  context,
    required  String endPoint,
    required  String userName,
    required  String ssn,
    required  String gender,
    required  String location,
    required  String birthdate,
    required  String phone,
    required XFile userImage, }) async {
    FormData data = new FormData();
    data.fields.add(MapEntry('user_name', userName));
    data.fields.add(MapEntry('email', email));
    data.fields.add(MapEntry('password', password));
    data.fields.add(MapEntry('password_confirmation', password));
    data.fields.add(MapEntry('full_name', name));
    data.fields.add(MapEntry('phone', phone));
    data.fields.add(MapEntry('ssn', ssn));
    data.fields.add(MapEntry('birth_date', birthdate));
    data.fields.add(MapEntry('gender', gender));
    data.fields.add(MapEntry('location', location));
    data.files.add(MapEntry(
      'avatar',
      await MultipartFile.fromFile(
        userImage.path,
        filename: userImage.path.split("/").last.toString(),
      ),
    ));
    print(data.fields);
    print(data.files);
    if(endPoint == SIGNUP_PATIENT_ENDPOINT){
      DioHelper.postData(url: SIGNUP_PATIENT_ENDPOINT, data: data).then((value){
        if (value.statusCode == 200){
          token =  value.data['token'];
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) => PatientLayout()));
        }else if (value.statusCode == 422){
          //show message Error
          print("The given data was invalid.");
        }else{
          print("error mn3rfaosh .");
        }
      });
    }
    else if(endPoint == SIGNUP_DOCTOR_ENDPOINT){
      DioHelper.postData(url: SIGNUP_DOCTOR_ENDPOINT, data: data).then((value){
        if (value.statusCode == 200){
          token =  value.data['token'];
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) => PatientLayout()));
        }else if (value.statusCode == 422){
          //show message Error
          print("The given data was invalid.");
        }else{
          print("error mn3rfaosh .");
        }
      });
    }


  }
}

/*
*
* dio Header
* DioHelper.dio.options.headers.addAll({"Authorization": "Bearer ${SharedText.userToken}"});‏
*
* */
