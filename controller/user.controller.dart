import 'dart:convert';
import 'dart:io';

import '../lib/request.dart';
import '../lib/response.dart';

class UserController {
  List<Map> users = [];

  Future createUser(HttpRequest request, Response response) async {
    
    Request req = await new Request(request);
    await response.statusCode(201).json(await req.body);
  }
}