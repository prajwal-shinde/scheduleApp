import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:schedule_app/model/schedule_model.dart';
import 'package:schedule_app/utils/size_config.dart';
import 'package:schedule_app/viewmodels/schedule_screen_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ScheduleScreenView extends StatelessWidget {
  const ScheduleScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => ScheduleScreenViewModel(),
        builder: (context, viewmodel, child) {
          viewmodel.getScheduleData(context);
          return Scaffold(
            body: SingleChildScrollView(
              child: SafeArea(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 33.0, left: 20.0),
                    child: Text(
                      "Create Schedule",
                      style: TextStyle(
                          fontSize: SizeConfig.blockSizeVertical! * 3,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                  ),
                  Divider(
                    color: Colors.blue,
                    thickness: 2,
                  ),
                  Form(
                    key: viewmodel.formKey,
                      child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 15.0, left: 20.0, right: 20.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: Colors.blueGrey, width: 2.0)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: DropdownButtonFormField<String>(
                                validator: (val){
                                  if(val == null || val == "Select a Date"){
                                    return 'Required';
                                  }
                                  return null;
                                },
                                value: viewmodel.datel,
                                isExpanded: true,
                                items: [
                                  DropdownMenuItem(
                                      value: viewmodel.datel,
                                      child: Text(viewmodel.datel!))
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
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 15.0, left: 20.0, right: 20.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: Colors.blueGrey, width: 2.0)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: DropdownButtonFormField<String>(
                                validator: (val){
                                  if(val == null){
                                    return 'Required';
                                  }
                                  return null;
                                },
                                hint: Text('Location/Station'),
                                value: viewmodel.selectedLocation,
                                isExpanded: true,
                                items: ["Mumbai", "Pune", "Banglore"]
                                    .map((e) => DropdownMenuItem(
                                        value: e, child: Text(e)))
                                    .toList(),
                                onChanged: (val) {
                                  viewmodel.updateLocation(val!);
                                }),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 15.0, left: 20.0, right: 20.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: Colors.blueGrey, width: 2.0)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: DropdownButtonFormField<String>(
                                validator: (val){
                                  if(val == null){
                                    return 'Required';
                                  }
                                  return null;
                                },
                                hint: Text('Hospital/Site Name'),
                                value: viewmodel.selectedHospital,
                                isExpanded: true,
                                items: [
                                  "Bhatia Hospital",
                                  "Nair Hospital",
                                  "City Hospital"
                                ]
                                    .map((e) => DropdownMenuItem(
                                        value: e, child: Text(e)))
                                    .toList(),
                                onChanged: (val) {
                                  viewmodel.updateHospital(val!);
                                }),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 15.0, left: 20.0, right: 20.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: Colors.blueGrey, width: 2.0)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: DropdownButtonFormField<String>(
                                validator: (val){
                                  if(val == null || val == "Select a Time"){
                                    return 'Required';
                                  }
                                  return null;
                                },
                                hint: Text('Select a Time*'),
                                value: viewmodel.selectedTime,
                                isExpanded: true,
                                items: [
                                  DropdownMenuItem(
                                      value: viewmodel.selectedTime,
                                      child: Text(viewmodel.selectedTime!))
                                ],
                                onChanged: (val) {
                                  showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now())
                                      .then((value) {
                                    viewmodel.updateTime(value!);
                                  });
                                }),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 15.0, left: 20.0, right: 20.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: Colors.blueGrey, width: 2.0)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: DropdownButtonFormField<String>(
                                validator: (val){
                                  if(val == null){
                                    return 'Required';
                                  }
                                  return null;
                                },
                                hint: Text('Prospectus'),
                                value: viewmodel.selectedProspectus,
                                isExpanded: true,
                                items: ["Dr.Sharma", "Dr.Patil", "Dr.Jadhav"]
                                    .map((e) => DropdownMenuItem(
                                        value: e, child: Text(e)))
                                    .toList(),
                                onChanged: (val) {
                                  viewmodel.updateProspectus(val!);
                                }),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 15.0, left: 20.0, right: 20.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: Colors.blueGrey, width: 2.0)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: DropdownButtonFormField<String>(
                                validator: (val){
                                  if(val == null){
                                    return 'Required';
                                  }
                                  return null;
                                },
                                hint: Text('Coworkers'),
                                value: viewmodel.selectedCoworkers,
                                isExpanded: true,
                                items: ["Raman", "Mr.John", "Mr.Crasto"]
                                    .map((e) => DropdownMenuItem(
                                        value: e, child: Text(e)))
                                    .toList(),
                                onChanged: (val) {
                                  viewmodel.updateCoworkers(val!);
                                }),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Row(
                          children: [
                            Switch(

                              value: viewmodel.isScheduled!,
                              onChanged: (val) {
                                viewmodel.updateMeetingStatus();
                              },
                              activeColor: Colors.green,
                            ),
                            SizedBox(
                              width: SizeConfig.blockSizeHorizontal! * 2.5,
                            ),
                            Text(
                              "Schedule Online Meeting",
                              style: TextStyle(
                                  fontSize: SizeConfig.blockSizeVertical! * 2),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: TextFormField(
                          validator: (val){
                            if(val == null || val == "" || val.isEmpty){
                              return 'Required';
                            }
                            return null;
                          },
                          controller: viewmodel.emailController,
                          decoration: InputDecoration(
                              hintText: 'CC Email ID',
                              border: OutlineInputBorder()),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: MaterialButton(
                          minWidth: double.infinity,
                          onPressed: () {
                            if(viewmodel.formKey.currentState!.validate()){
                              viewmodel.getData =
                                  viewmodel.createSchedule(context);
                            }
                          },
                          child: Text(
                            "Add Schedule",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          color: Colors.blue,
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 33.0, left: 20.0),
                          child: Text(
                            "Upcoming Schedule",
                            style: TextStyle(
                                fontSize: SizeConfig.blockSizeVertical! * 3,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.blue,
                        thickness: 2,
                      ),
                      FutureBuilder<List<ScheduleModel?>>(
                        future: viewmodel.getScheduleUpcomingData,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return SizedBox(
                              height: SizeConfig.blockSizeVertical! * 23,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Card(
                                          child: SizedBox(
                                              width: SizeConfig
                                                      .blockSizeHorizontal! *
                                                  56,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      viewmodel.convertDate(
                                                          snapshot.data![index]!
                                                              .date!),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: SizeConfig
                                                                  .blockSizeHorizontal! *
                                                              4),
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          snapshot.data![index]!
                                                              .time!,
                                                          style: TextStyle(
                                                              fontSize: SizeConfig
                                                                      .blockSizeHorizontal! *
                                                                  4),
                                                        ),
                                                      ),
                                                      Text(
                                                        snapshot.data![index]!
                                                            .docName!,
                                                        style: TextStyle(
                                                            fontSize: SizeConfig
                                                                    .blockSizeHorizontal! *
                                                                4),
                                                      )
                                                    ],
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        IconButton(
                                                            onPressed: () async{
                                                              viewmodel
                                                                      .dateController
                                                                      .text =
                                                                  snapshot
                                                                      .data![
                                                                          index]!
                                                                      .date!;
                                                              viewmodel
                                                                      .timeController
                                                                      .text =
                                                                  snapshot
                                                                      .data![
                                                                          index]!
                                                                      .time!;
                                                              viewmodel
                                                                      .selectedProspectus =
                                                                  snapshot
                                                                      .data![
                                                                          index]!
                                                                      .docName;
                                                            viewmodel.isUpdateScheduled =  viewmodel.onlineMeet(int.parse(snapshot.data![index]!.onlineMeeting!));
                                                              viewmodel.emailController.text = snapshot.data![index]!.emailCc!;

                                                         showDialog(
                                                             context:
                                                             context,
                                                             builder:
                                                                 (context) {
                                                               return  StatefulBuilder(
                                                                   builder: (BuildContext context, StateSetter setState) {
                                                                     return AlertDialog(
                                                                       title: Text(
                                                                           "Update Details"),
                                                                       content:
                                                                       SingleChildScrollView(
                                                                         child:
                                                                         Column(
                                                                           mainAxisSize:
                                                                           MainAxisSize.min,
                                                                           children: [
                                                                             Form(
                                                                               key:viewmodel.updateFormKey,
                                                                                 child: Column(
                                                                                   children: [
                                                                                     InkWell(
                                                                                       onTap: () {
                                                                                         print("Iside");
                                                                                         viewmodel.selectDate(context);
                                                                                       },
                                                                                       child: IgnorePointer(
                                                                                         child: Padding(
                                                                                           padding: const EdgeInsets.all(8.0),
                                                                                           child: TextFormField(
                                                                                             validator: (val){
                                                                                               if(val == null || val == ""){
                                                                                                 return "Required";
                                                                                               }
                                                                                               return null;
                                                                                             },
                                                                                             readOnly: true,
                                                                                             controller: viewmodel.dateController,
                                                                                             decoration: InputDecoration(suffixIcon: Icon(Icons.arrow_drop_down_outlined), border: OutlineInputBorder()),
                                                                                           ),
                                                                                         ),
                                                                                       ),
                                                                                     ),
                                                                                     InkWell(
                                                                                       onTap: () {
                                                                                         showTimePicker(context: context, initialTime: TimeOfDay.now()).then((value) {
                                                                                           var formattedTime = viewmodel.formatTime(value!);
                                                                                           viewmodel.timeController.text = formattedTime;
                                                                                         });
                                                                                       },
                                                                                       child: IgnorePointer(
                                                                                         child: Padding(
                                                                                           padding: const EdgeInsets.all(8.0),
                                                                                           child: TextFormField(
                                                                                             validator: (val){
                                                                                               if(val == null || val == ""){
                                                                                                 return "Required";
                                                                                               }
                                                                                               return null;
                                                                                             },
                                                                                             readOnly: true,
                                                                                             controller: viewmodel.timeController,
                                                                                             decoration: InputDecoration(suffixIcon: Icon(Icons.arrow_drop_down_outlined), border: OutlineInputBorder()),
                                                                                           ),
                                                                                         ),
                                                                                       ),
                                                                                     ),
                                                                                     Padding(
                                                                                       padding: const EdgeInsets.all(8),
                                                                                       child: DropdownButtonFormField<String>(
                                                                                           validator: (val){
                                                                                             if(val == null || val == ""){
                                                                                               return "Required";
                                                                                             }
                                                                                             return null;
                                                                                           },
                                                                                           hint: Text('Prospectus'),
                                                                                           value: viewmodel.selectedProspectus,
                                                                                           isExpanded: true,
                                                                                           items: ["Dr.Sharma", "Dr.Patil", "Dr.Jadhav"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                                                                                           onChanged: (val) {
                                                                                             setState(() {
                                                                                               viewmodel.selectedProspectus = val;
                                                                                             });
                                                                                             print("1 ${viewmodel.selectedProspectus!}");
                                                                                             viewmodel.updateProspectus(val!);
                                                                                             print("2 ${viewmodel.selectedProspectus!}");
                                                                                           }),
                                                                                     ),
                                                                                     Row(
                                                                                       children: [
                                                                                         Switch(
                                                                                           value: viewmodel.isUpdateScheduled!,
                                                                                           onChanged: (val) {
                                                                                             setState((){
                                                                                               viewmodel.updateChangeMeetingStatus(val);
                                                                                             });

                                                                                           },
                                                                                           activeColor: Colors.green,
                                                                                         ),
                                                                                         Text(
                                                                                           "Schedule Online Meeting",
                                                                                           style: TextStyle(fontSize: SizeConfig.blockSizeVertical! * 2),
                                                                                         )
                                                                                       ],
                                                                                     ),
                                                                                     Padding(
                                                                                       padding: const EdgeInsets.all(18.0),
                                                                                       child: TextFormField(
                                                                                         validator: (val){
                                                                                           if(val == null || val == ""){
                                                                                             return "Required";
                                                                                           }
                                                                                           return null;
                                                                                         },
                                                                                         controller: viewmodel.emailController,
                                                                                         decoration: InputDecoration(hintText: 'CC Email ID', border: OutlineInputBorder()),

                                                                                       ),
                                                                                     ),
                                                                                     Row(
                                                                                       mainAxisAlignment: MainAxisAlignment.end,
                                                                                       children: [
                                                                                         MaterialButton(
                                                                                             color: Colors.blue,
                                                                                             minWidth: double.minPositive,
                                                                                             onPressed: () async {
                                                                                               if(viewmodel.updateFormKey.currentState!.validate()){
                                                                                                 viewmodel.updateData = viewmodel.updateSchedule(context, snapshot.data![index]!.id!.toString(), snapshot.data![index]!.date!.toString(), snapshot.data![index]!.time!.toString(), snapshot.data![index]!.docName!.toString(), snapshot.data![index]!.onlineMeeting!.toString(), snapshot.data![index]!.emailCc.toString());
                                                                                               }
                                                                                             },
                                                                                             child: Text(
                                                                                               'Save',
                                                                                               style: TextStyle(color: Colors.white, fontSize: SizeConfig.blockSizeVertical! * 2),
                                                                                             )),
                                                                                         SizedBox(
                                                                                           width: SizeConfig.blockSizeHorizontal! * 5,
                                                                                         ),
                                                                                         MaterialButton(
                                                                                             color: Colors.blue,
                                                                                             minWidth: double.minPositive,
                                                                                             onPressed: () {
                                                                                               Navigator.pop(context);
                                                                                             },
                                                                                             child: Text(
                                                                                               'Cancel',
                                                                                               style: TextStyle(color: Colors.white, fontSize: SizeConfig.blockSizeVertical! * 2),
                                                                                             )),
                                                                                       ],
                                                                                     )
                                                                                   ],
                                                                                 ))
                                                                           ],
                                                                         ),
                                                                       ),
                                                                     );
                                                                   }

                                                               );
                                                             });

                                                            },
                                                            icon: Icon(
                                                                Icons.edit)),
                                                        IconButton(
                                                            onPressed: () {
                                                              viewmodel.deleteSchedule(
                                                                  context,
                                                                  snapshot
                                                                      .data![
                                                                          index]!
                                                                      .id!);
                                                            },
                                                            icon: Icon(
                                                              Icons.delete,
                                                              color: Colors.red,
                                                            ))
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              )),
                                        ));
                                  }),
                            );
                          } else {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "No Data",
                                style: TextStyle(
                                    fontSize:
                                        SizeConfig.blockSizeHorizontal! * 5),
                              ),
                            );
                          }
                        },
                      )
                    ],
                  ))
                ],
              )),
            ),
          );
        });
  }
}
