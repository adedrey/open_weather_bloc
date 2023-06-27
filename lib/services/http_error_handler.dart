import 'package:http/http.dart' as http;

String httpErrorHandler(http.Response response) {
  final responseStatus = response.statusCode;
  final responseRephrase = response.reasonPhrase;

  final errorMessage =
      'Request failed\nStatus code: $responseStatus\nReason: $responseRephrase';
  return errorMessage;
}
