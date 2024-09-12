import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vacancy/utils/app_shared_prefrenses.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial());
  bool isDark = AppSharedPreferences.prefs?.getBool('isDark') ?? false;

  void changeTheme(bool _isDark) {
    isDark = _isDark;
    emit(ThemeChanged(isDark: _isDark));
  }
}
