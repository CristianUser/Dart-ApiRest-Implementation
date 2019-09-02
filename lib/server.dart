import 'dart:io';

import 'router.dart';

class Dartis extends Router{
  dynamic core;

  Future<void> listen(int port, [Function callback]) async {
    this.core = await HttpServer.bind(
      InternetAddress.loopbackIPv4,
      port,
    );
    print('Listening on localhost:${this.core.port}');
    await for (var request in this.core) {
      this.handleRequest(request);
    }
  }
}