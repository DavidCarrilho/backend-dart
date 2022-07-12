import 'dart:convert';

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

    // router post('/login', (Request req)){
    //   //se usuer = admin e pass == 123
    //   return Response.ok('Bem vindo Admin!');
    // }
    router.post('/login', (Request req) async {
      //se usuer = admin e pass == 123
      var result = await req.readAsString();
      Map json = jsonDecode(result); //
      var usuario = json['usuario'];
      var senha = json['senha'];
      if (usuario == 'admin' && senha == '123') {
        return Response.ok('Bem vindo $usuario');
      } else {
        return Response.forbidden('Acesso Negado');
      }
    });

    return router;
  }
}
