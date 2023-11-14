import 'dart:convert';
import 'package:dio/dio.dart';

import '../../libOussama/utils/exports.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  final Dio _dio = Dio();
  Future<dynamic> registerUser(Map<String, dynamic>? data) async {
    try {
      Response response = await _dio.post(
        'http://10.0.2.2:3000/user/register',
        data: data,
        options: Options(
          headers: {
            Headers.contentTypeHeader: Headers.jsonContentType,
          },
        ),
      );
      return response.data;
    } on DioError catch (e) {
      return e.response!.data;
    }
  }

  //  try {//
  //
  //  } catch (e) {
  //    print(e.toString());
  //  }

  Future<dynamic> login(String email, String password) async {
    try {
      Response response = await _dio.post(
        'http://10.0.2.2:3000/user/login',
        data: {
          'email': email,
          'password': password,
        },
        options: Options(
          headers: {
            Headers.contentTypeHeader: Headers.jsonContentType,
          },
        ),
      );

      return response.data;
      ; // 0 is the default value if no id is found
    } on DioError catch (e) {
      return e.response!.data;
    }
  }

  Future<dynamic> recevoirCode(String email, String password) async {
    try {
      Response response = await _dio.post(
        'http://10.0.2.2:3000/user/reset',
        data: {
          'email': email,
        },
        options: Options(
          headers: {
            Headers.contentTypeHeader: Headers.jsonContentType,
          },
        ),
      );

      return response.data;
    } on DioError catch (e) {
      return e.response!.data;
    }
  }

  dynamic getUserProfileData(String identifier) async {
    try {
      Response response = await _dio.get(
        'http://10.0.2.2:3000/user/getOnce/' + identifier,
        options: Options(
          headers: {
            Headers.contentTypeHeader: Headers.jsonContentType,
          },
        ),
      );
      return response.data;
    } on DioError catch (e) {
      return e.response!.data;
    }
  }

// Future<dynamic> updateUserProfile({
//   required String accessToken,
//   required Map<String, dynamic> data,
// }) async {
//   try {
//     Response response = await _dio.put(
//       'https://api.loginradius.com/identity/v2/auth/account',
//       data: data,
//       options: Options(
//         headers: {'Authorization': 'Bearer $accessToken'},
//       ),
//     );
//     return response.data;
//   } on DioError catch (e) {
//     return e.response!.data;
//   }
// }

  // Future<dynamic> logout(String accessToken) async {
  //   try {
  //     Response response = await _dio.get(
  //       'https://api.loginradius.com/identity/v2/auth/access_token/InValidate',
  //       options: Options(
  //         headers: {'Authorization': 'Bearer $accessToken'},
  //       ),
  //     );
  //     return response.data;
  //   } on DioError catch (e) {
  //     return e.response!.data;
  //   }
  // }
}
