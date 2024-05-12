import 'package:schedule_app/services/create_service.dart';
import 'package:schedule_app/services/delete_service.dart';
import 'package:schedule_app/services/read_service.dart';
import 'package:schedule_app/services/update_service.dart';
import 'package:schedule_app/views/activity_screen_view.dart';
import 'package:schedule_app/views/home_screen_view.dart';
import 'package:schedule_app/views/schedule_screen_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(routes: [
  MaterialRoute(page: HomeScreenView,initial: true),
  MaterialRoute(page: ScheduleScreenView),
  MaterialRoute(page: ActivityScreenView)
],
dependencies: [
  Singleton(classType: NavigationService),
  LazySingleton(classType: CreateService),
  LazySingleton(classType: ReadService),
  LazySingleton(classType: DeleteService),
  LazySingleton(classType: UpdateService)
]
)
class App{}