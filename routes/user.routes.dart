
import 'dart:io';

import '../lib/request.dart';

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
    router.Get('/all', (Request request, Response response){
      response.write('[{name: "pedro"}]');
    });

    router.Get('/all/:name/greet/:msg', (Request request, Response response){
      response.write('${request.params['msg']} ${request.params['name']}');
    });

    router.Post('/create',(Request request, Response response) {
      return _userController.createUser(request, response);
    });
  }
}
