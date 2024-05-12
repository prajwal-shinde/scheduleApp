import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

class UpdateService {
  ProgressDialog? progressDialog;
  Future<bool>? updateSchedule(BuildContext context, String id, String date,
      String time, String docName, String onlineMeet, String emailCC) async {
    Map<String, dynamic> updateData = {
      'id': id,
      'date': date,
      'time': time,
      'doc_name': docName,
      'online_meeting': onlineMeet,
      'email_cc': emailCC
    };
    print(updateData);
    try {
      progressDialog = ProgressDialog(context);
      progressDialog!.style(message: 'Please wait');
      await progressDialog!.show();

      final response = await http.put(
        Uri.parse(
            'https://showdigital.in/flutter-schedules/update_schedule.php'),
        body: jsonEncode(updateData),
      );
      print(response.body);
      await progressDialog!.hide();

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        if (data.containsKey('message')) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(data['message']),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Close dialog
                      Navigator.pop(context); // Close screen
                    },
                    child: Text("Ok"),
                  )
                ],
              );
            },
          );
          return true;
        } else {
          throw FormatException('Invalid response format');
        }
      } else {
        throw Exception('Failed to update schedule: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating schedule: $e');
    }
  }
}
