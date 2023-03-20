import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:unit_test_learning/core/errors/failures.dart';
import 'package:unit_test_learning/features/domain/repository/i_space_media_repository.dart';
import 'package:unit_test_learning/features/domain/usecases/get_space_media_from_date_usecase.dart';

import '../../../mocks/date_mock.dart';
import '../../../mocks/space_media_entity_mock.dart';

class MockSpaceMediaRepository extends Mock implements ISpaceMediaRepository {}

void main() {
  late GetSpaceMediaFromDateUsecase usecase;
  late ISpaceMediaRepository repository;

  setUp(() {
    repository = MockSpaceMediaRepository();
    usecase = GetSpaceMediaFromDateUsecase(repository);
  });

  test(
    'Should get space media entity for a given date from the repository',
    () async {
      when(() => repository.getSpaceMediaFromDate(tDate)).thenAnswer(
        (_) async => const Right(tSpaceMedia),
      );

      final result = await usecase(tDate);

      expect(result, const Right(tSpaceMedia));
      verify(() => repository.getSpaceMediaFromDate(tDate)).called(1);
    },
  );

  test(
    'Should return a ServerFailure when don\'t  succeed',
    () async {
      when(() => repository.getSpaceMediaFromDate(tDate)).thenAnswer(
        (_) async => Left(ServerFailure()),
      );

      final result = await usecase(tDate);

      expect(result, Left(ServerFailure()));
      verify(() => repository.getSpaceMediaFromDate(tDate)).called(1);
    },
  );

  test(
    'Should return a NullParamFailure when receives a null param',
    () async {
      final result = await usecase(null);

      expect(result, Left(NullParamFailure()));
      verifyNever(() => repository.getSpaceMediaFromDate(tDate));
    },
  );
}
