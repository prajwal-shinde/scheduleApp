import 'package:flutter/material.dart';
import 'package:schedule_app/viewmodels/home_screen_viewmodel.dart';
import 'package:stacked/stacked.dart';

import 'activity_screen_view.dart';

class HomeScreenView extends StatelessWidget {
  const HomeScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(viewModelBuilder: ()=>HomeScreenViewModel(), 
    builder: (context,viewmodel,child){
      return Scaffold(
      backgroundColor: Colors.blueAccent,
       body: SafeArea(
         child: Center(
           child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: (){
                viewmodel.navigateToSchedule();
              }, child: Text("Navigate to Schedule Screen")),
              ElevatedButton(onPressed: (){
                viewmodel.navigationService.navigateWithTransition(ActivityScreenView());
              }, child: Text("Navigate to Activity Screen"))
            ],
           ),
         ),
       ),
      );
    });
  }
}