// GENERATED CODE - DO NOT MODIFY BY HAND

part of serializer.test.nullable;

// **************************************************************************
// Generator: JaguarSerializerGenerator
// **************************************************************************

abstract class _$NullableGlobal implements Serializer<NullableGlobal> {
  Map toMap(NullableGlobal model, {bool withType: false, String typeKey}) {
    Map ret = new Map();
    if (model != null) {
      ret["foo"] = model.foo;
      ret["bar"] = model.bar;
      ret["list"] =
          model.list?.map((String val) => val != null ? val : null)?.toList();
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
    model.list = map["list"]?.map((String val) => val)?.toList();
    return model;
  }

  String modelString() => "NullableGlobal";
}

abstract class _$NullableGlobal1 implements Serializer<NullableGlobal1> {
  Map toMap(NullableGlobal1 model, {bool withType: false, String typeKey}) {
    Map ret = new Map();
    if (model != null) {
      if (model.foo != null) {
        ret["foo"] = model.foo;
      }
      ret["bar"] = model.bar;
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
    Map ret = new Map();
    if (model != null) {
      if (model.foo != null) {
        ret["foo"] = model.foo;
      }
      if (model.bar != null) {
        ret["bar"] = model.bar;
      }
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
    Map ret = new Map();
    if (model != null) {
      ret["foo"] = model.foo;
      if (model.bar != null) {
        ret["bar"] = model.bar;
      }
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
  final TimeToStringProcessor fooTimeToStringProcessor =
      const TimeToStringProcessor();

  Map toMap(NonNullableComplex model, {bool withType: false, String typeKey}) {
    Map ret = new Map();
    if (model != null) {
      if (model.foo != null) {
        ret["f"] = fooTimeToStringProcessor.serialize(model.foo);
      }
      ret["bar"] = model.bar;
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
    model.foo = fooTimeToStringProcessor.deserialize(map["f"]) ?? model.foo;
    model.bar = map["bar"];
    return model;
  }

  String modelString() => "NonNullableComplex";
}

abstract class _$NullableComplex implements Serializer<NullableComplex> {
  final TimeToStringProcessor fooTimeToStringProcessor =
      const TimeToStringProcessor();

  Map toMap(NullableComplex model, {bool withType: false, String typeKey}) {
    Map ret = new Map();
    if (model != null) {
      ret["f"] = fooTimeToStringProcessor.serialize(model.foo);
      if (model.bar != null) {
        ret["bar"] = model.bar;
      }
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
    model.foo = fooTimeToStringProcessor.deserialize(map["f"]);
    model.bar = map["bar"];
    return model;
  }

  String modelString() => "NullableComplex";
}

abstract class _$NullTestSerializer implements Serializer<NullTest> {
  final ModelIntSerializer toModelIntSerializer = new ModelIntSerializer();
  final ModelIntSerializer fromModelIntSerializer = new ModelIntSerializer();

  Map toMap(NullTest model, {bool withType: false, String typeKey}) {
    Map ret = new Map();
    if (model != null) {
      if (model.tests != null) {
        ret["tests"] = model.tests
            ?.map((String val) => val != null ? val : null)
            ?.toList();
      }
      if (model.test != null) {
        ret["test"] = model.test;
      }
      if (model.testModel != null) {
        ret["testModel"] = model.testModel
            ?.map((ModelInt val) => val != null
                ? toModelIntSerializer.toMap(val,
                    withType: withType, typeKey: typeKey)
                : null)
            ?.toList();
      }
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
    model.tests = map["tests"]?.map((String val) => val)?.toList();
    model.test = map["test"];
    model.testModel = map["testModel"]
        ?.map(
            (Map val) => fromModelIntSerializer.fromMap(val, typeKey: typeKey))
        ?.toList();
    return model;
  }

  String modelString() => "NullTest";
}
