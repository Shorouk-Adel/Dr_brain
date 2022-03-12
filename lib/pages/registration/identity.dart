import 'package:flutter/material.dart';
import 'package:graduation_dr_brain/helpers/constants.dart';
import 'package:graduation_dr_brain/pages/registration/doctor/doctor_login.dart';
import 'package:graduation_dr_brain/pages/registration/patient/patient_login.dart';
import 'package:graduation_dr_brain/widgets/custom_radio.dart';


class Identity extends StatefulWidget {
  const Identity({Key? key}) : super(key: key);

  @override
  _IdentityState createState() => _IdentityState();
}

class _IdentityState extends State<Identity> {
  List<Profile> Profiles = [];


  @override
  void initState() {
    super.initState();
    Profiles.add(new Profile("Patient", Icons.person, false));
    Profiles.add(new Profile("Doctor", Icons.person, false));

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            // leading: IconButton(
            //     onPressed: () => Navigator.of(context).pop(),
            //     icon: Icon(Icons.arrow_back, color: Colors.black)),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        "Select Registeration Profile",
                        style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Choose who you are ",
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
                height: 33,
              ),
              ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: Profiles.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      splashColor: Color(0xff1d162f),
                      onTap: () {
                        setState(() {
                          Profiles.forEach(
                              (profile) => profile.isSelected = false);
                          Profiles[index].isSelected = true;
                          if(Profiles[index].name=="Patient"){
                            Navigator.push(context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => PatientLogin(LOGIN_PATIENT_ENDPOINT),
                              ),
                            );
                          }
                          else {
                            Navigator.push(context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => DoctorLogin(LOGIN_DOCTOR_ENDPOINT),
                              ),
                            );
                          }
                        });
                      },
                      child: SizedBox(
                          height: 180,child: CustomRadio(Profiles[index])),
                    );
                  }),

            ],
          )),
    );
  }
}
