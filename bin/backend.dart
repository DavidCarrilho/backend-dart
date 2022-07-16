import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

import 'apis/blog_api.dart';
import 'apis/login_api.dart';
import 'infra/custom_server.dart';
import 'infra/middleware_interception.dart';
import 'infra/security/security_service_impl.dart';
import 'services/news_service.dart';
import 'utils/custom_env.dart';

void main() async {
  // var _server = CustomServerHandler();
  // final server = await shelf_io.serve(_server.handler, "localhost", 8080);
  // print('Nosso servidor foi iniciado http:localhost:8080');
  
  // usar o kdebug 
  CustomEnv.fromFile('.env-dev');

  var cascadeHandler = Cascade()
    .add(LoginApi(SecurityServiceImpl()).handler)
    .add(BlogApi(NewsService()).handler).handler;

  var handler = Pipeline()
    .addMiddleware(logRequests())
    .addMiddleware(MiddlewareIntercption().middleware)
    .addMiddleware(SecurityServiceImpl().authorization)
    .addHandler(cascadeHandler);


  await CustomServer().initialize(
    handler: handler,
    address: await CustomEnv.get<String>(key: 'server_address'),
    port: await CustomEnv.get<int>(key: 'server_port'),
  );
}
