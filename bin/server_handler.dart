import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class CustomServerHandler {
  Handler get handler {
    final router = Router();
    router.get('/', (Request request) {
      return Response(200, body: 'Primeira Rota');
    });
    return router;
  }
}
