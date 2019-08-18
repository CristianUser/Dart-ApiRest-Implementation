


import 'dart:io';
import 'router.dart';

dynamic resolveParams(String path)
{
  var route = '/user'.split('/');
  var splited = path.split('/');
  print(splited.toString() == route.toString());
  if( splited.toString() == route.toString()){
    return {
      'status': 200
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

Future main() async {
  // print(resolveParams('/user/sdfs'));
  var server = await HttpServer.bind(
    InternetAddress.loopbackIPv4,
    4040,
  );
  var router = new Router(server);

  router.Get('/greet', (request){
    request.response.write('Hello everbody');
  });

  router.Get('/greet/:name', (request, params){
    request.response.write('Hello ${params['name']}');
  });

  router.Get('/users', (request){
    request.response.write('[{name: "pedro"}]');
  });

  router.Get('/users/:name/greet/:msg', (request, params){
    request.response.write('${params['msg']} ${params['name']}');
  });

  print('Listening on localhost:${server.port}');

  await for (var request in server) {
    router.handleRequest(request);
  }

}