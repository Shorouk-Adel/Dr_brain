import 'package:flutter/material.dart';
import 'package:graduation_dr_brain/Model/doctor.dart';
import 'package:graduation_dr_brain/Model/patient_model.dart';
import 'package:graduation_dr_brain/helpers/constants.dart';
class DoctorProfile extends StatelessWidget {

  DoctorProfile();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: const Text('Profile',
            style: TextStyle(
              color: Colors.deepPurple,
              fontSize: 20,
            )
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                 CircleAvatar(
                  radius: 45,

                  backgroundImage: NetworkImage(doctorModel.avatarUrl),
                ),
                SizedBox(
                  width: 15.0,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    Text(doctorModel.full_name,
                      style: TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(doctorModel.email,
                      style: TextStyle(
                        fontSize: 15.0,
                          fontWeight: FontWeight.w400
                      ),
                    ),


                  ],
                ),
              ],
            ),
            Divider(),
            SizedBox(
              height: 10,
            ),
            const Text("SETTING"
              , style: TextStyle(
                  fontSize: 20, color: Colors.deepPurple,
                  fontWeight: FontWeight.w500
              ),),
            SizedBox(
              height: 10,
            ),
            ListTile(
              onTap: (){},
              leading:Icon(Icons.person),
              title: Text("Account Information",
                style: TextStyle(
                  fontSize: 20.0,
                    fontWeight: FontWeight.w400
                ),),
              //trailing: Icon(Icons.person),

            ),
            Divider(),
            Divider(),
            ListTile(
              onTap: (){},
              leading:Icon(Icons.lock) ,
             title: Text("Password",
                style: TextStyle(
                  fontSize: 20.0,
                    fontWeight: FontWeight.w400
                ),),
              //trailing: Icon(Icons.lock),
            ),
            Divider(),
            SizedBox(
              height: 10,
            ),
            Text("APP"
              , style: TextStyle(
                  fontSize: 20, color: Colors.deepPurple,
                  fontWeight: FontWeight.bold
              ),),
            ListTile(
              onTap: (){},
              leading:Icon(Icons.phone_callback),
              title: Text("Help Center",
                style: TextStyle(
                  fontSize: 20.0,
                    fontWeight: FontWeight.w400
                ),),
              //trailing: Icon(Icons.phone_callback),
            ),
            Divider(),
            ListTile(
              onTap: (){},
              leading:Icon(Icons.info_outline_rounded) ,
              title: Text("About Us",
                style: TextStyle(
                  fontSize: 20.0,
                    fontWeight: FontWeight.w400
                ),),
             // trailing: Icon(Icons.info_outline_rounded),
            ),
            Divider(),
            ListTile(
              onTap: (){},
              leading: Icon(Icons.logout),
              title: Text("Logout",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400
                ),),
             // trailing: Icon(Icons.logout),
            ),
            //Divider(),


          ],
        ),
      ),

    );
  }
}
