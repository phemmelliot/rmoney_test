import 'package:dio/dio.dart';
import 'package:rmoney_test/dependency/injector.dart';
import 'package:rmoney_test/services/dio_client.dart';
import 'package:rmoney_test/services/service_api.dart';
import 'package:rmoney_test/services/web_service.dart';

class DependencyManager {
  static inject() {
    dependencyInjector.allowReassignment = true;

    dependencyInjector.registerSingletonAsync<Dio>(() => ApiClient.getClient());
    dependencyInjector.registerLazySingleton<WebService>(() => WebService());
    dependencyInjector.registerLazySingleton<ServiceAPI>(() => ServiceAPI());
  }
}

