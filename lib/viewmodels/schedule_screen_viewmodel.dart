import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:schedule_app/app/app.locator.dart';
import 'package:schedule_app/model/schedule_model.dart';
import 'package:schedule_app/services/create_service.dart';
import 'package:schedule_app/services/delete_service.dart';
import 'package:schedule_app/services/read_service.dart';
import 'package:schedule_app/services/update_service.dart';
import 'package:schedule_app/utils/size_config.dart';
import 'package:stacked/stacked.dart';
import 'package:intl/intl.dart';

class ScheduleScreenViewModel extends BaseViewModel{
  String? datel = "Select a Date";
  String? selectedTime = "Select a Time";
  String? selectedLocation;
  String? formattedDate;
  String? formattedTime;
  String? selectedHospital;
  String? selectedProspectus;
  String? selectedCoworkers;
  bool? isScheduled = false;
  bool? isUpdateScheduled = false;
  bool? hideDialog = false;
  int? onlinemeeting = 0;
  int? onlineUpdateMeeting = 0;
  ProgressDialog? progressDialog;
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final createService = locator<CreateService>();
  final readService = locator<ReadService>();
  final deleteService = locator<DeleteService>();
  final updateService = locator<UpdateService>();
  Future<List<ScheduleModel?>>? getScheduleUpcomingData;
  Future<bool?>? getData;
  Future<bool?>? deleteData;
  Future<bool?>? updateData;
  final formKey = GlobalKey<FormState>();
  final updateFormKey = GlobalKey<FormState>();

  updateDate(String date) {
    formattedDate = DateFormat('yyyy-dd-MM').format(DateTime.parse(date));
    datel = formattedDate;
    notifyListeners();
  }

  updateTime(TimeOfDay time) {
    selectedTime = formatTime(time);
    notifyListeners();
  }

  updateLocation(String location) {
    selectedLocation = location;
    notifyListeners();
  }

  updateHospital(String hospital) {
    selectedHospital = hospital;
    notifyListeners();
  }

  updateProspectus(String prospectus) async {
    selectedProspectus = prospectus;
    notifyListeners();
  }

  updateCoworkers(String coworkers) {
    selectedCoworkers = coworkers;
    notifyListeners();
  }

  String formatTime(TimeOfDay timeOfDay) {
    String hour = _formatHour(timeOfDay.hour);
    String minute = _formatMinute(timeOfDay.minute);
    String period = timeOfDay.period == DayPeriod.am ? 'AM' : 'PM';

    return '$hour:$minute $period';
  }

  String _formatHour(int hour) {
    if (hour == 0) {
      return '12';
    } else if (hour > 12) {
      return '${hour - 12}';
    } else {
      return '$hour';
    }
  }

  String _formatMinute(int minute) {
    return minute.toString().padLeft(2, '0');
  }

  updateMeetingStatus() {
    isScheduled = !isScheduled!;
    isScheduled! ? onlinemeeting = 1 : onlinemeeting = 0;
    notifyListeners();
  }

  updateChangeMeetingStatus(bool? value) {
    isUpdateScheduled = value;
    isUpdateScheduled! ? onlineUpdateMeeting = 1 : onlineUpdateMeeting = 0;
    notifyListeners();
    rebuildUi();
  }

  Future<bool?> createSchedule(BuildContext context) async {
    getData = createService.createSchedule(
        datel!,
        selectedTime!,
        selectedProspectus!,
        onlinemeeting.toString(),
        emailController.text,
        context);

   if(getData == true){
    await getScheduleData(context);
   }
   notifyListeners();
    return getData!;
  }

  Future<List<ScheduleModel?>> getScheduleData(BuildContext context) {
    getScheduleUpcomingData = readService.getScheduleData();
    return getScheduleUpcomingData!;
  }

  Future<bool?>? updateSchedule(BuildContext context, String id, String date,
      String time, String docName, String onlineMeet, String emailCC) async {
    // Await the updateSchedule method
    date = dateController.text.trim();
    time = timeController.text.trim();
    docName = selectedProspectus.toString();
    onlineMeet = onlineMeetInt(isUpdateScheduled!).toString();
    emailCC = emailController.text.trim();
    bool? updateData = await updateService.updateSchedule(
        context, id, date, time, docName, onlineMeet, emailCC);

    if (updateData == true) {
      hideDialog = !hideDialog!;
      await getScheduleData(context);
      notifyListeners();
      rebuildUi();
    }

    return updateData;
  }

  Future<bool?> deleteSchedule(BuildContext context, String id) async {
    bool? deletionResult = await deleteService.deleteSchedule(context, id);
    if (deletionResult == true) {
      await getScheduleData(context);
    }
    notifyListeners();
    return deletionResult;
  }

  String convertDate(String date) {
    DateTime dateTime = DateFormat('yyyy-dd-MM').parse(date);
    String formattedDate = DateFormat('dd MMMM yyyy').format(dateTime);
    return formattedDate;
  }

  selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    formattedDate = DateFormat('yyyy-dd-MM').format(pickedDate!);
    if (pickedDate != null) {
      dateController.text = formattedDate!;
    }
  }

  bool? onlineMeet(int val) {
    if (val == 0) {
      return false;
    }
    return true;
  }
  int? onlineMeetInt(bool val) {
    if (val == false) {
      return 0;
    }
    return 1;
  }


}
