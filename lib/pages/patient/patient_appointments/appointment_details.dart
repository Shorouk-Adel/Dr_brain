import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_dr_brain/Model/meeting.dart';
import 'package:graduation_dr_brain/services/login/login_cubit.dart';
import 'package:graduation_dr_brain/services/login/login_states.dart';
import 'package:graduation_dr_brain/services/patient/patient_cubit.dart';
import 'package:graduation_dr_brain/services/patient/patient_states.dart';
import 'package:graduation_dr_brain/widgets/loading.dart';
import 'package:graduation_dr_brain/widgets/login_components.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class AppointmentDeteails extends StatelessWidget {
  MeetingModel appoinment;
  XFile? image;

  final _picker = ImagePicker();

  AppointmentDeteails(this.appoinment, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => PatientCubit(),
      child: BlocConsumer<PatientCubit, PatientStates>(
          listener: (context, state) {},
          builder: (context, state) {
            PatientCubit myCubit = PatientCubit.get(context);

            return MaterialApp(
              home: Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.arrow_back_ios,
                          color: Colors.deepPurple)),
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  title: Text(
                    'Appointment Details',
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 20,
                    ),
                  ),
                ),
                body: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 120,
                            height: 120,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://jooinn.com/images/specialist-doctor.jpg'),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Meeting Name"),
                              Text(
                                appoinment.meetingName.toString(),
                                maxLines: 1,
                                style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Time"),
                                      Text(
                                        appoinment.meetingDateTime.toString(),
                                        style: TextStyle(
                                          color: Colors.deepPurple,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Status"),
                                  Container(
                                    width: 100,
                                    height: 20,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      color: Colors.green,
                                    ),
                                    child: Text(
                                      "Confirmed",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () async {
                        // Pick an image

                        getImage();
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
                    SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                        child: Text("Upload MRI"),
                        onPressed: () {
                          myCubit.uploadMRI(
                              meetingId: appoinment.id.toString(), Mri: image!);
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      function: () {
                        _launchURL();
                      },
                      text: 'Open Meeting',
                      isUpperCase: true,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  void _launchURL() async {
    if (!await launch(appoinment.meetingLink.toString()))
      throw 'Could not launch ${appoinment.meetingLink.toString()}';
  }

  Future getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = pickedFile;
      print('image selected. + ' + pickedFile.path);
    } else {
      print('No image selected.');
    }
  }
}
