import 'package:get_it/get_it.dart';

var dependencyInjector = GetIt.I;

extension DependencyInjector on GetIt {
  Future<void> ensureReady<T extends Object>() async {
    try {
      await isReady<T>();
    } catch (e) {
      // Means the dependency was ready

      print(
        "Ignored Dependency $T after attempting isReady because it isn't async: $e",
      );
    }
  }
}
