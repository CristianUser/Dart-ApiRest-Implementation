


import 'dart:convert';
import 'dart:io';


import 'lib/router.dart';
import 'lib/response.dart';
import 'lib/server.dart';
import 'routes/user.routes.dart';


Future main() async {

  var router = new Router();
  var userRouter = new UserRouter();

  await router.use(path: '/user', router: userRouter.router);
  // router.Get('/', (request){
  //   request.response.write('Hello World!');
  // });

  router.Get('/greet', (request){
    request.response.write('Hello everbody');
  });

  router.Get('/greet/:name', (request, params){
    request.response.write('Hello ${params['name']}');
  });

  var server = new Dartis();
  server.use(router: router);
  server.listen(4040);

  // var server = await HttpServer.bind(
  //   InternetAddress.loopbackIPv4,
  //   4040,
  // );

  // print('Listening on localhost:${server.port}');
  // await for (var request in server) {
  //   router.handleRequest(request);
  // }

}