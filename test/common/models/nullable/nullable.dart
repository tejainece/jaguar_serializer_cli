library serializer.test.nullable;

import '../../processors.dart';
import '../base/base.dart';

import 'package:jaguar_serializer/jaguar_serializer.dart';

part 'nullable.g.dart';

class Model {
  String foo;
  ModelInt modelInt;
  DateTime date;
  List<ModelInt> listModelInt;
  Map<String, ModelInt> mapModelInt;
  List<DateTime> listDates;
  Map<String, DateTime> mapDates;
}

@GenSerializer(nullableFields: true, serializers: const [
  ModelIntSerializer
], fields: const {
  'date': const Property(processor: const DateTimeProcessor()),
  'listDates': const Property(processor: const DateTimeProcessor()),
  'mapDates': const Property(processor: const DateTimeProcessor())
})
class NullableSerializer extends Serializer<Model> with _$NullableSerializer {
  Model createModel() => new Model();
}

@GenSerializer(nullableFields: false, serializers: const [
  ModelIntSerializer
], fields: const {
  'date': const Property(processor: const DateTimeProcessor()),
  'listDates': const Property(processor: const DateTimeProcessor()),
  'mapDates': const Property(processor: const DateTimeProcessor())
})
class NonNullableSerializer extends Serializer<Model>
    with _$NonNullableSerializer {
  Model createModel() => new Model();
}
