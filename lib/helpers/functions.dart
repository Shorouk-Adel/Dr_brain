
/*
userLogin({required String email, required String password,context}) async
{
  //sending data to login api
  //if(Profiles[index].name=="Patient")
  final response = await http.post(
    Uri.parse('https://dr-brains.com/api/patient_login'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,

    }),
  );
  if (response.statusCode == 200) {

    print('Congratulations,you have signed in successfully');
    Navigator.push(context, MaterialPageRoute(
        builder: (BuildContext context) =>  PatientLayout()));
    token=jsonDecode(response.body)['token'];

      print(token);

    print('Token : ${jsonDecode(response.body)['token']}');
    //showToast(text:'Logged in Successfully' , state: ToastStates.SUCCESS);


  }
  else {
    //showToast(text:jsonDecode(response.body)['error'] , state: ToastStates.ERROR);
    throw Exception('Failed to login');





  }
}

void userSignUp(
    {required String email,
      required String password,
      required String name,
    context}) async {
  //sending data to register api
  final response = await http.post(
    Uri.parse('https://dr-brains.com/api/patient_registeration'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, String>{
      'name': name,
      'email': email,
      'password': password,
    }),
  );
  if (response.statusCode == 200) {
    // print('Congratulations,you have registered successfully');

    token = jsonDecode(response.body)["token"];
    Navigator.push(context, MaterialPageRoute(
        builder: (BuildContext context) =>  PatientLayout()));

   // showToast(text:'Congratulations, you have signed up Successfully' , state: ToastStates.SUCCESS);
    // print(token);

  } else {
    //showToast(text:jsonDecode(response.body)['message'] , state: ToastStates.ERROR);
    throw Exception('Failed to send data');
  }
}


//changing password visibility
bool isPassword = true;
IconData? suffixIcon = Icons.visibility_off_outlined;
void changePasswordVisibility(){

  isPassword =! isPassword;
  suffixIcon = isPassword ?Icons.visibility_off_outlined:Icons.visibility_outlined;
}
*/

/*
void showToast({
  required String text,
  required ToastStates state,})=>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0
    );*/

/*enum ToastStates {SUCCESS, ERROR, WARNING}

Color chooseToastColor(ToastStates state)
{
  Color color;

  switch(state)
  {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.WARNING:
      color = Colors.yellow;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
  }
  return color;
}

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
      (Route<dynamic> route) => false,
);*/

