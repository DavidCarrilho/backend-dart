import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../services/generic_service.dart';

class BlogApi {
  final GenericService _service;

  BlogApi(this._service);

  Handler get handler {
    Router router = Router();
    // Listagem
    router.get('/blog/noticias', (Request req) {
      // _service.findAll();
      return Response.ok('Choveu hoje');
    });
    // Nova noticia
    router.post('/blog/noticias', (Request req) {
      // _service.save('');
      return Response.ok('Choveu hoje');
    });
    // Uma atualizacao / ex: /blog/noticias?id=1
    router.put('/blog/noticias', (Request req) {
      String? id = req.url.queryParameters['id'];
      // _service.save('');
      return Response.ok('Choveu hoje');
    });
    // Uma exclusao / ex: /blog/noticias?id=1
    router.delete('/blog/noticias', (Request req) {
      String? id = req.url.queryParameters['id'];
      // _service.delete(id);
      return Response.ok('Choveu hoje');
    });
    return router;
  }
}
