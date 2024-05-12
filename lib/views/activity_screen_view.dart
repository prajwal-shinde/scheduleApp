import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:schedule_app/app/app.router.dart';
import 'package:schedule_app/utils/size_config.dart';
import 'package:schedule_app/viewmodels/activity_screen_viewmodel.dart';
import 'package:schedule_app/views/home_screen_view.dart';
import 'package:stacked/stacked.dart';

class ActivityScreenView extends StatelessWidget {
  const ActivityScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(viewModelBuilder: ()=>ActivityScreenViewModel(), 
    builder: (context,viewmodel,child){
      SizeConfig().init(context);
      return Scaffold(
        backgroundColor: Colors.lightGreen,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          iconTheme: IconThemeData(
            color: Colors.white
          ),
          backgroundColor: Colors.transparent,
          title: Text("Activities",style: TextStyle(
            color: Colors.white,
            fontSize: SizeConfig.blockSizeVertical! * 3
          ),),
          centerTitle: true,
          actions: [
            IconButton(onPressed: (){
              viewmodel.navigationService.navigateToHomeScreenView();
            }, icon: Icon(Icons.home,color: Colors.white,))
          ],

        ),
        bottomNavigationBar: BottomNavigationBar(items: [
          BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home,
              color:Colors.black)),
          BottomNavigationBarItem(icon: Icon(Icons.person,
              color:Colors.black),
          label:'Person'),
          BottomNavigationBarItem(icon: Icon(Icons.five_g,
              color:Colors.black),
          label: '5 G'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart,
              color:Colors.black),
          label: 'Status'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark,
              color:Colors.black),
          label: 'Bookmark'),
        ]),
        body:SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Padding(
              padding: const EdgeInsets.only(left:18.0,right: 18.0),
              child: Text("My World",
              style: TextStyle(
                color: Colors.white,
                fontSize:SizeConfig.blockSizeHorizontal! * 5.8,
                fontWeight: FontWeight.bold
              ),),
            ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0,right: 18.0),
                child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore mag",
                style: TextStyle(
                  color: Colors.white
                ),),
              ),
        
              Expanded(
                child: Stack(
                  children: [
                    AnimatedOpacity(
                      opacity: viewmodel.animateNewFact! ? 1.0:0.0,
                      duration: Duration(milliseconds: 500),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(45.0),
                          topRight: Radius.circular(40.0))
                        ),
                        child: Column(
                          children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("NEW FACTS"),
                                  ),
                                  Container(
                                    height: SizeConfig.blockSizeVertical! * 20,
                                    padding: EdgeInsets.only(top: SizeConfig.safeBlockVertical! * 3),
                                    child: PieChart(dataMap: viewmodel.dataMap,
                                     initialAngleInDegree: 250,
                                     colorList: [Colors.amber],
                                     legendOptions: LegendOptions(
                                       showLegends: false
                                     ),
                                      chartType: ChartType.ring,
                                      baseChartColor: Colors.white,
                                      chartValuesOptions: ChartValuesOptions(
                                        showChartValuesInPercentage: true,
                                      ),
                                      totalValue: 20,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("USEFUL SKILLS",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold
                                    ),),
                                  ),
                                  Container(
                                    height: SizeConfig.blockSizeVertical! * 20,
                                    padding: EdgeInsets.only(top: SizeConfig.safeBlockVertical! * 3),
                                    child: PieChart(dataMap: viewmodel.useful_skills,
                                      initialAngleInDegree: 250,
                                      colorList: [Colors.green],
                                      legendOptions: LegendOptions(
                                          showLegends: false
                                      ),
                                      chartType: ChartType.ring,
                                      baseChartColor: Colors.white,
                                      chartValuesOptions: ChartValuesOptions(
                                        showChartValuesInPercentage: true,
                                      ),
                                      totalValue: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                            SizedBox(height: SizeConfig.safeBlockVertical! * 4,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("MINDFULNESS"),
                                    ),
                                    Container(
                                      height: SizeConfig.blockSizeVertical! * 20,
                                      padding: EdgeInsets.only(top: SizeConfig.safeBlockVertical! * 3),
                                      child: PieChart(dataMap: viewmodel.mindfulness,
                                        initialAngleInDegree: 250,
                                        colorList: [Colors.purpleAccent],
                                        legendOptions: LegendOptions(
                                            showLegends: false
                                        ),
                                        chartType: ChartType.ring,
                                        baseChartColor: Colors.white,
                                        chartValuesOptions: ChartValuesOptions(
                                          showChartValuesInPercentage: true,
                                        ),
                                        totalValue: 20,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("EXERCISE",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold
                                        ),),
                                    ),
                                    Container(
                                      height: SizeConfig.blockSizeVertical! * 20,
                                      padding: EdgeInsets.only(top: SizeConfig.safeBlockVertical! * 3),
                                      child: PieChart(dataMap: viewmodel.exercise,
                                        initialAngleInDegree: 250,
                                        colorList: [Colors.blueAccent],
                                        legendOptions: LegendOptions(
                                            showLegends: false
                                        ),
                                        chartType: ChartType.ring,
                                        baseChartColor: Colors.white,
                                        chartValuesOptions: ChartValuesOptions(
                                          showChartValuesInPercentage: true,
                                        ),
                                        totalValue: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Align(
                              alignment:Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text("YOUR NUMBER LOOKS GREAT!",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.pink
                                ),),
                              ),
                            ),
                            Expanded(child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("You are having good new facts and keeping up with you.Did you know practicing a new skills and mindfulness can boost your confidence? See How"),
                            ))
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: SizeConfig.safeBlockVertical! * 70,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: SizeConfig.blockSizeVertical! * 4.5,
                        child: Card(
                          color: Colors.deepOrange,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0))
                          ),
                          child: Text(""),
                        ),
                      ),
                    ),
                  ],
                ),
              )
        
            ],
          ),
        )
      );

    });

  }


}