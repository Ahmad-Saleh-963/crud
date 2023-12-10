


import 'package:dio/dio.dart';

import '../../data/data_server/sqlDb.dart';

class AppData{

  static String baseUrl = "https://crudcrud.com/api/b7065dfe79bc46b19ced61c6b7a4459f/";
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