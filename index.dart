import 'lib/server.dart';
import 'routes/index.routes.dart';


Future main() async {
  var indexRouter = new IndexRouter();
  Dartis server = new Dartis();

  server.enableLogger = true;
  
  server.listen(4040, (core) {
    print('Listening on localhost:${core.port}');
  });

  server.use(router: indexRouter.router);
}