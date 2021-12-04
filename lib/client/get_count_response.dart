import 'package:interview/client/client_error.dart';

class GetCountResponse {
  GetCountResponse({
    this.count,
    this.error,
  });

  final int? count;

  final ClientError? error;

  bool get isSuccess => error == null && count != null;
}
