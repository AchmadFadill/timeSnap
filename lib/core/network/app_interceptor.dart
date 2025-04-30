import 'dart:io';

import 'package:dio/dio.dart';
import 'package:timesnap/core/constant/constant.dart';
import 'package:timesnap/core/helper/shared_preferences_helper.dart';

class AppInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers['accept'] = 'application/json';
    final authToken = await SharedPreferencesHelper.getString(PREF_AUTH);
    if (authToken?.isnotEmpty ?? false) {
      options.headers['Authorization'] = authToken;
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if(response.statusCode != HttpStatus.ok){
      return handler.resolve(Response(
        data: response.data, requestOptions: response.requestOptions));
    }
    super.onResponse(response, handler);
  }
}