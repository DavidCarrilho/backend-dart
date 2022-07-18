import 'package:shelf/shelf.dart';

abstract class Api {
  Handler getHandler({List<Middleware>? middilewares});

  Handler createHandler({
    required Handler router,
    List<Middleware>? middilewares,
  }) {
    middilewares ??= [];
    var pipeline = Pipeline();

    middilewares.forEach((m) => pipeline = pipeline.addMiddleware(m));

    return pipeline.addHandler(router);
  }
}
