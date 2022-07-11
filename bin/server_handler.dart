import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class CustomServerHandler {
  Handler get handler {
    final router = Router();
    router.get('/', (Request request) {
      return Response(200, body: 'Primeira Rota');
    });

    // http://localhost/ola/mundo
    //ola mundo
    router.get('/ola/mundo/<usuario >', (Request req, String usuario) {
      return Response.ok("Ola Mundo $usuario");
    });

    //http://localhost:8080/query?nome=David$idade=30
    router.get('/query', (Request req) {
      String? nome = req.url.queryParameters['nome'];
      String? idade = req.url.queryParameters['nome'];
      return Response.ok('Quer é: $nome, $idade');
    });

    return router;
  }
}
