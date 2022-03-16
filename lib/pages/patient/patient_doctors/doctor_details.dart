import 'package:flutter/material.dart';
import 'package:graduation_dr_brain/pages/patient/patient_appointments/book.dart';
import 'package:graduation_dr_brain/pages/patient/patient_appointments/book_appointment.dart';
import 'package:graduation_dr_brain/Model/model.dart';
import 'package:graduation_dr_brain/pages/patient/patient_appointments/book_screen.dart';
import 'package:graduation_dr_brain/widgets/custom_card.dart';
import 'package:graduation_dr_brain/widgets/loading.dart';
import 'package:graduation_dr_brain/widgets/login_components.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class DoctorDetails extends StatefulWidget {
  final DoctorModel model;

  const DoctorDetails(this.model, {Key? key}) : super(key: key);

  @override
  _DoctorDetailsState createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  @override
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 25.0 / 8.0,
              child: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                  widget.model.avatar.toString(),
                ),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              "Dr.${widget.model.full_name.toString()}",
              maxLines: 2,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              "Neurosurgery",
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 5,
            ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                child: Row(
                  children: [
                    SizedBox(width: 5.0),
                    CustomCard(
                        mark: Colors.lightBlue,
                        icon: Icons.supervisor_account,
                        number: "1000+",
                        text: "Patient"),
                    SizedBox(width: 5.0),
                    CustomCard(
                        mark: Colors.redAccent,
                        icon: Icons.emoji_events_outlined,
                        number: "10 Yrs",
                        text: "Experience"),
                    CustomCard(
                        mark: Colors.deepOrangeAccent,
                        icon: Icons.star_border_outlined,
                        number: "4.5",
                        text: "Ratings"),
                  ],
                ),
              ),
            ),
            // const SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "About Doctor",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Professor of Dermatology,Venereology &cosmetics and laser, Profesor of Cosmetics &LASER , Professor in Zagazig University",
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    Divider(),
                    Text(
                      "Location",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.model.location.toString(),
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54),
                      ),
                    ),
                    Divider(),
                    Text(
                      "Communication",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Card(
              elevation: 0,
              child: ListTile(
                leading: Stack(
                  children: [
                    //  Icon(Icons.videocam_outlined),
                    Container(
                      alignment: Alignment.center,
                      height: 75,
                      width: 50,
                      child: Icon(Icons.message_outlined),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.red.withOpacity(0.4)),
                    ),
                  ],
                ),
                title: Text('Messaging'),
                subtitle: Text('Chat with your doctor '),
                onTap: () {},
              ),
            ),
            Divider(),
            Card(
              elevation: 0,
              child: ListTile(
                //Icon(Icons.videocam_outlined)
                leading: Stack(
                  children: [
                    //  Icon(Icons.videocam_outlined),
                    Container(
                      alignment: Alignment.center,
                      height: 75,
                      width: 50,
                      child: Icon(Icons.videocam_outlined),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color(0xff7ACEFA).withOpacity(0.4)),
                    ),
                  ],
                ),
                title: Text('Video Call'),
                subtitle: Text('See your doctor live'),
                onTap: () {},
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            CustomButton(
                function: () {
                  // show(context);
                  // showCustomModalBottomSheet(
                  //
                  //   expand: true,
                  //     context: context,
                  //     builder: (context) => Container(),
                  //     containerWidget: (BuildContext context,Animation<double>
                  //     animation,Widget child){
                  //       return book(context , widget.model);
                  //     });

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              BookAppointment(widget.model)));
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (BuildContext context) =>
                  //             BookScreen()));
                },
                text: 'Book Appointment',
                width: 350,
                radius: 30),
          ],
        ),
      ),
    );
  }
}
