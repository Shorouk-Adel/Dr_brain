import 'package:flutter/material.dart';
class PatientProfile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text('Profile',
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

                  backgroundImage: NetworkImage('https://www.nafham.com/uploads/avatars/47246_540cbb1eeb4e1.jpg'),
                ),
                SizedBox(
                  width: 15.0,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Mohamed Tohamy',
                      style: TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Text('tohamymedo11@gmail.com',
                      style: TextStyle(
                        fontSize: 15.0,
                          fontWeight: FontWeight.w400
                      ),
                    ),
                    Text('+201004724510',
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
            Text("SETTING"
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
