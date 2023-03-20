import 'package:dartz/dartz.dart';
import 'package:unit_test_learning/core/errors/exceptions.dart';
import 'package:unit_test_learning/core/errors/failures.dart';
import 'package:unit_test_learning/features/data/datasources/space_media_datasource.dart';
import 'package:unit_test_learning/features/domain/entities/space_media_entity.dart';
import 'package:unit_test_learning/features/domain/repository/i_space_media_repository.dart';

class SpaceMediaRepositoryImplementation implements ISpaceMediaRepository {
  final ISpaceMediaDatasource datasource;

  SpaceMediaRepositoryImplementation(this.datasource);

  @override
  Future<Either<Failure, SpaceMediaEntity>> getSpaceMediaFromDate(DateTime date) async {
    try {
      return Right(await datasource.getSpaceMediaFromDate(date));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
