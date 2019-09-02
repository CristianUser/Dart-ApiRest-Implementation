
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
    router.Get('/all', _userController.getAll);

    router.Get('/:name', _userController.getOne);

    router.Post('/create', _userController.createUser);
  }
}
