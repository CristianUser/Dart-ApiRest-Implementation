import 'dart:async';
import 'dart:convert';
import 'dart:io';
 
class Request{
  HttpRequest httpRequest;
  dynamic params;


  Request(HttpRequest this.httpRequest) {}

  Future<Map> get body async {
    String content = await utf8.decoder.bind(this.httpRequest).join();
    Map body = jsonDecode(content);
    return body;
  }

  String get method => this.httpRequest.method;
  Uri get uri => this.httpRequest.uri;
}