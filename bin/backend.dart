import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

void main() async {
  final server = await shelf_io.serve((request) => Response(200, body: 'ok!'), "localhost", 8080);
  print('Nosso servidor foi iniciado http:localhost:8080');
}
