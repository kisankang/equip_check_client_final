import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:equip_check_client/app/constant/server.dart';
import 'package:equip_check_client/app/data/api/app_rest_api.dart';
import 'package:equip_check_client/app/utils/converter.dart';
import 'package:equip_check_client/app/utils/log.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class AppAPI extends GetxService {
  late AppRestAPI client;
  final dio = Dio();

  @override
  void onInit() {
    dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final HttpClient client = HttpClient(context: SecurityContext(withTrustedRoots: true));
        client.badCertificateCallback = (cert, host, port) => true;
        return client;
      },
    );
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (
          RequestOptions options,
          RequestInterceptorHandler handler,
        ) async {
          options.headers['Content-Type'] = 'application/json; charset=utf-8';
          options.headers['Access-Key'] = getAccessKey();
          handler.next(options);
        },
        onResponse: (response, handler) {
          try {
            response.data = responseConverter(response.data);
          } catch (e) {
            logError(e, des: 'InterceptorsWrapper.onResponse.responseConverter');
            response.data = null;
          }
          handler.next(response);
        },
      ),
    );
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        request: false,
        requestBody: true,
      ),
    );
    client = AppRestAPI(dio, baseUrl: dotenv.env['PROD_BASE_URL']!);
    super.onInit();
  }
}
