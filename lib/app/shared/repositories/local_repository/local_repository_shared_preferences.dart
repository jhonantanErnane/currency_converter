import 'package:currency_converter/app/shared/enums/enum_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalRepositorySharedPreferences {
  SharedPreferences _preferences;

  Future<void> _getInstance() async {
    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }
  }

  Future<void> saveThemeChoiced(EnumTheme choice) async {
    await _getInstance();
    try {
      await _preferences.setString('EnumTheme', choice.toString());
    } catch (e) {
      print(e);
    }
  }

  Future<String> getThemeChoiced() async {
    await _getInstance();
    try {
      return _preferences.getString('EnumTheme') ?? EnumTheme.LIGHTTHEME.toString();
    } catch (e) {
      print(e);
      return EnumTheme.LIGHTTHEME.toString();
    }
  }
}
