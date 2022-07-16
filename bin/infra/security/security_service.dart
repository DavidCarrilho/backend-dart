abstract class SecurityService<T> {
  Future<String> generateJWT(String userID);
  T? validateJWT(String token) {

  }
}
