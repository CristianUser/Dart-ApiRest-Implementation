import 'dart:io';

class Router {
  HttpServer server;
  List<Map> getEndpoints = [];
  List<Map> postEndpoints = [];
  List<Map> putEndpoints = [];
  List<Map> deleteEndpoints = [];
  

  Router(HttpServer server) {
    this.server = server;
  }

  Future handleRequest(HttpRequest request) async {
  try {
    switch(request.method){
      case 'GET':
        var endpoint = await this.getEndpoints.where((e) => this.resolveParams(e['path'], request.uri.path)['status'] == 200).toList()[0];
        var params = resolveParams(endpoint['path'], request.uri.path);
        if(params['params'].length>0){
          await endpoint['callback'](request, params['params']);
        } else {
          await endpoint['callback'](request);
        }
        await request.response.close();
      break;

      case 'DELETE':
        await this.deleteEndpoints.where((e) => e['path'] == request.uri.path).toList()[0]['callback'](request);
        await request.response.close();
      break;

      case 'PUT':
        await this.putEndpoints.where((e) => e['path'] == request.uri.path).toList()[0]['callback'](request);
        await request.response.close();
      break;

      case 'POST':
        await this.postEndpoints.where((e) => e['path'] == request.uri.path).toList()[0]['callback'](request);
        await request.response.close();
      break;
    }
  } catch (e) {
    // print('Exception in handleRequest: $e');
    await request.response.write('Not Found');
    await request.response.close();
  }
  // print('Request handled.');
}

  void Post(String path, Function callback) {
    this.postEndpoints.add({
      'method': 'POST',
      'path': path,
      'callback': callback
    });
  }

  void Get(String path, Function callback ){
    this.getEndpoints.add({
      'method': 'GET',
      'path': path,
      'callback': callback
    });
  }

  dynamic resolveParams(String path, String uri)
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