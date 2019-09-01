import 'dart:convert';
import 'dart:io';

class Response {
  HttpResponse httpResponse;

  Response(this.httpResponse){
  }

  /// ## Description
  /// This method set the status code for the response
  /// ### Example
  /// response.statusCode(200)

  Response statusCode(int code) {
    this.httpResponse.statusCode = code;
    return this;
  }

  Future json(dynamic input) async {
    this.httpResponse.headers.contentType = ContentType.json;
    return this.httpResponse.write(jsonEncode(input));
  }
 
}