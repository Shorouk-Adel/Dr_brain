import 'package:flutter/material.dart';

class CustomRadio extends StatelessWidget {
  Profile _profile;

  CustomRadio(this._profile);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: _profile.isSelected ? Colors.deepPurple : Colors.white,
        child: Container(
          height: 80,
          width: 80,
          alignment: Alignment.center,
          margin: new EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                _profile.icon,
                color: _profile.isSelected ? Colors.white : Colors.deepPurple,
                size: 40,
              ),
              SizedBox(height: 10),
              Text(
                _profile.name,
                style: TextStyle(
                    color:
                    _profile.isSelected ? Colors.white : Colors.deepPurple),
              )
            ],
          ),
        ));
  }
}

class Profile {
  String name;
  IconData icon;
  bool isSelected;

  Profile(this.name, this.icon, this.isSelected);
}
