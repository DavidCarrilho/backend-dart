import '../../apis/blog_api.dart';
import '../../apis/login_api.dart';
import '../../models/news_model.dart';
import '../../services/generic_service.dart';
import '../../services/news_service.dart';
import '../database/db_configuration.dart';
import '../database/mysql_db_configuration.dart';
import '../security/security_service.dart';
import '../security/security_service_impl.dart';
import 'dependency_injector.dart';

class Injects {
  static DependencyInjector initialize() {
    final di = DependencyInjector();
    di.register<DBConfiguration>(() => MySqlDBConfiguration());
    di.register<SecurityService>(() => SecurityServiceImpl());
    di.register<LoginApi>(() => LoginApi(di()));
    di.register<GenericService<NewsModel>>(() => NewsService());
    di.register<BlogApi>(() => BlogApi(di()));
    return di;
  }
}
