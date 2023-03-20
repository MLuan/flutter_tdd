import 'package:dartz/dartz.dart';
import 'package:unit_test_learning/core/errors/failures.dart';
import 'package:unit_test_learning/core/usecase/usecase.dart';
import 'package:unit_test_learning/features/domain/entities/space_media_entity.dart';
import 'package:unit_test_learning/features/domain/repository/i_space_media_repository.dart';

class GetSpaceMediaFromDateUsecase implements Usecase<SpaceMediaEntity, DateTime> {
  final ISpaceMediaRepository repository;

  GetSpaceMediaFromDateUsecase(this.repository);

  @override
  Future<Either<Failure, SpaceMediaEntity>> call(DateTime date) async {
    return await repository.getSpaceMediaFromDate(date);
  }
}
