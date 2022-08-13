import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

import 'apis/blog_api.dart';
import 'apis/login_api.dart';
import 'infra/custom_server.dart';
import 'infra/dependency_injector/dependency_injector.dart';
import 'infra/middleware_interception.dart';
import 'infra/security/security_service.dart';
import 'infra/security/security_service_impl.dart';
import 'services/news_service.dart';
import 'utils/custom_env.dart';

void main() async {
  // var _server = CustomServerHandler();
  // final server = await shelf_io.serve(_server.handler, "localhost", 8080);
  // print('Nosso servidor foi iniciado http:localhost:8080');

  // usar o kdebug
  CustomEnv.fromFile('.env-dev');

  final _di = DependencyInjector();
  _di.register<SecurityService>(() => SecurityServiceImpl(), isSingleton: true);
  var _securityService = _di.get<SecurityService>();

  var cascadeHandler = Cascade()
      .add(LoginApi(_securityService).getHandler())
      .add(BlogApi(NewsService()).getHandler())
      .handler;

  var handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(MiddlewareIntercption().middleware)
      .addHandler(cascadeHandler);

  await CustomServer().initialize(
    handler: handler,
    address: await CustomEnv.get<String>(key: 'server_address'),
    port: await CustomEnv.get<int>(key: 'server_port'),
  );
}
