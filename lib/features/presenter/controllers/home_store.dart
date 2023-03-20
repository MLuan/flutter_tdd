import 'package:flutter_triple/flutter_triple.dart';
import 'package:unit_test_learning/core/errors/failures.dart';
import 'package:unit_test_learning/features/domain/entities/space_media_entity.dart';
import 'package:unit_test_learning/features/domain/usecases/get_space_media_from_date_usecase.dart';

class HomeStore extends NotifierStore<Failure, SpaceMediaEntity> {
  final GetSpaceMediaFromDateUsecase usecase;

  HomeStore(this.usecase)
      : super(
          SpaceMediaEntity(
            description: 'description',
            mediaType: 'mediaType',
            title: 'title',
            mediaUrl: ' mediaUrl',
          ),
        );

  getSpaceMediaFromDate(DateTime? date) async {
    setLoading(true);

    final result = await usecase(date);

    result.fold(
      (error) => setError(error),
      (spaceMediaEntity) => update(spaceMediaEntity),
    );

    setLoading(false);
  }
}
