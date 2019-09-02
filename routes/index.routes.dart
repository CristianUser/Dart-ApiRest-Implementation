
import 'dart:io';
import '../lib/request.dart';

import '../lib/response.dart';
import '../lib/router.dart';
import 'user.routes.dart';

class IndexRouter {
  Router router = new Router();
  UserRouter userRouter = new UserRouter();


  IndexRouter(){
    this.config();
  }

  void config() async {
    router.use(path: '/user', router: userRouter.router);

    router.Get('/', (Request request, Response response) async {
      var file = new File('./view/index.html');
      response.render(await file.readAsString());
    });

    router.Get('/greet', (Request request, Response response){
      response.write('Hello everbody');
    });

    router.Get('/greet/:name', (Request request, Response response){
      response.write('Hello ${request.params['name']}');
    });
  }
}
