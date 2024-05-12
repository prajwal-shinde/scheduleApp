import 'package:schedule_app/app/app.locator.dart';
import 'package:schedule_app/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeScreenViewModel extends BaseViewModel{
  final navigationService = locator<NavigationService>();

navigateToActivity(){
  navigationService.navigateToActivityScreenView();
}
navigateToSchedule(){
  navigationService.navigateToScheduleScreenView();
}
}