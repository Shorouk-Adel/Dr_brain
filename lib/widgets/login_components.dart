import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget CustomButton({
  double width = double.infinity,
  required Function() function,
  required String text,
  bool isUpperCase = true,
  double radius = 20.0,
}) =>
    Container(
      width: width,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          //isUpperCase ? text.toUpperCase() :
          text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.deepPurple,
        borderRadius: BorderRadius.circular(
          radius,
        ),
      ),
    );



Widget CustomTextForm(
    context, {
      required TextEditingController controller,
      required TextInputType keyboardType,
      required String label,
      required Function() onTap,
      Function(String?)? onChange,

      bool isPassword = false,
      String? Function(String?)? validate,
      IconData? preIcon,
      bool AutoFocus = false,
      String? prefixText,

    }) {
  final bool isactive = isPassword;
  isactive? isPassword = isPassword: null;


  return TextFormField(
    controller: controller,
    autofocus: AutoFocus,
    obscureText: isPassword,
    keyboardType: keyboardType,
    validator: validate,
    //onTap: onTap,
    onChanged: onChange,
    decoration: InputDecoration(
      prefixText: prefixText,
      labelText: label,
      prefixIcon: Icon(
        preIcon,
      ),

      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
      ),
    ),
  );
}
