import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:poke_api/core/di/service_locator.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt', // default
  preferRelativeImports: false, // default
  asExtension: false, // default
)
GetIt configureDependencies() => $initGetIt(getIt);
