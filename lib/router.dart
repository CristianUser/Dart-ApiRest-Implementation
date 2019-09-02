import 'dart:io';

import 'route.dart';

class Router {

  List<Route> _getEndpoints = [];
  List<Map> _postEndpoints = [];
  List<Map> _putEndpoints = [];
  List<Map> _deleteEndpoints = [];
  

  List<Route> get getEndpoints => this._getEndpoints;
  List<Map> get postEndpoints => this._postEndpoints;

  Router() {
  }

  Future handleRequest(HttpRequest request) async {
  try {
    switch(request.method){

      case 'GET':
        for (var endpoint in this._getEndpoints) {
          var params = _resolveParams(endpoint.path, request.uri.path);
          if(params['status'] == 200){
            if(params['params'].length > 0){
              await endpoint.callback(request, params['params']);
            } else {
              await endpoint.callback(request);
            }
            await request.response.close();
            break;
          }
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
    print('Exception in handleRequest: $e');
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
    this._getEndpoints.add(new Route(
      method: 'GET',
      path: path,
      callback: callback
    ));
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

  Future use({String path = '', Router router}) async {
    for(Route endpoint in router.getEndpoints){
      this.Get(path + endpoint.path, endpoint.callback);
    }
    // await this._postEndpoints.addAll(router._postEndpoints);
  }

  // Private Methods

  dynamic _resolveParams(String path, String uri)
  {
    var route = path.split('/');
    var splited = uri.split('/');
  // print(splited.toString() == route.toString());

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