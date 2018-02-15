// GENERATED CODE - DO NOT MODIFY BY HAND

part of serializer.test.immutable;

// **************************************************************************
// Generator: JaguarSerializerGenerator
// **************************************************************************

abstract class _$FooSerializer implements Serializer<Foo> {
  Map toMap(Foo model, {bool withType: false, String typeKey}) {
    Map<String, dynamic> ret;
    if (model != null) {
      ret = <String, dynamic>{};
      setNullableValue(ret, "bar", model.bar);
      setTypeKeyValue(typeKey, modelString(), withType, ret);
    }
    return ret;
  }

  Foo fromMap(Map map, {Foo model, String typeKey}) {
    if (map is! Map) {
      return null;
    }
    if (model is! Foo) {
      model = new Foo(map["bar"]);
    }
    return model;
  }

  String modelString() => "Foo";
}

abstract class _$FooNamedSerializer implements Serializer<FooNamed> {
  Map toMap(FooNamed model, {bool withType: false, String typeKey}) {
    Map<String, dynamic> ret;
    if (model != null) {
      ret = <String, dynamic>{};
      setNullableValue(ret, "bar", model.bar);
      setTypeKeyValue(typeKey, modelString(), withType, ret);
    }
    return ret;
  }

  FooNamed fromMap(Map map, {FooNamed model, String typeKey}) {
    if (map is! Map) {
      return null;
    }
    if (model is! FooNamed) {
      model = new FooNamed(bar: map["bar"]);
    }
    return model;
  }

  String modelString() => "FooNamed";
}

abstract class _$ComplexConstructorSerializer
    implements Serializer<ComplexConstructor> {
  final _fooSerializer = new FooSerializer();
  final _fooNamedSerializer = new FooNamedSerializer();

  Map toMap(ComplexConstructor model, {bool withType: false, String typeKey}) {
    Map<String, dynamic> ret;
    if (model != null) {
      ret = <String, dynamic>{};
      setNullableValue(ret, "foo", model.foo);
      setNullableValue(ret, "bar", model.bar);
      setNullableValue(ret, "is_okay", model.isOkay);
      setNullableValue(ret, "toto", model.toto);
      setNullableValue(
          ret,
          "foo_object",
          _fooSerializer.toMap(model.fooObject,
              withType: withType, typeKey: typeKey));
      setNullableValue(
          ret,
          "fooNamedObject",
          _fooNamedSerializer.toMap(model.fooNamedObject,
              withType: withType, typeKey: typeKey));
      setTypeKeyValue(typeKey, modelString(), withType, ret);
    }
    return ret;
  }

  ComplexConstructor fromMap(Map map,
      {ComplexConstructor model, String typeKey}) {
    if (map is! Map) {
      return null;
    }
    if (model is! ComplexConstructor) {
      model = new ComplexConstructor(map["foo"], map["toto"],
          _fooSerializer.fromMap(map["foo_object"], typeKey: typeKey),
          bar: map["bar"],
          isOkay: map["is_okay"],
          fooNamedObject: _fooNamedSerializer.fromMap(map["fooNamedObject"],
              typeKey: typeKey));
    }
    return model;
  }

  String modelString() => "ComplexConstructor";
}
