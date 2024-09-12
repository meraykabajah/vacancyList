import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vacancy/domain/theme_cubit/theme_cubit.dart';
import 'package:vacancy/pages/list_screen.dart';
import 'package:vacancy/utils/app_shared_prefrenses.dart';

import 'injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppSharedPreferences.init();
  initializeServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ThemeCubit, ThemeState>(
      bloc: sl<ThemeCubit>(),
      listener: (context, state) {
        if (state is ThemeChanged) {
          AppSharedPreferences.prefs?.setBool('isDark', state.isDark);
        }
      },
      builder: (context, state) {
        return MaterialApp(
          title: 'Vacancy',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue, brightness: Brightness.dark),
            useMaterial3: true,
          ),
          themeMode: (sl<ThemeCubit>().isDark)
              ? ThemeMode.dark
              : ThemeMode.light,
          home: const JobsListScreen(title: 'Vacancy List'),
        );
      },
    );
  }
}
