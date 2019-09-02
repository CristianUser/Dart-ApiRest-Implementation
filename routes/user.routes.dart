
import 'dart:io';

import '../lib/response.dart';
import '../lib/router.dart';
import '../controller/user.controller.dart';

class UserRouter {
  Router router = new Router();
  UserController _userController = new UserController();

  UserRouter(){
    this.config();
  }

  void config() {
    router.Get('/all', (request){
      request.response.write('[{name: "pedro"}]');
    });

    router.Get('/all/:name/greet/:msg', (HttpRequest request, dynamic params){
      request.response.write('${params['msg']} ${params['name']}');
    });

    router.Post('/create',(HttpRequest request) {
      Response response = new Response(request.response);
      return _userController.createUser(request, response);
    });
  }
}
