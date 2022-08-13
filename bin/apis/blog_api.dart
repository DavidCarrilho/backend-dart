import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../models/news_model.dart';
import '../services/generic_service.dart';
import 'api.dart';

class BlogApi extends Api {
  final GenericService<NewsModel> _service;

  BlogApi(this._service);

  @override
  Handler getHandler({List<Middleware>? middilewares, bool isSecurity = false}) {
    Router router = Router();
    // Listagem
    router.get('/blog/noticias', (Request req) {
      List<NewsModel> news = _service.findAll();
      List mapNews = news.map((e) => e.toJson()).toList();
      return Response.ok(jsonEncode(mapNews));
    });
    // Nova noticia
    router.post('/blog/noticias', (Request req) async {
      // _service.save('');
      var body = await req.readAsString();
      _service.save(NewsModel.fromJson(body));
      return Response(201);
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
    return createHandler(
      router: router,
      isSecutiry: isSecurity,
      middilewares: middilewares,
    );
  }
}
