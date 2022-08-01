import 'package:dio/dio.dart';
import 'package:learn_flutter_login/data_api.dart';

abstract class DioService {
  static Future<DataApi?> getById(int id) async {
    try {
      var response = await Dio().get("https://reqres.in/api/users/$id");

      if (response.statusCode == 200) {
        return DataApi(
            id: response.data['data']['id'],
            name: response.data['data']['first_name'],
            email: response.data['data']['email']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<DataApi?> creteUser(
      String firstName, String lastName, String email) async {
    try {
      var response = await Dio().post("https://reqres.in/api/users", data: {
        'first_name': firstName,
        'last_name': lastName,
        'email': email
      });

      if (response.statusCode == 201) {
        return DataApi(
            id: int.tryParse(response.data['id'].toString()) ?? 0,
            name:
                response.data['first_name'] + ' ' + response.data['last_name'],
            email: response.data[
                'email']); // tryparse will return null if convertion is failed
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
