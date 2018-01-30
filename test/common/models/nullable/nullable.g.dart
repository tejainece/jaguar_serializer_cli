// GENERATED CODE - DO NOT MODIFY BY HAND

part of serializer.test.nullable;

// **************************************************************************
// Generator: JaguarSerializerGenerator
// **************************************************************************

abstract class _$NullableGlobal implements Serializer<NullableGlobal> {
  Map toMap(NullableGlobal model, {bool withType: false, String typeKey}) {
    Map<String, dynamic> ret;
    if (model != null) {
      ret = <String, dynamic>{};
      setNullableValue(ret, "foo", model.foo);
      setNullableValue(ret, "bar", model.bar);
      setNullableValue(ret, "list",
          safeIterableMapper<String>(model.list, (String val) => val));
      if (modelString() != null && withType) {
        ret[typeKey ?? defaultTypeInfoKey] = modelString();
      }
    }
    return ret;
  }

  NullableGlobal fromMap(Map map, {NullableGlobal model, String typeKey}) {
    if (map is! Map) {
      return null;
    }
    if (model is! NullableGlobal) {
      model = createModel();
    }
    model.foo = map["foo"];
    model.bar = map["bar"];
    model.list = safeIterableMapper<String>(map["list"], (String val) => val);
    return model;
  }

  String modelString() => "NullableGlobal";
}

abstract class _$NullableGlobal1 implements Serializer<NullableGlobal1> {
  Map toMap(NullableGlobal1 model, {bool withType: false, String typeKey}) {
    Map<String, dynamic> ret;
    if (model != null) {
      ret = <String, dynamic>{};
      setNonNullableValue(ret, "foo", model.foo);
      setNullableValue(ret, "bar", model.bar);
      if (modelString() != null && withType) {
        ret[typeKey ?? defaultTypeInfoKey] = modelString();
      }
    }
    return ret;
  }

  NullableGlobal1 fromMap(Map map, {NullableGlobal1 model, String typeKey}) {
    if (map is! Map) {
      return null;
    }
    if (model is! NullableGlobal1) {
      model = createModel();
    }
    model.foo = map["foo"] ?? model.foo;
    model.bar = map["bar"];
    return model;
  }

  String modelString() => "NullableGlobal1";
}

abstract class _$NonNullableGlobal implements Serializer<NonNullableGlobal> {
  Map toMap(NonNullableGlobal model, {bool withType: false, String typeKey}) {
    Map<String, dynamic> ret;
    if (model != null) {
      ret = <String, dynamic>{};
      setNonNullableValue(ret, "foo", model.foo);
      setNonNullableValue(ret, "bar", model.bar);
      if (modelString() != null && withType) {
        ret[typeKey ?? defaultTypeInfoKey] = modelString();
      }
    }
    return ret;
  }

  NonNullableGlobal fromMap(Map map,
      {NonNullableGlobal model, String typeKey}) {
    if (map is! Map) {
      return null;
    }
    if (model is! NonNullableGlobal) {
      model = createModel();
    }
    model.foo = map["foo"] ?? model.foo;
    model.bar = map["bar"] ?? model.bar;
    return model;
  }

  String modelString() => "NonNullableGlobal";
}

abstract class _$NonNullableGlobal1 implements Serializer<NonNullableGlobal1> {
  Map toMap(NonNullableGlobal1 model, {bool withType: false, String typeKey}) {
    Map<String, dynamic> ret;
    if (model != null) {
      ret = <String, dynamic>{};
      setNullableValue(ret, "foo", model.foo);
      setNonNullableValue(ret, "bar", model.bar);
      if (modelString() != null && withType) {
        ret[typeKey ?? defaultTypeInfoKey] = modelString();
      }
    }
    return ret;
  }

  NonNullableGlobal1 fromMap(Map map,
      {NonNullableGlobal1 model, String typeKey}) {
    if (map is! Map) {
      return null;
    }
    if (model is! NonNullableGlobal1) {
      model = createModel();
    }
    model.foo = map["foo"];
    model.bar = map["bar"] ?? model.bar;
    return model;
  }

  String modelString() => "NonNullableGlobal1";
}

abstract class _$NonNullableComplex implements Serializer<NonNullableComplex> {
  final _timeToStringProcessor = const TimeToStringProcessor();

  Map toMap(NonNullableComplex model, {bool withType: false, String typeKey}) {
    Map<String, dynamic> ret;
    if (model != null) {
      ret = <String, dynamic>{};
      setNonNullableValue(
          ret, "f", _timeToStringProcessor.serialize(model.foo));
      setNullableValue(ret, "bar", model.bar);
      if (modelString() != null && withType) {
        ret[typeKey ?? defaultTypeInfoKey] = modelString();
      }
    }
    return ret;
  }

  NonNullableComplex fromMap(Map map,
      {NonNullableComplex model, String typeKey}) {
    if (map is! Map) {
      return null;
    }
    if (model is! NonNullableComplex) {
      model = createModel();
    }
    model.foo = _timeToStringProcessor.deserialize(map["f"]) ?? model.foo;
    model.bar = map["bar"];
    return model;
  }

  String modelString() => "NonNullableComplex";
}

abstract class _$NullableComplex implements Serializer<NullableComplex> {
  final _timeToStringProcessor = const TimeToStringProcessor();

  Map toMap(NullableComplex model, {bool withType: false, String typeKey}) {
    Map<String, dynamic> ret;
    if (model != null) {
      ret = <String, dynamic>{};
      setNullableValue(ret, "f", _timeToStringProcessor.serialize(model.foo));
      setNonNullableValue(ret, "bar", model.bar);
      if (modelString() != null && withType) {
        ret[typeKey ?? defaultTypeInfoKey] = modelString();
      }
    }
    return ret;
  }

  NullableComplex fromMap(Map map, {NullableComplex model, String typeKey}) {
    if (map is! Map) {
      return null;
    }
    if (model is! NullableComplex) {
      model = createModel();
    }
    model.foo = _timeToStringProcessor.deserialize(map["f"]);
    model.bar = map["bar"];
    return model;
  }

  String modelString() => "NullableComplex";
}

abstract class _$NullTestSerializer implements Serializer<NullTest> {
  final _modelIntSerializer = new ModelIntSerializer();

  Map toMap(NullTest model, {bool withType: false, String typeKey}) {
    Map<String, dynamic> ret;
    if (model != null) {
      ret = <String, dynamic>{};
      setNonNullableValue(ret, "tests",
          safeIterableMapper<String>(model.tests, (String val) => val));
      setNonNullableValue(ret, "test", model.test);
      setNonNullableValue(
          ret,
          "testModel",
          safeIterableMapper<ModelInt>(
              model.testModel,
              (ModelInt val) => _modelIntSerializer.toMap(val,
                  withType: withType, typeKey: typeKey)));
      if (modelString() != null && withType) {
        ret[typeKey ?? defaultTypeInfoKey] = modelString();
      }
    }
    return ret;
  }

  NullTest fromMap(Map map, {NullTest model, String typeKey}) {
    if (map is! Map) {
      return null;
    }
    if (model is! NullTest) {
      model = createModel();
    }
    model.tests = safeIterableMapper<String>(map["tests"], (String val) => val);
    model.test = map["test"];
    model.testModel = safeIterableMapper<Map>(map["testModel"],
        (Map val) => _modelIntSerializer.fromMap(val, typeKey: typeKey));
    return model;
  }

  String modelString() => "NullTest";
}
