import 'dart:convert';
import 'dart:io';

import '../lib/request.dart';
import '../lib/response.dart';

class UserController {
  List<Map> users = [];

  Future createUser(Request request, Response response) async {
    
    await response.statusCode(201).sendJson(await request.body);
  }
}