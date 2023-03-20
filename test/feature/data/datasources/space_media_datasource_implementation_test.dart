import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:unit_test_learning/core/errors/exceptions.dart';
import 'package:unit_test_learning/core/http_client/http_client.dart';
import 'package:unit_test_learning/core/utils/converters/date_to_string_converter.dart';
import 'package:unit_test_learning/features/data/datasources/nasa_datasource_implementation.dart';
import 'package:unit_test_learning/features/data/models/space_media_model.dart';

import '../../../mocks/space_media_mock.dart';

class HttpClientMock extends Mock implements HttpClient {}

void main() {
  late NasaDatasourceImplementation datasource;
  late HttpClient httpClient;

  setUp(
    () {
      httpClient = HttpClientMock();
      datasource = NasaDatasourceImplementation(httpClient);
    },
  );

  final tDateTime = DateTime(2023, 02, 01);
  const String urlExpected = "https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&date=2023-02-01";
  DateToStringConverter.convert(tDateTime);

  void successMock() {
    when(() => httpClient.get(any())).thenAnswer(
      (_) async => HttpResponse(
        data: spaceMediaMock,
        statusCode: 200,
      ),
    );
  }

  test(
    'Should call the get method with correct url',
    () async {
      successMock();
      await datasource.getSpaceMediaFromDate(tDateTime);

      verify(() => httpClient.get(urlExpected)).called(1);
    },
  );

  test(
    'Should get space media model when successfull request',
    () async {
      successMock();

      const tSpaceMediaModelExpected = SpaceMediaModel(
        description: 'Description Mock',
        mediaType: 'Type Mock',
        title: 'Title Mock',
        mediaUrl: 'URL Mock',
      );

      final result = await datasource.getSpaceMediaFromDate(tDateTime);

      expect(result, tSpaceMediaModelExpected);
    },
  );

  test(
    'Should throw a ServerException when the call is unsuccessfull',
    () async {
      when(() => httpClient.get(any())).thenAnswer(
        (_) async => HttpResponse(
          data: 'Something went wrong',
          statusCode: 400,
        ),
      );

      final result = datasource.getSpaceMediaFromDate(tDateTime);

      expect(() => result, throwsA(ServerException()));
    },
  );
}
