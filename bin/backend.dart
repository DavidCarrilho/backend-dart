import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

import 'api/blog_api.dart';
import 'api/login_api.dart';
import 'infra/custom_server.dart';
import 'server_handler.dart';

void main() async {
  // var _server = CustomServerHandler();
  // final server = await shelf_io.serve(_server.handler, "localhost", 8080);
  // print('Nosso servidor foi iniciado http:localhost:8080');

  var cascadeHandler = Cascade()
  .add(LoginApi().handler)
  .add(BlogApi().handler)
  .handler;

  await CustomServer().initialize(cascadeHandler);
}
