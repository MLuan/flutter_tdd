import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:unit_test_learning/features/data/models/space_media_model.dart';
import 'package:unit_test_learning/features/domain/entities/space_media_entity.dart';

import '../../../mocks/space_media_mock.dart';

void main() {
  const tSpaceMediaModel = SpaceMediaModel(
    description: 'Description Mock',
    mediaType: 'Type Mock',
    mediaUrl: 'URL Mock',
    title: 'Title Mock',
  );

  test('Should be a subclass of SpaceMediaEntity', () async {
    expect(tSpaceMediaModel, isA<SpaceMediaEntity>());
  });

  test(
    'Should return a valid model',
    () {
      final Map<String, dynamic> jsonMap = json.decode(spaceMediaMock);

      final result = SpaceMediaModel.fromJson(jsonMap);

      expect(result, tSpaceMediaModel);
    },
  );

  test(
    'Should return a json map containing the proper data',
    () async {
      final expectedMap = {
        "explanation": "Description Mock",
        "media_type": "Type Mock",
        "title": "Title Mock",
        "url": "URL Mock"
      };

      final result = tSpaceMediaModel.toJson();

      expect(result, expectedMap);
    },
  );
}
