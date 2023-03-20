import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:unit_test_learning/core/errors/failures.dart';
import 'package:unit_test_learning/features/domain/usecases/get_space_media_from_date_usecase.dart';
import 'package:unit_test_learning/features/presenter/controllers/home_store.dart';

import '../../../mocks/date_mock.dart';
import '../../../mocks/space_media_entity_mock.dart';

class MockGetSpaceMediaFromDateUsecase extends Mock implements GetSpaceMediaFromDateUsecase {}

void main() {
  late HomeStore homeStore;
  late GetSpaceMediaFromDateUsecase mockUsecase;

  setUp(
    () {
      mockUsecase = MockGetSpaceMediaFromDateUsecase();
      homeStore = HomeStore(mockUsecase);
    },
  );

  test(
    'Should return a SpaceMedia from the mockUsecase',
    () async {
      when(() => mockUsecase(any())).thenAnswer(
        (_) async => const Right(tSpaceMedia),
      );

      await homeStore.getSpaceMediaFromDate(tDate);

      homeStore.observer(
        onState: (state) {
          expect(state, tSpaceMedia);
          verify(() => mockUsecase(tDate)).called(1);
        },
      );
    },
  );

  final tFailure = ServerFailure();
  test(
    'Should return a Failure from the usecase when there is an error',
    () async {
      when(() => mockUsecase(any())).thenAnswer(
        (_) async => Left(tFailure),
      );

      await homeStore.getSpaceMediaFromDate(tDate);

      homeStore.observer(
        onError: (error) {
          expect(error, tFailure);
          verify(() => mockUsecase(tDate)).called(1);
        },
      );
    },
  );
}
