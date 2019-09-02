import 'dart:io';

import 'request.dart';
import 'response.dart';
import 'router.dart';

class Dartis extends Router{
  dynamic core;
  bool enableLogger = false;
  bool enableCors = false;


  Future<void> listen(int port, [Function callback]) async {
    this.core = await HttpServer.bind(
      InternetAddress.loopbackIPv4,
      port,
    );

    callback(this.core);
    
    await for (HttpRequest request in this.core) {
      Response res = new Response(request.response);
      Request req =  new Request(request);
      this._logger(request);
      this._cors(request);
      this.handleRequest(req, res);
    }
  }

  void _logger(HttpRequest req){
    if (this.enableLogger) {
      print('${req.method} in ${req.uri.path} ${DateTime.now()} ');
    }
  }

  void _cors(HttpRequest req){
    if (this.enableCors) {
      req.response.headers.set("Access-Control-Allow-Origin", "*");
      req.response.headers.set("Access-Control-Allow-Methods", "POST,GET,DELETE,PUT,OPTIONS");
 
    }
  }
}