import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  static final  storage = FlutterSecureStorage();
  static const token = 'token';

  static Future setToken(String tokenValue) async =>
    await storage.write(key: token, value: tokenValue);
  

  static Future<String?> getToken() async =>
    await storage.read(key: token);
  
}