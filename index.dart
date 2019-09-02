


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
  router.Get('/', (request){
    request.response.write('Hello World!');
  });

  router.Get('/greet', (request, response){
    response.write('Hello everbody');
  });

  router.Get('/greet/:name', (request, response){
    response.write('Hello ${request.params['name']}');
  });

  var server = new Dartis();

  server.use(router: router);

  server.listen(4040, (core) {
    print('Listening on localhost:${core.port}');
  });

}