import 'dart:convert';
import 'dart:io';

class UserController {
  List<Map> users = [];

  Future createUser(HttpRequest request) async {
    HttpResponse response = request.response;
    request.response.headers.contentType = ContentType.json;
    String content = await utf8.decoder.bind(request).join();
    await request.response.write(content);
    // await this.users.add(jsonDecode(request.))
  }
}