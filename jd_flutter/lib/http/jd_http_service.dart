import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import '../config/jd_http_url.dart';


//获取底部tabBar数据
Future getBottomTabBarContent() async {
  try {
    print('开始获取底部按钮数据....');
    Response response;
    Dio dio = new Dio();
    // dio.options.contentType = ContentType.parse('application/json;charset=UTF-8') ;
     (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
       client.badCertificateCallback = (cert, host, post) {
         return true;
       };
     };
     print(servicePath["bottomBar"]);
    response = await dio.post(servicePath['bottomBar'],);
    if(response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('接口出现异常');
    }

  } catch(e) {
    return print('ERROR!!!');
  }

}