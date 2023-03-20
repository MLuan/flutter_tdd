import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:unit_test_learning/core/errors/exceptions.dart';
import 'package:unit_test_learning/core/errors/failures.dart';
import 'package:unit_test_learning/features/data/datasources/space_media_datasource.dart';
import 'package:unit_test_learning/features/data/models/space_media_model.dart';
import 'package:unit_test_learning/features/data/repositories/space_media_repository_implementation.dart';

class MockSpaceMediaDatasource extends Mock implements ISpaceMediaDatasource {}

void main() {
  late SpaceMediaRepositoryImplementation repository;
  late ISpaceMediaDatasource datasource;

  setUp(() {
    datasource = MockSpaceMediaDatasource();
    repository = SpaceMediaRepositoryImplementation(datasource);
  });

  const tSpaceMediaModel = SpaceMediaModel(
    description: 'Description Mock',
    mediaType: 'Type Mock',
    mediaUrl: 'URL Mock',
    title: 'Title Mock',
  );

  final DateTime tDate = DateTime(2023, 02, 01);

  test(
    'Should return space media model when calls the datasource',
    () async {
      when(() => datasource.getSpaceMediaFromDate(tDate)).thenAnswer(
        (_) async => tSpaceMediaModel,
      );

      final result = await repository.getSpaceMediaFromDate(tDate);

      expect(result, const Right(tSpaceMediaModel));

      verify(() => datasource.getSpaceMediaFromDate(tDate)).called(1);
    },
  );

  test(
    'Should return a server Failure when call the to datasource is unsuccessful',
    () async {
      when(() => datasource.getSpaceMediaFromDate(tDate)).thenThrow(ServerException());

      final result = await repository.getSpaceMediaFromDate(tDate);

      expect(result, Left(ServerFailure()));
      verify(() => datasource.getSpaceMediaFromDate(tDate)).called(1);
    },
  );
}
