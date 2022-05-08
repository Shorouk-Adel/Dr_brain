
import 'package:graduation_dr_brain/Model/doctor.dart';
import 'package:graduation_dr_brain/Model/patient_model.dart';

String token='';
String LOGIN_PATIENT_ENDPOINT ="patient_login";
String SIGNUP_PATIENT_ENDPOINT ="patient_registeration";

String LOGIN_DOCTOR_ENDPOINT ="doctor_login";
String SIGNUP_DOCTOR_ENDPOINT ="doctor_registeration";

PatientModel patientModel =  PatientModel("id", "full_name", "email", "phone", "location", "avatarUrl");
DoctorModel doctorModel =  DoctorModel("id", "full_name", "email", "avatarUrl");