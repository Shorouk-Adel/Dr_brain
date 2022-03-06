import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_dr_brain/services/login/login_cubit.dart';
import 'package:graduation_dr_brain/services/login/login_states.dart';
import 'package:graduation_dr_brain/widgets/login_components.dart';

class DoctorSignUp extends StatelessWidget {
  String signUpEndpoint;

  DoctorSignUp(this.signUpEndpoint, {Key? key}) : super(key: key);

  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

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
                              "Sign Up",
                              style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Sign Up now",
                              style: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
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
                                controller: nameController,
                                keyboardType: TextInputType.emailAddress,
                                label: 'Name',
                                onTap: () {},
                                preIcon: Icons.drive_file_rename_outline,
                                validate: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'The name field is required';
                                  } else
                                    return null;
                                },
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              CustomTextForm(
                                context,
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                label: 'Email address',
                                onTap: () {},
                                preIcon: Icons.email_outlined,
                                validate: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  } else if (!value.contains('@')) {
                                    return 'your email address must contain @ sign ';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              //password form field
                              SizedBox(
                                height: 60,
                                width: 500,
                                child: TextFormField(
                                  controller: passwordController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    } else
                                      /*if (value.toString().length!=8) {
                          return 'your password must be at least 8 characters';
                        }*/
                                      return null;
                                  },
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: myCubit.isPassword,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    hintText: 'Type your password',
                                    prefixIcon: Icon(Icons.lock),
                                    suffix: myCubit.isPassword
                                        ? IconButton(
                                      onPressed: () {
                                        myCubit
                                            .changePasswordVisibility();
                                      },
                                      icon: Icon(myCubit.suffixIcon),
                                    )
                                        : IconButton(
                                      onPressed: () {
                                        myCubit
                                            .changePasswordVisibility();
                                      },
                                      icon: Icon(
                                        Icons.visibility_outlined,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(25.0)),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Switch(
                                    value: false,
                                    onChanged: (bool value) {},
                                  ),
                                  Text("Remember Me"),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      TextButton(
                                        onPressed: () {},
                                        child: Text("Forget Password ?"),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              CustomButton(
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    myCubit.userSignUp(
                                      name: nameController.text,
                                        email: emailController.text,
                                        password: passwordController.text,
                                        endPoint: signUpEndpoint,
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Don\'t have an account?'),
                                  TextButton(
                                      onPressed: () {
                                        /* Navigator.push(context,
                                MaterialPageRoute(builder: (BuildContext context) => SignUp(),
                                ),
                              );*/
                                      },
                                      child: Text('SignUp')),
                                ],
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
