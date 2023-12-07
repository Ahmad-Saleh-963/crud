


import 'package:dio/dio.dart';

import '../../data/data_server/sqlDb.dart';

class AppData{

  static String baseUrl = "https://crudcrud.com/api/27553dc365a94c01be5bc4ebb8006061/";
  static late Dio dio;

  static SqlLite db = SqlLite();
  static initDio(){
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 8),
      receiveTimeout: const Duration(seconds: 8),
    );
    dio = Dio(options);
  }


}