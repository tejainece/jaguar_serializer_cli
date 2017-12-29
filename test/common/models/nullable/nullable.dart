library serializer.test.nullable;

import '../base/base.dart';

import 'package:jaguar_serializer/jaguar_serializer.dart';

part 'nullable.g.dart';

class NullTest {
  List<String> tests = null;
  String test = null;
  List<ModelInt> testModel = null;

  NullTest();
}

@GenSerializer(nullableFields: true, fields: const {
  'foo': const Property(valueFromConstructor: true),
  'list': const Property(valueFromConstructor: true),
  'bar': const Property(valueFromConstructor: true)
})
class NullableGlobal extends Serializer<NullableGlobal> with _$NullableGlobal {
  String foo;
  String bar;
  List<String> list;

  NullableGlobal(
      {this.foo: "bar", this.bar: "foo", this.list: const ["foo", "bar"]});

  @override
  NullableGlobal createModel() => new NullableGlobal();
}

@GenSerializer(
    nullableFields: true, fields: const {'foo': useConstructorForDefaultsValue})
class NullableGlobal1 extends Serializer<NullableGlobal1>
    with _$NullableGlobal1 {
  String foo;
  String bar;

  NullableGlobal1({this.foo: "bar", this.bar: "foo"});

  @override
  NullableGlobal1 createModel() => new NullableGlobal1();
}

@GenSerializer(fields: const {
  'foo': useConstructorForDefaultsValue,
  'bar': useConstructorForDefaultsValue
})
class NonNullableGlobal extends Serializer<NonNullableGlobal>
    with _$NonNullableGlobal {
  String foo;
  String bar;

  NonNullableGlobal({this.foo: "bar", this.bar: "foo"});

  @override
  NonNullableGlobal createModel() => new NonNullableGlobal();
}

@GenSerializer(fields: const {
  'foo': const Property(isNullable: true),
  'bar': useConstructorForDefaultsValue
})
class NonNullableGlobal1 extends Serializer<NonNullableGlobal1>
    with _$NonNullableGlobal1 {
  String foo;
  String bar;

  NonNullableGlobal1({this.foo: "bar", this.bar: "foo"});

  @override
  NonNullableGlobal1 createModel() => new NonNullableGlobal1();
}

@GenSerializer(nullableFields: true, fields: const {
  'foo': const EnDecode(
      alias: "f",
      isNullable: false,
      processor: const TimeToStringProcessor(),
      valueFromConstructor: true)
})
class NonNullableComplex extends Serializer<NonNullableComplex>
    with _$NonNullableComplex {
  String foo;
  String bar;

  NonNullableComplex({this.foo: "1994-03-29T06:00:00Z", this.bar: "foo"});

  @override
  NonNullableComplex createModel() => new NonNullableComplex();
}

@GenSerializer(fields: const {
  'foo': const EnDecode(
      alias: "f",
      isNullable: true,
      processor: const TimeToStringProcessor(),
      valueFromConstructor: true)
})
class NullableComplex extends Serializer<NullableComplex>
    with _$NullableComplex {
  String foo;
  String bar;

  NullableComplex({this.foo: "1994-03-29T06:00:00Z", this.bar: "foo"});

  @override
  NullableComplex createModel() => new NullableComplex();
}

class TimeToStringProcessor implements FieldProcessor<String, int> {
  const TimeToStringProcessor();

  String deserialize(int input) {
    if (input == null) return null;
    return new DateTime.fromMillisecondsSinceEpoch(input).toIso8601String();
  }

  int serialize(String value) {
    return DateTime.parse(value).millisecondsSinceEpoch;
  }
}

@GenSerializer(serializers: const [
  ModelIntSerializer,
])
class NullTestSerializer extends Serializer<NullTest>
    with _$NullTestSerializer {
  @override
  NullTest createModel() => new NullTest();
}