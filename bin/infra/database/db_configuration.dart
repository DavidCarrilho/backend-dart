/// Classe de configuração do banco de dados.
abstract class DBConfiguration{
  /// Método que cria a conexao com banco de dados.
  Future<dynamic> createConnection();

  Future<dynamic> get connection;
}