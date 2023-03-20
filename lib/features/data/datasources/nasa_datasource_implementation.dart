import 'dart:convert';

import 'package:unit_test_learning/core/errors/exceptions.dart';
import 'package:unit_test_learning/core/http_client/http_client.dart';
import 'package:unit_test_learning/core/utils/converters/date_to_string_converter.dart';
import 'package:unit_test_learning/core/utils/keys/nasa_api_keys.dart';
import 'package:unit_test_learning/features/data/datasources/endpoints/nasa_endpoints.dart';
import 'package:unit_test_learning/features/data/datasources/space_media_datasource.dart';
import 'package:unit_test_learning/features/data/models/space_media_model.dart';

class NasaDatasourceImplementation extends ISpaceMediaDatasource {
  final HttpClient httpClient;

  NasaDatasourceImplementation(this.httpClient);

  @override
  Future<SpaceMediaModel> getSpaceMediaFromDate(DateTime date) async {
    final response = await httpClient.get(
      NasaEndpoints.apodEndpoints(NasaAPIKeys.apiKey, DateToStringConverter.convert(date)),
    );

    if (response.statusCode == 200) {
      return SpaceMediaModel.fromJson(jsonDecode(response.data));
    } else {
      throw ServerException();
    }
  }
}
