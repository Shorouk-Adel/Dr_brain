import 'dart:convert';
import 'package:graduation_dr_brain/helpers/constants.dart';
import 'package:graduation_dr_brain/services/doctor/doctor_layout.dart';
import 'package:graduation_dr_brain/services/patient/patient_layout.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_dr_brain/services/login/login_states.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);


  void userLogin(
      {required String email, required String password, context, required String endPoint}) async {
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

      Navigator.push(context, MaterialPageRoute(
          builder: (BuildContext context) => PatientLayout()));
      token = jsonDecode(response.body)['token'];
      print('Token : ${jsonDecode(response.body)['token']}');
      //showToast(text:'Logged in Successfully' , state: ToastStates.SUCCESS);
    }
    else if (response.statusCode == 200 &&endPoint == LOGIN_DOCTOR_ENDPOINT) {
      print('Congratulations,you have signed in successfully');
      emit(LoginSuccessState());
      Navigator.push(context, MaterialPageRoute(
          builder: (BuildContext context) => DoctorLayout()));
      token = jsonDecode(response.body)['token'];

      print('Token : ${jsonDecode(response.body)['token']}');
      //showToast(text:'Logged in Successfully' , state: ToastStates.SUCCESS);
    }

    else {
      emit(LoginErrorState());
      //showToast(text:jsonDecode(response.body)['error'] , state: ToastStates.ERROR);
      throw Exception('Failed to login');
    }
  }



  void userSignUp({required String email,
    required String password,
    required String name,
    required String endPoint,
    context}) async {
    emit(SignUpLoadingState());
    //sending data to register api
    final response = await http.post(
      Uri.parse('https://dr-brains.com/api/$endPoint'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'email': email,
        'password': password,
      }),
    );
    if (response.statusCode == 200 && endPoint == SIGNUP_PATIENT_ENDPOINT) {
      print('Congratulations,you have signed up successfully');
      emit(SignUpSuccessState());

      Navigator.push(context, MaterialPageRoute(
          builder: (BuildContext context) => PatientLayout()));
      token = jsonDecode(response.body)['token'];
      print('Token : ${jsonDecode(response.body)['token']}');
      //showToast(text:'Logged in Successfully' , state: ToastStates.SUCCESS);
    }
    else if (response.statusCode == 200 &&endPoint == SIGNUP_DOCTOR_ENDPOINT) {
      print('Congratulations,you have signed UP successfully');
      emit(SignUpSuccessState());
      Navigator.push(context, MaterialPageRoute(
          builder: (BuildContext context) => DoctorLayout()));
      token = jsonDecode(response.body)['token'];

      print('Token : ${jsonDecode(response.body)['token']}');
      //showToast(text:'Logged in Successfully' , state: ToastStates.SUCCESS);
    }

    else {
      emit(SignUpErrorState());
      //showToast(text:jsonDecode(response.body)['error'] , state: ToastStates.ERROR);
      throw Exception('Failed to SignUp');
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
}
      //////////////////////////////////////////


/*
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      LoginModel = LoginModel.fromjson(value.data);

      // print(LoginModel!.message);
      // print(LoginModel!.status);
      emit(LoginSuccessState(LoginModel!));
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
    });
  }


  bool isPassword = true;
  IconData? suffixIcon = Icons.visibility;
  void Passon(){
    isPassword =! isPassword;
    suffixIcon = isPassword ?Icons.visibility:Icons.visibility_off;
    emit(IsPasswordState());
  }

}*/

