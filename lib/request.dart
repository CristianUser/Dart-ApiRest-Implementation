import 'dart:async';
import 'dart:convert';
import 'dart:io';
 
class Request{
  HttpRequest httpRequest;


  Request(HttpRequest this.httpRequest) {}

  Future<Map> get body async {
    String content = await utf8.decoder.bind(this.httpRequest).join();
    Map body = jsonDecode(content);
    return body;
  }  

  // Map get body {
  //   Map body;
  //   this._decode().then( (val){ 
  //     body = val;
  //   });
  //   return body;
  //   }

}