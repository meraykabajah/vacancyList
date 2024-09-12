
import 'package:get_it/get_it.dart';
import 'package:vacancy/domain/theme_cubit/theme_cubit.dart';

import 'domain/job_list/job_list_cubit.dart';

GetIt sl = GetIt.instance;

void initializeServices() {
  sl.registerSingleton(JobListCubit());
  sl.registerSingleton(ThemeCubit());
}
