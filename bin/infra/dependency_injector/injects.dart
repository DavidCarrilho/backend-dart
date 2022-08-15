import '../../apis/blog_api.dart';
import '../../apis/login_api.dart';
import '../../models/news_model.dart';
import '../../services/generic_service.dart';
import '../../services/news_service.dart';
import '../security/security_service.dart';
import '../security/security_service_impl.dart';
import 'dependency_injector.dart';

class Injects {
  static DependencyInjector initializer() {
    final di = DependencyInjector();
    di.register<SecurityService>(() => SecurityServiceImpl());
    di.register<LoginApi>(() => LoginApi(di()));
    di.register<GenericService<NewsModel>>(() => NewsService());
    di.register<BlogApi>(() => BlogApi(di()));
    return di;
  }
}
