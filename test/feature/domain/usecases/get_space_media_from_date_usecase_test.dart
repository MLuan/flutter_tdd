import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:unit_test_learning/core/errors/failures.dart';
import 'package:unit_test_learning/features/domain/entities/space_media_entity.dart';
import 'package:unit_test_learning/features/domain/repository/i_space_media_repository.dart';
import 'package:unit_test_learning/features/domain/usecases/get_space_media_from_date_usecase.dart';

class MockSpaceMediaRepository extends Mock implements ISpaceMediaRepository {}

void main() {
  late GetSpaceMediaFromDateUsecase usecase;
  late ISpaceMediaRepository repository;

  setUp(() {
    repository = MockSpaceMediaRepository();
    usecase = GetSpaceMediaFromDateUsecase(repository);
  });

  const tSpaceMedia = SpaceMediaEntity(
    description: 'Descrição MOck',
    mediaType: 'png',
    title: 'Title mock',
    mediaUrl: 'UrlMock',
  );

  final tDate = DateTime(2023, 01, 01);

  test(
    'Should get space media entity for a given date from the repository',
    () async {
      when(() => repository.getSpaceMediaFromDate(tDate)).thenAnswer(
        (_) async => const Right(tSpaceMedia),
      );

      final result = await usecase(tDate);

      expect(result, const Right(tSpaceMedia));
      verify(() => repository.getSpaceMediaFromDate(tDate));
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
      verify(() => repository.getSpaceMediaFromDate(tDate));
    },
  );
}
