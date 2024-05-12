import 'package:flutter/material.dart';
import 'package:schedule_app/viewmodels/schedule_screen_viewmodel.dart';

Widget commonDropdown(String value, List<String> items,
    ScheduleScreenViewModel viewmodel, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(38.0),
    child: DropdownButton<String>(
        value: viewmodel.datel,
        isExpanded: true,
        items: [
          DropdownMenuItem(
              value: viewmodel.datel, child: Text(viewmodel.datel!))
        ],
        onChanged: (val) {
          showDatePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100))
              .then((value) {
            viewmodel.updateDate(value.toString());
          });
        }),
  );
}
