import 'package:flutter/material.dart';
import 'package:graduation_dr_brain/helpers/functions.dart';
import 'package:graduation_dr_brain/pages/registration/patient/patient_sign_up.dart';
import 'package:graduation_dr_brain/widgets/login_components.dart';
/*

class BookAppointment extends StatefulWidget {
  const BookAppointment({Key? key}) : super(key: key);

  @override
  _BookAppointmentState createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Log In",
                        style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "If you are already a member you can login with your email address and password.",
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
                        CustomTextForm(context,
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          label: 'Email address',
                          onTap: (){},
                          preIcon: Icons.email_outlined,
                          validate: (value){
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            else if (!value.contains('@')) {
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
                              }

                              else /*if (value.toString().length!=8) {
                          return 'your password must be at least 8 characters';
                        }*/
                                return null;
                            },
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: isPassword,
                            decoration: InputDecoration(

                              labelText: 'Password',
                              hintText: 'Type your password',
                              prefixIcon: Icon(Icons.lock),
                              suffix: isPassword ? IconButton(
                                onPressed: () {
                                  setState(() {
                                    changePasswordVisibility();
                                  });

                                }, icon: Icon(suffixIcon),)
                                  : IconButton(
                                onPressed: () {
                                  setState(() {
                                    changePasswordVisibility();
                                  });
                                },
                                icon: Icon(Icons.visibility_outlined,),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0)
                              ),
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
                                  onPressed: () {

                                  },
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
                              userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  context: context);
                            }

                            //just for testing
                            // Navigator.push(context, MaterialPageRoute(
                            //     builder: (BuildContext context) =>  AppLayout()));
                          },
                          text: 'login',
                          isUpperCase: true,
                        ),

                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account?'),
                            TextButton(onPressed: (){
                              Navigator.push(context,
                                MaterialPageRoute(builder: (BuildContext context) => SignUp(),
                                ),
                              );
                            }, child: Text('SignUp')),
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
  }
}
*/