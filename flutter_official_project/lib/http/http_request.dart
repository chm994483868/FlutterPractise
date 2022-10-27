// ignore_for_file: avoid_print

import 'dart:io';
// ignore: library_prefixes
import 'dart:convert' as Convert;
import 'package:http/http.dart' as http;

typedef RequestCallBack = void Function(Map data);

class HttpRequest {
  static requestGET(
      String authority, String unencodedPath, RequestCallBack callBack,
      [Map<String, String>? queryParameters]) async {
    try {
      var httpClient = HttpClient();
      var uri = Uri.http(authority, unencodedPath, queryParameters);
      var request = await httpClient.getUrl(uri);
      var response = await request.close();
      var responseBody = await response.transform(Convert.utf8.decoder).join();
      Map data = Convert.jsonDecode(responseBody);
      callBack(data);
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  // ignore: prefer_typing_uninitialized_variables
  final baseUrl;

  HttpRequest(this.baseUrl);

  Future<dynamic> get(String uri, {Map<String, String>? headers}) async {
    try {
      /// httpsUri = Uri(
      ///     scheme: 'https',
      ///     host: 'example.com',
      ///     path: '/page/',
      ///     queryParameters: {'search': 'blue', 'limit': '10'});
      /// print(httpsUri); // https://example.com/page/?search=blue&limit=10

      var tempUri = Uri(
          scheme: 'https',
          host: 'api.douban.com',
          path: '/v2/movie/top250',
          queryParameters: {
            'start': '15',
            'count': '4',
            'apikey': '0b2bdeda43b5688921839c8ecb20399b'
          });

      // http.Response response = await http.get(baseUrl + uri, headers: headers);
      http.Response response = await http.get(tempUri, headers: headers);
      final statusCode = response.statusCode;
      final body = response.body;
      print('🍎🍎🍎 [uri=$uri][statusCode=$statusCode][response=$body]');
      var result = Convert.jsonDecode(body);
      return result;
    } on Exception catch (e) {
      print('[uri=$uri]exception e=${e.toString()}');
      return '';
    }
  }

  Future<dynamic> getResponseBody(String uri,
      {Map<String, String>? headers}) async {
    try {
      http.Response response = await http.get(baseUrl + uri, headers: headers);
      final statusCode = response.statusCode;
      final body = response.body;
      print('[uri=$uri][statusCode=$statusCode][response=$body]');
      return body;
    } on Exception catch (e) {
      print('[uri=$uri]exception e=${e.toString()}');
      return null;
    }
  }

  Future<dynamic> post(String uri, dynamic body,
      {Map<String, String>? headers}) async {
    try {
      http.Response response =
          await http.post(baseUrl + uri, body: body, headers: headers);
      final statusCode = response.statusCode;
      final responseBody = response.body;
      var result = Convert.jsonDecode(responseBody);
      print('[uri=$uri][statusCode=$statusCode][response=$responseBody]');
      return result;
    } on Exception catch (e) {
      print('[uri=$uri]exception e=${e.toString()}');
      return '';
    }
  }
}
