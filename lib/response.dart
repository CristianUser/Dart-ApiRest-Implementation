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

  /// ### Description
  /// Gets and sets the content type. 
  /// Note that the content type in the header will only be updated if this field is set directly. 
  /// Mutating the returned current value will have no effect.
  /// #### Example
  /// response.contentType(200)
  /// return [Response]
  Response content(ContentType contentType) {
    this.httpResponse.headers.contentType = contentType;
    return this;
  }
  
  /// ### Description
  /// Set the header [ContentType] as json
  /// #### Example
  /// response.json().write('{"name": "John Doe"}')
  Response json() {
    this.httpResponse.headers.contentType = ContentType.json;
    return this;
  }

  /// ### Description
  /// Set the header [ContentType] as html
  /// #### Example
  /// response.html().write('<h1>Hello World</h1>')
  Response html() {
    this.httpResponse.headers.contentType = ContentType.html;
    return this;
  }

  Future sendJson(dynamic input) async {
    this.httpResponse.headers.contentType = ContentType.json;
    return this.httpResponse.write(jsonEncode(input));
  }

  /// ### Description
  /// Write HTML in the response and set the header [ContentType] as html
  /// #### Example
  /// response.render('<h1>Hello World</h1>')
  Future render(dynamic input) async {
    this.httpResponse.headers.contentType = ContentType.html;
    return this.httpResponse.write(input);
  }

  /// ### Description
  /// Write text in the response
  /// #### Example
  /// response.write('Hello World')
  Future write(dynamic input) async {
    return this.httpResponse.write(input);
  }
 
}