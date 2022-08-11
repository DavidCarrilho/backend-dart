import 'package:shelf/shelf.dart';

import '../infra/dependency_injector/dependency_injector.dart';
import '../infra/security/security_service.dart';

abstract class Api {
  Handler getHandler({List<Middleware>? middilewares});

  Handler createHandler({
    required Handler router,
    List<Middleware>? middilewares,
  }) {
    final _di = DependencyInjector();
    var _securityService = _di.get<SecurityService>();
    middilewares ??= [];
    var pipeline = Pipeline();

    middilewares.forEach((mid) => pipeline = pipeline.addMiddleware(mid));

    return pipeline.addHandler(router);
  }
}
