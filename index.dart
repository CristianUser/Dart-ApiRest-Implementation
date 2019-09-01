


import 'dart:convert';
import 'dart:io';

import 'controller/user.controller.dart';
import 'lib/router.dart';
import 'lib/response.dart';

Future main() async {
  var server = await HttpServer.bind(
    InternetAddress.loopbackIPv4,
    4040,
  );
  var router = new Router(server);
  UserController userController = new UserController();

  // router.Get('/', (request){
  //   request.response.write('Hello World!');
  // });

  router.Get('/greet', (request){
    request.response.write('Hello everbody');
  });

  router.Get('/greet/:name', (request, params){
    request.response.write('Hello ${params['name']}');
  });

  router.Get('/users', (request){
    request.response.write('[{name: "pedro"}]');
  });

  router.Get('/users/:name/greet/:msg', (HttpRequest request, dynamic params){
    request.response.write('${params['msg']} ${params['name']}');
  });

  router.Post('/user',(HttpRequest request) {
    Response response = new Response(request.response);
    return userController.createUser(request, response);
  });

  print('Listening on localhost:${server.port}');

  await for (var request in server) {
    router.handleRequest(request);
  }

}