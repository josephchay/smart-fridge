import 'package:get_it/get_it.dart';

import 'package:smart_fridge/src/features/authentication/injection_container.dart'
    as auth_di;
import 'package:smart_fridge/src/features/diary/injection_container.dart'
    as diary_di;

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  await auth_di.initializeDependencies();
  await diary_di.initializeDependencies();
}
