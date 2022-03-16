import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class BookScreen extends StatelessWidget {
  const BookScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(


            body: SingleChildScrollView(
                child: Column(
              children: [
                TextFormField(
                  maxLines: 6,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    focusColor: Colors.black,
                  ),
                ),
                TextFormField(
                  onTap: () {
                    DatePicker.showTime12hPicker(
                      context,
                      showTitleActions: true,
                      onChanged: (date) {
                        final dt = DateTime(date.year, date.month, date.day,
                            date.hour, date.minute);
                        var formatTime = DateFormat.jm();
                        var apiStringTime = formatTime.format(date).toString();
                        print('change $date in time zone ' + apiStringTime);
                      },
                      onConfirm: (date) {
                        final dt = DateTime(date.year, date.month, date.day,
                            date.hour, date.minute);
                        var formatTime = DateFormat.jm();
                        var apiStringTime =
                            formatTime.format(date).toString(); //"6:00 AM"
                        print('confirm $apiStringTime');
                        print(formatTime.format(date));
                      },
                    );
                  },
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    focusColor: Colors.black,
                  ),
                ),
                // TextFormField(
                //   onTap: () {
                //     DatePicker.showDatePicker(context,
                //         showTitleActions: true,
                //         minTime: DateTime(2022, 3, 13),
                //         maxTime: DateTime(2022, 12, 31), onChanged: (date) {
                //       var apiStringDate = date.year.toString() +
                //           "-" +
                //           date.month.toString() +
                //           "-" +
                //           date.day.toString();
                //       print('change ' + apiStringDate);
                //     }, onConfirm: (date) {
                //       var apiStringDate = date.year.toString() +
                //           "-" +
                //           date.month.toString() +
                //           "-" +
                //           date.day.toString();
                //       print('confirm ' +
                //           date.year.toString() +
                //           "-" +
                //           date.month.toString() +
                //           "-" +
                //           date.day.toString());
                //     }, currentTime: DateTime.now(), locale: LocaleType.en);
                //   },
                //   decoration: InputDecoration(
                //     labelText: "Date",
                //     prefixIcon: Icon(Icons.event, color: Colors.deepPurple),
                //   ),
                // ),
                TextFormField(
                  cursorColor: Colors.deepPurple,
                  onTap: () {
                    DatePicker.showTime12hPicker(
                      context,
                      showTitleActions: true,
                      onChanged: (date) {
                        final dt = DateTime(date.year, date.month, date.day,
                            date.hour, date.minute);
                        var formatTime = DateFormat.jm();
                        var apiStringTime = formatTime.format(date).toString();
                        print('change $date in time zone ' + apiStringTime);
                      },
                      onConfirm: (date) {
                        final dt = DateTime(date.year, date.month, date.day,
                            date.hour, date.minute);
                        var formatTime = DateFormat.jm();
                        var apiStringTime =
                            formatTime.format(date).toString(); //"6:00 AM"
                        print('confirm $apiStringTime');
                        print(formatTime.format(date));
                      },
                    );
                  },
                  decoration: InputDecoration(
                    labelText: "Time",
                    prefixIcon:
                        Icon(Icons.access_time, color: Colors.deepPurple),
                  ),
                ),
              ],
            ))));
  }
}
