import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:graduation_dr_brain/helpers/constants.dart';
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

  void userSignUp(
      {required String email,
      required String password,
      required String name,
      required String endPoint,
      required String userName,
      required String sSN,
     // required String gender,
      required String location,
     // required String birthdate,
      required String phone,
      required XFile image,

      //required DatePicker birthday,
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
        'full_name': userName,
        'phone': phone,
        'ssn': sSN,
        //'birth_date': "2000-11-27",
       // 'gender': "male",
        'location': location,
        'avatar': image.path
      }),
    );
    if (response.statusCode == 200 && endPoint == SIGNUP_PATIENT_ENDPOINT) {
      print('Congratulations,you have signed up successfully');
      emit(SignUpSuccessState());

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => PatientLayout()));
      token = jsonDecode(response.body)['token'];
      print('Token : ${jsonDecode(response.body)['token']}');
      //showToast(text:'Logged in Successfully' , state: ToastStates.SUCCESS);
    } else if (response.statusCode == 200 &&
        endPoint == SIGNUP_DOCTOR_ENDPOINT) {
      print('Congratulations,you have signed UP successfully');
      emit(SignUpSuccessState());
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) => DoctorLayout()));
      token = jsonDecode(response.body)['token'];

      print('Token : ${jsonDecode(response.body)['token']}');
      //showToast(text:'Logged in Successfully' , state: ToastStates.SUCCESS);
    } else {
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
  uploadImage() async{
    var request=http.MultipartRequest("POST",
        Uri.parse('https://dr-brains.com/api/patient_registeration'));
    request.fields['name']="dummyImage";
    request.fields['email']="dummyImage@gmail.com";
    request.fields['password']="dummyImage";
    request.fields['password_confirmation']="dummyImage";
    request.fields['full_name']="dummyImage";
    request.fields['phone']="01002564741";
    request.fields['ssn']="12345678912349";
    request.fields['birth_date']="2000-11-11";
    request.fields['gender']="male";
    request.fields['location']="dummyImage";
    var picture= http.MultipartFile.fromBytes('avatar', (await rootBundle.load('assets/patient.png')).buffer.asUint8List(),
        filename: 'patient.png'
    );
    request.files.add(picture);
    var response=await request.send().then((value) {
      if (value.statusCode == 200) print("Uploaded!");
    });
    var responseData= await response.stream.toBytes();
    var result= String.fromCharCodes(responseData);
    print(result);
    
  }
}
