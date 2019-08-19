import 'dart:io';

class Router {
  HttpServer server;
  List<Map> _getEndpoints = [];
  List<Map> _postEndpoints = [];
  List<Map> _putEndpoints = [];
  List<Map> _deleteEndpoints = [];
  

  Router(HttpServer server) {
    this.server = server;
  }

  Future handleRequest(HttpRequest request) async {
  try {
    switch(request.method){
      case 'GET':
        var endpoint = await this._getEndpoints.where((e) => this._resolveParams(e['path'], request.uri.path)['status'] == 200).toList()[0];
        var params = _resolveParams(endpoint['path'], request.uri.path);
        if(params['params'].length>0){
          await endpoint['callback'](request, params['params']);
        } else {
          await endpoint['callback'](request);
        }
        await request.response.close();
      break;

      case 'DELETE':
        var endpoint = await this._deleteEndpoints.where((e) => this._resolveParams(e['path'], request.uri.path)['status'] == 200).toList()[0];
        var params = _resolveParams(endpoint['path'], request.uri.path);
        if(params['params'].length>0){
          await endpoint['callback'](request, params['params']);
        } else {
          await endpoint['callback'](request);
        }
        await request.response.close();
      break;

      case 'PUT':
        var endpoint = await this._putEndpoints.where((e) => this._resolveParams(e['path'], request.uri.path)['status'] == 200).toList()[0];
        var params = _resolveParams(endpoint['path'], request.uri.path);
        if(params['params'].length>0){
          await endpoint['callback'](request, params['params']);
        } else {
          await endpoint['callback'](request);
        }
        await request.response.close();
      break;

      case 'POST':
        var endpoint = await this._postEndpoints.where((e) => this._resolveParams(e['path'], request.uri.path)['status'] == 200).toList()[0];
        var params = _resolveParams(endpoint['path'], request.uri.path);
        if(params['params'].length>0){
          await endpoint['callback'](request, params['params']);
        } else {
          await endpoint['callback'](request);
        }
        await request.response.close();
      break;
    }
  } catch (e) {
    // print('Exception in handleRequest: $e');
    request.response.statusCode = 404;
    await request.response.write('Not Found');
    await request.response.close();
  }
  // print('Request handled.');
}

  /// This method is for register a post endpoint
  void Post(String path, Function callback) {
    this._postEndpoints.add({
      'method': 'POST',
      'path': path,
      'callback': callback
    });
  }

  void Get(String path, Function callback ){
    this._getEndpoints.add({
      'method': 'GET',
      'path': path,
      'callback': callback
    });
  }

    void Put(String path, Function callback ){
    this._putEndpoints.add({
      'method': 'PUT',
      'path': path,
      'callback': callback
    });
  }

  void Delete(String path, Function callback ){
    this._deleteEndpoints.add({
      'method': 'DELETE',
      'path': path,
      'callback': callback
    });
  }

  dynamic _resolveParams(String path, String uri)
  {
    var route = path.split('/');
    var splited = uri.split('/');
    if( splited.toString() == route.toString()){
      return {
        'status': 200,
        'params':{}
      };
    } else if(splited.length == route.length){
      var params = new Map();
      for (int i = 0;i<route.length;i++)
      {
        if(route[i] != splited[i]){
          if(route[i][0] == ':'){
            params[route[i].substring(1)] = splited[i];
          } else {
            return {
              'status': 404
            };
          }
        }
      }
      return {
        'status': 200,
        'params': params
      };
    }else {
      return {
        'status': 404
      };
    }
  }
}