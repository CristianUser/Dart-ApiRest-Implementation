import '../lib/request.dart';
import '../lib/response.dart';

class UserController {
  List<Map> users = [];

  Future createUser(Request request, Response response) async {
    var user = await request.body;
    this.users.add(user);
    await response.statusCode(201).sendJson(user);
  }

  Future getAll(Request request, Response response) async {
    await response.sendJson(this.users);
  }

  Future getOne(Request request, Response response) async {
    var user = await this.users.where((val)=> val['name']== request.params['name']).toList();
    await response.sendJson(user);
  }
}