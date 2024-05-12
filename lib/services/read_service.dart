import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:schedule_app/model/schedule_model.dart';
import 'package:http/http.dart' as http;

class ReadService {
  Future<List<ScheduleModel?>> getScheduleData() async {
    try {
      var response = await http.get(Uri.parse(
          'https://showdigital.in/flutter-schedules/list_schedule.php'));
      print(response.body);
      final List scheduleList = jsonDecode(response.body);
      return scheduleList.map((e) => ScheduleModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }


}
