import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
class DeleteService{
  ProgressDialog? progressDialog;
  Future<bool?>? deleteSchedule(BuildContext context,String id)async{
    try{
       progressDialog = ProgressDialog(context);
    progressDialog!.style(message: 'Please wait');
    await progressDialog!.show();
var response = await http.delete(Uri.parse('https://showdigital.in/flutter-schedules/delete_schedule.php?id=$id'));
    var body = jsonDecode(response.body);
    Map<String,dynamic> data = body;
    print(data);
    print(response.statusCode);
    if(response.statusCode == 200){
      print("Inside 200");
      await progressDialog!.hide();
      await showDialog(context: context, builder: (context){
        return AlertDialog(
          actions: [
            ElevatedButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text("OK"))
          ],
          content: Text(
            data["message"].toString()
          ),
        );
      });
  return true;
    }
    else{
       await progressDialog!.hide();
      await showDialog(context: context, builder: (context){
        return AlertDialog(
          actions: [
            ElevatedButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text("OK"))
          ],
          content: Text(
            data["error"]
          ),
        );
      });
      return false;
    }
    }catch(e){
      throw Exception(e);
    }
  }
}