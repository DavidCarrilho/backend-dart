import 'package:shelf/shelf.dart';

import '../infra/dependency_injector/dependency_injector.dart';
import '../infra/security/security_service.dart';

abstract class Api {
  Handler getHandler({List<Middleware>? middilewares, bool isSecurity = false});

  Handler createHandler({
    required Handler router,
    List<Middleware>? middilewares,
    bool isSecutiry = false,
  }) {
    middilewares ??= [];
    if (isSecutiry) {
      var _securityService = DependencyInjector().get<SecurityService>();
      middilewares.addAll([
        _securityService.authorization,
        _securityService.verifyJwt,
      ]);
    }
    var pipeline = Pipeline();

    middilewares.forEach((mid) => pipeline = pipeline.addMiddleware(mid));

    return pipeline.addHandler(router);
  }
}
