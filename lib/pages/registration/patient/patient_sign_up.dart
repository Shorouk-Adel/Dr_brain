import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_dr_brain/services/login/login_cubit.dart';
import 'package:graduation_dr_brain/services/login/login_states.dart';
import 'package:graduation_dr_brain/widgets/login_components.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';



class CompletePatient extends StatelessWidget {
  String pName;
  String pEmail;
  String pPassword;
  String pSignUpEndPoint;

  CompletePatient(this.pName,this.pEmail,this.pPassword,this.pSignUpEndPoint,{Key? key}) : super(key: key);
  var ssnController = TextEditingController();
  var userNameController = TextEditingController();
  var phoneController = TextEditingController();
  var locationController = TextEditingController();
  var birthdateController = TextEditingController();

  List list=["Male", "Female"];
  String? valueChoosed;
  var formKey = GlobalKey<FormState>();
  XFile? myImage ;
  final ImagePicker _picker = ImagePicker();

  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          /* if (state is SignUpSuccessState) {
            print('el mafrod yshtghal');
            CacheHelper.saveData(
              key: 'token',
              value: token,
            ).then((value) {
              //  print(token);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => PatientLayout(),
                ),
                    (Route<dynamic> route) => false,
              );
            });
          }*/
        },
        builder: (context, state) {
          LoginCubit myCubit = LoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              leading: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(Icons.arrow_back, color: Colors.deepPurple)),
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
                      child: SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Complete your profile data",
                              style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Text(
                                "This data is kept and only the doctor sees this data,this data will help in the diagnosis process",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black38,
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),  const Padding(
                      padding: EdgeInsets.fromLTRB(20, 30, 0, 0),
                      child: Text(
                        "Your Photo",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 0, 20),
                      child: InkWell(
                        onTap: ()  async {
                          // Pick an image
                          myImage = await _picker.pickImage(source: ImageSource.gallery);
                        },
                        child: SizedBox(
                          width: 150,
                          height: 100,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              // if you need this
                              side: BorderSide(
                                color: Colors.grey.withOpacity(0.2),
                                width: 1,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.upload,
                                  color: Colors.deepPurple,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Browse to upload",
                                  style: TextStyle(color: Colors.deepPurple),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 300,
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              CustomTextForm(
                                context,
                                controller: userNameController,
                                keyboardType: TextInputType.emailAddress,
                                label: 'User Name',
                                onTap: () {},
                                preIcon: Icons.drive_file_rename_outline,
                                validate: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'The user name field is required';
                                  } else
                                    return null;
                                },
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              CustomTextForm(
                                context,
                                controller: ssnController,
                                keyboardType: TextInputType.emailAddress,
                                label: 'SSN',
                                onTap: () {},
                                preIcon: Icons.credit_card_outlined,
                                validate: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  else {
                                    return null;
                                  }},
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              CustomTextForm(
                                context,
                                controller: phoneController,
                                keyboardType: TextInputType.emailAddress,
                                label: 'Phone',
                                onTap: () {},
                                preIcon: Icons.sim_card_outlined,
                                validate: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  else {
                                    return null;
                                  }},
                              ),
                              SizedBox(
                                height: 15.0,
                              ),

                              Container(
                                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey, width: 1),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: DropdownButton(
                                  hint: const Text("Select Gender"),
                                  value: valueChoosed,
                                  isExpanded: true,
                                  onChanged: (newValue) {

                                    valueChoosed = newValue as String?;

                                  },
                                  items: list.map((valueItem) {
                                    return DropdownMenuItem(
                                      value: valueItem,
                                      child: Text(valueItem),
                                    );
                                  }).toList(),
                                ),
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              CustomTextForm(
                                context,
                                controller: locationController,
                                keyboardType: TextInputType.emailAddress,
                                label: 'Location',
                                onTap: () {},
                                preIcon: Icons.credit_card_outlined,
                                validate: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  else {
                                    return null;
                                  }},
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              // Container(
                              //   decoration: BoxDecoration(
                              //     border: Border.all(color: Colors.grey, width: 1),
                              //     borderRadius: BorderRadius.circular(15),
                              //   ),
                              //   child: ExpansionTile(
                              //     title: Text("BirthDay"),
                              //     leading: Icon(Icons.date_range),
                              //     children: [
                              //       SfDateRangePicker(
                              //         view: DateRangePickerView.month,
                              //         selectionMode:
                              //         DateRangePickerSelectionMode.single,
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              Container(
                                child:  CustomTextForm(
                                  context,
                                  controller: birthdateController,
                                  keyboardType: TextInputType.emailAddress,
                                  label: 'BirthDate (YYYY-MM-DD)',
                                  onTap: () {},
                                  preIcon: Icons.credit_card_outlined,
                                  validate: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    else {
                                      return null;
                                    }},
                                ),
                              ),

                              const SizedBox(
                                height: 40,
                              ),
                              CustomButton(
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    myCubit.userSignUp(
                                        name: pName,
                                        email: pEmail,
                                        password: pPassword,
                                        endPoint: pSignUpEndPoint,
                                        sSN: ssnController.text,
                                        userName: userNameController.text,
                                        //gender: valueChoosed! ,
                                        phone: phoneController.text,
                                       // birthdate: birthdateController.text,
                                        location:locationController.text ,
                                        image: myImage as XFile,
                                        context: context);
                                  }

                                  //just for testing
                                  // Navigator.push(context, MaterialPageRoute(
                                  //     builder: (BuildContext context) =>  AppLayout()));
                                },
                                text: 'SignUp',
                                isUpperCase: true,
                              ),

                              SizedBox(
                                height: 15.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}