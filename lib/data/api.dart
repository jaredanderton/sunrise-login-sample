import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

class Api {

  Future<Response> post(String url, Map<String, dynamic> data) async {

    // this should probably refactored and moved out of here, so we dont have to
    // create a new instance and take these steps every request. There should
    // probably be one of these for the entire app
    bool usingCharles = false;
    Dio dio = Dio();
    if(usingCharles) {
      dio.httpClientAdapter = DefaultHttpClientAdapter();
      // https://github.com/flutterchina/dio#set-proxy-and-httpclient-config
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {

        client.badCertificateCallback = (X509Certificate cert, String host, int port) {
          return Platform.isAndroid;
        };

        String address = Platform.isIOS ? "localhost:8888" : "10.0.2.2:8888";

        client.findProxy = (uri) {
          return "PROXY " + address;
        };
      };
    }
    dio.interceptors.add(
        InterceptorsWrapper(
            onRequest: (RequestOptions options) {
              options.headers['content-type'] = 'application/json';
            }
        )
    );
    // end refactor
    try {
      return await dio.post(url, data: data);
    } catch(e) {
      print(e);
      return null;
    }

  }
}