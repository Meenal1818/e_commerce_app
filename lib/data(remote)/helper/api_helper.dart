import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'app_exception.dart';

class ApiHelper {
  ///get
  Future<dynamic> getApi({
    required String url,
    Map<String, String>? mHeaderParams,
  }) async {
    mHeaderParams ??= {};

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      mHeaderParams["Authorization"] = "Bearer $token";


    try {
      var response = await http.get(Uri.parse(url), headers: mHeaderParams);
      return returnResponse(response);
    } on SocketException catch (e) {
      throw NoInternetException(msg: "Not connected to Internet");
    } catch (e) {
      throw ServerException(msg: "with error ${e.toString()}");
    }
  }

  ///post
  Future<dynamic> postApi({
    required String url,
    Map<String, dynamic>? mBodyParams,
    Map<String, String>? mHeaderParams,
    bool isAuth = false,
  }) async {
    if (!isAuth) {
      mHeaderParams ??= {};

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      mHeaderParams["Authorization"] = "Bearer $token";
    }

    try {
      var response = await http.post(
        Uri.parse(url),
        body: mBodyParams != null ? jsonEncode(mBodyParams) : null,
        headers: mHeaderParams,
      );
      return returnResponse(response);
    } on SocketException catch (e) {
      throw NoInternetException(msg: "Not connected to Internet");
    } catch (e) {
      throw ServerException(msg: "with error ${e.toString()}");
    }
  }

  dynamic returnResponse(http.Response res) {
    switch (res.statusCode) {
      case 200:
        {
          return jsonDecode(res.body);
        }

      case 400:
        {
          throw BadRequestException(msg: "with status code ${res.statusCode}");
        }

      case 401:
        {
          throw UnauthorizedException(
            msg: "with status code ${res.statusCode}",
          );
        }

      case 404:
        {
          throw NotFoundException(msg: "with status code ${res.statusCode}");
        }

      case 500:
      default:
        {
          throw ServerException(msg: "with status code ${res.statusCode}");
        }
    }
  }
}
