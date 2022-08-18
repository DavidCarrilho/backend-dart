import 'package:mysql1/mysql1.dart';
import 'package:shelf/shelf.dart';

import 'apis/blog_api.dart';
import 'apis/login_api.dart';
import 'infra/custom_server.dart';
import 'infra/dependency_injector/injects.dart';
import 'infra/middleware_interception.dart';
import 'utils/custom_env.dart';

void main() async {
  // var _server = CustomServerHandler();
  // final server = await shelf_io.serve(_server.handler, "localhost", 8080);
  // print('Nosso servidor foi iniciado http:localhost:8080');

  // usar o kdebug
  CustomEnv.fromFile('.env-dev');

  var connection = await MySqlConnection.connect(ConnectionSettings(
    host: await CustomEnv.get<String>(key: 'DB_HOST'),
    port: await CustomEnv.get<int>(key: 'DB_PORT'),
    user: await CustomEnv.get<String>(key: 'DB_USER'),
    password: await CustomEnv.get<String>(key: 'DB_PASSWORD'),
    db: await CustomEnv.get<String>(key: 'DB_SCHEMA'),
  ));
  var result = await connection.query('SELECT name, email FROM users;');
  print(result.toString());

  final _di = Injects.initializer();

  var cascadeHandler = Cascade()
      .add(_di.get<LoginApi>().getHandler())
      .add(_di.get<BlogApi>().getHandler(isSecurity: true))
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
