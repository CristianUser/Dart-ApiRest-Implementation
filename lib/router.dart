import 'dart:io';

import 'response.dart';
import 'request.dart';
import 'route.dart';

class Router {

  List<Route> _getEndpoints = [];
  List<Route> _postEndpoints = [];
  List<Route> _putEndpoints = [];
  List<Route> _deleteEndpoints = [];
  

  List<Route> get getEndpoints => this._getEndpoints;
  List<Route> get postEndpoints => this._postEndpoints;
  List<Route> get putEndpoints => this._putEndpoints;
  List<Route> get deleteEndpoints => this._deleteEndpoints;

  Router() {}

  Future handleRequest(Request request, Response response) async {
  try {
    switch(request.method){

      case 'GET':
        if (! await this._findEndpoint(request, response, this._getEndpoints)) {
          this._notFound(request, response);
        }
      break;

      case 'POST':
        if (! await this._findEndpoint(request, response, this._postEndpoints)) {
          this._notFound(request, response);
        }
      break;

      case 'DELETE':
        var endpoint = await this._deleteEndpoints.where((e) => this._resolveParams(e.path, request.uri.path)['status'] == 200).toList()[0];
        var params = _resolveParams(endpoint.path, request.uri.path);
        if(params['params'].length>0){
          await endpoint.callback(request, response, params['params']);
        } else {
          await endpoint.callback(request, response);
        }
        await request.httpRequest.response.close();
      break;

      case 'PUT':
        var endpoint = await this._putEndpoints.where((e) => this._resolveParams(e.path, request.uri.path)['status'] == 200).toList()[0];
        var params = _resolveParams(endpoint.path, request.uri.path);
        if(params['params'].length>0){
          await endpoint.callback(request, response, params['params']);
        } else {
          await endpoint.callback(request, response);
        }
        await request.httpRequest.response.close();
      break;

    }
  } catch (e) {
    print('Exception in handleRequest: $e');
    await response.statusCode(404).write('Not Found');
    await request.httpRequest.response.close();
  }
  // print('Request handled.');
}

  /// This method is for register a post endpoint
  void Post(String path, Function callback) {
    this._postEndpoints.add(new Route(
      method: 'POST',
      path: path,
      callback: callback
    ));
  }

  void Get(String path, Function callback ){
    this._getEndpoints.add(new Route(
      method: 'GET',
      path: path,
      callback: callback
    ));
  }

    void Put(String path, Function callback ){
    this._putEndpoints.add(new Route(
      method: 'PUT',
      path: path,
      callback: callback
    ));
  }

  void Delete(String path, Function callback ){
    this._deleteEndpoints.add(new Route(
      method: 'DELETE',
      path: path,
      callback: callback
    ));
  }

  Future use({String path = '', Router router}) async {
    for(Route endpoint in router.getEndpoints){
      this.Get(path + endpoint.path, endpoint.callback);
    }

    for(Route endpoint in router.postEndpoints){
      this.Post(path + endpoint.path, endpoint.callback);
    }
    
    for(Route endpoint in router.putEndpoints){
      this.Put(path + endpoint.path, endpoint.callback);
    }

    for(Route endpoint in router.deleteEndpoints){
      this.Delete(path + endpoint.path, endpoint.callback);
    }
  }

  // Private Methods
  void _notFound(Request request, Response response) async {
    response.statusCode(404).render('<h2>Not Found</h2><p>Can\'t ${request.method} in uri <b>${request.uri.path}</b></p>');
    await request.httpRequest.response.close();
  }

  Future<bool> _findEndpoint(Request request, Response response, List<Route> endpoints) async {
    bool found = false;
    for (var endpoint in endpoints) {
      var params = _resolveParams(endpoint.path, request.uri.path);
      if(params['status'] == 200){
        found = true;
        if(params['params'].length > 0){
          request.params = params['params'];
          await endpoint.callback(request, response);
        } else {
          await endpoint.callback(request, response);
        }
        await request.httpRequest.response.close();
        break;
      }
    }
    return found;
  }

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