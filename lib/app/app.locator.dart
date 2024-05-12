// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, implementation_imports, depend_on_referenced_packages

import 'package:stacked_services/src/navigation/navigation_service.dart';
import 'package:stacked_shared/stacked_shared.dart';

import '../services/create_service.dart';
import '../services/delete_service.dart';
import '../services/read_service.dart';
import '../services/update_service.dart';

final locator = StackedLocator.instance;

Future<void> setupLocator({
  String? environment,
  EnvironmentFilter? environmentFilter,
}) async {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  locator.registerSingleton(NavigationService());
  locator.registerLazySingleton(() => CreateService());
  locator.registerLazySingleton(() => ReadService());
  locator.registerLazySingleton(() => DeleteService());
  locator.registerLazySingleton(() => UpdateService());
}
