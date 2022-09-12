// import 'package:shared_preferences/shared_preferences.dart';

// class Preferences {
//   static SharedPreferences? _preferences;

//   static Future init() async {
//     print('init Preferences called');
//     return _preferences = await SharedPreferences.getInstance();
//   }

//   static Future setText(String text, String keyText) async {
//     print('setText Preferences called');
//     return await _preferences!.setString(keyText, text);
//   }

//   static String getText(String keyText) =>
//       _preferences!.getString(keyText) ?? '';
// }
