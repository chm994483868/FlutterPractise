// ignore_for_file: library_prefixes, prefer_typing_uninitialized_variables, depend_on_referenced_packages

import 'dart:async';
import 'dart:convert' as Convert;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

typedef RequestCallBack = void Function(Map data);

class HttpRequest {
  static requestGET(String authority, String unencodedPath, RequestCallBack callBack, [Map<String, String>? queryParameters]) async {
    try {
      var httpClient = HttpClient();
      // http://api.douban.com/v2/movie/top250?start=25&count=10
      var uri = Uri.http(authority, unencodedPath, queryParameters);
      var request = await httpClient.getUrl(uri);
      var response = await request.close();
      var responseBody = await response.transform(Convert.utf8.decoder).join();
      Map data = Convert.jsonDecode(responseBody);
      callBack(data);
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  final baseUrl;

  HttpRequest(this.baseUrl);

  Future<dynamic> get(String uri, {Map<String, String>? headers}) async {
    try {
      final tempURLString = baseUrl + uri;
      final tempUri = Uri.parse(tempURLString);
      http.Response response = await http.get(tempUri, headers: headers);
      final statusCode = response.statusCode;
      final body = response.body;
      debugPrint('[uri=$uri][statusCode=$statusCode][response=$body]');
      var result = Convert.jsonDecode(body);
      return result;
    } on Exception catch (e) {
      debugPrint('[uri=$uri]exception e=${e.toString()}');
      return '';
    }
  }

  Future<dynamic> getResponseBody(String uri, {Map<String, String>? headers}) async {
    try {
      http.Response response = await http.get(baseUrl + uri, headers: headers);
      final statusCode = response.statusCode;
      final body = response.body;
//      var result = Convert.jsonDecode(body);
      debugPrint('[uri=$uri][statusCode=$statusCode][response=$body]');
      return body;
    } on Exception catch (e) {
      debugPrint('[uri=$uri]exception e=${e.toString()}');
      return null;
    }
  }

  Future<dynamic> post(String uri, dynamic body, {Map<String, String>? headers}) async {
    try {
      http.Response response = await http.post(baseUrl + uri, body: body, headers: headers);
      final statusCode = response.statusCode;
      final responseBody = response.body;
      var result = Convert.jsonDecode(responseBody);
      debugPrint('[uri=$uri][statusCode=$statusCode][response=$responseBody]');
      return result;
    } on Exception catch (e) {
      debugPrint('[uri=$uri]exception e=${e.toString()}');
      return '';
    }
  }
}
