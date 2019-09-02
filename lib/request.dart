import 'dart:async';
import 'dart:convert';
import 'dart:io';
 
class Request{

  /// This property has the original request object [HttpRequest]
  /// from the core of Dart.
  HttpRequest httpRequest;
  dynamic params;


  Request(HttpRequest this.httpRequest) {}
  
  /// This property return the parsed body as a [Map].
  Future<Map> get body async {
    String content = await utf8.decoder.bind(this.httpRequest).join();
    Map body = jsonDecode(content);
    return body;
  }

  /// This property has the method of the request as [String].
  String get method => this.httpRequest.method;

  /// This property has the request uri [String].
  Uri get uri => this.httpRequest.uri;

  /// This property return the parsed query as a [Map].
  Map get query => this.httpRequest.uri.queryParameters;
}