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
  /// return [Response] 
  Response statusCode(int code) {
    this.httpResponse.statusCode = code;
    return this;
  }

  /// ## Description
  /// This method set the content type for the response
  /// ### Example
  /// response.contentType(200)
  /// return [Response]
  Response content(ContentType contentType) {
    this.httpResponse.headers.contentType = contentType;
    return this;
  }

  Response json() {
    this.httpResponse.headers.contentType = ContentType.json;
    return this;
  }

  Response html() {
    this.httpResponse.headers.contentType = ContentType.html;
    return this;
  }

  Future sendJson(dynamic input) async {
    this.httpResponse.headers.contentType = ContentType.json;
    return this.httpResponse.write(jsonEncode(input));
  }

  Future render(dynamic input) async {
    this.httpResponse.headers.contentType = ContentType.html;
    return this.httpResponse.write(input);
  }

  Future write(dynamic input) async {
    return this.httpResponse.write(input);
  }
 
}