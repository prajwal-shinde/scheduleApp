import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
class CreateService{
  ProgressDialog? progressDialog;
  Future<bool?>? createSchedule(String date,String time,String docName,
  String onlineMeet,String email,BuildContext context)async{
     progressDialog = ProgressDialog(context);
    progressDialog!.style(message: 'Please wait');
    await progressDialog!.show();
     Map<String,dynamic> data = {
      'date':date,
      'time':time,
      'doc_name':docName,
      'online_meeting':onlineMeet,
      'email_cc':email
    };
  
    final response = await http.post(Uri.parse('https://showdigital.in/flutter-schedules/create_schedule.php'),
   
    body: jsonEncode(data)
    );
   
    int statusCode = response.statusCode;
    var body = response.body;
    print(body);
    Map<String,dynamic> responseData = jsonDecode(body);
    if(statusCode == 200){
      await progressDialog!.hide();
      await showDialog(context: context, builder: (context){
        return AlertDialog(
          actions: [
            ElevatedButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text("OK"))
          ],
          content: Text(
            responseData["message"]
          ),
        );
      });
      return true;
    }else{
     
      throw Exception('Failed to create record');
      
    }
  }
}