import 'dart:io';

import 'request.dart';
import 'response.dart';
import 'router.dart';

class Dartis extends Router{
  dynamic core;

  Future<void> listen(int port, [Function callback]) async {
    this.core = await HttpServer.bind(
      InternetAddress.loopbackIPv4,
      port,
    );

    callback(this.core);
    
    await for (var request in this.core) {
      Response response = new Response(request.response);
      Request req =  new Request(request);

      this.handleRequest(req, response);
    }
  }
}