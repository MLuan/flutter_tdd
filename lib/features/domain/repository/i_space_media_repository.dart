import 'package:dartz/dartz.dart';
import 'package:unit_test_learning/core/errors/failures.dart';
import 'package:unit_test_learning/features/domain/entities/space_media_entity.dart';

abstract class ISpaceMediaRepository {
  Future<Either<Failure, SpaceMediaEntity>> getSpaceMediaFromDate(DateTime date);
}
