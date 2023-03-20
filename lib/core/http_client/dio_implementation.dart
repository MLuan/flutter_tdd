import 'package:unit_test_learning/core/http_client/http_client.dart';
import 'package:dio/dio.dart';

class DioImplementation implements HttpClient {
  final dio = Dio();

  @override
  Future<HttpResponse> get(String url) async {
    final response = await dio.get(url);
    return HttpResponse(
      data: response.data,
      statusCode: response.statusCode,
    );
  }

  @override
  Future<HttpResponse> post(String url, {required Map<String, dynamic> body}) async {
    final response = await dio.post(url, data: body);
    return HttpResponse(
      data: response.data,
      statusCode: response.statusCode,
    );
  }
}
