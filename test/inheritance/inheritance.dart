library serializer.test.models.player;

import 'package:jaguar_serializer/jaguar_serializer.dart';

part 'inheritance.g.dart';

@GenSerializer(fields: const {
  'foo': const EnDecode(alias: 'a'),
})
class ModelSerializerRename extends Serializer<Model>
    with _$ModelSerializerRename {
  Model createModel() => new Model();
}

class Base {
  String foo;
}

class Model implements Base {
  @override
  String foo;
}
