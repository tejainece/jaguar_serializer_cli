// GENERATED CODE - DO NOT MODIFY BY HAND

part of serializer.test.default_value;

// **************************************************************************
// Generator: JaguarSerializerGenerator
// **************************************************************************

abstract class _$DefaultValue implements Serializer<DefaultValue> {
  Map toMap(DefaultValue model, {bool withType: false, String typeKey}) {
    Map<String, dynamic> ret;
    if (model != null) {
      ret = <String, dynamic>{};
      setNonNullableValue(ret, "foo", model.foo);
      setNonNullableValue(ret, "bar", model.bar);
      setNonNullableValue(ret, "list",
          safeIterableMapper<String>(model.list, (String val) => val));
      if (modelString() != null && withType) {
        ret[typeKey ?? defaultTypeInfoKey] = modelString();
      }
    }
    return ret;
  }

  DefaultValue fromMap(Map map, {DefaultValue model, String typeKey}) {
    if (map is! Map) {
      return null;
    }
    if (model is! DefaultValue) {
      model = createModel();
    }
    model.foo = map["foo"] ?? model.foo;
    model.bar = map["bar"];
    model.list = safeIterableMapper<String>(map["list"], (String val) => val) ??
        model.list;
    return model;
  }

  String modelString() => "DefaultValue";
}

abstract class _$DefaultString implements Serializer<DefaultString> {
  Map toMap(DefaultString model, {bool withType: false, String typeKey}) {
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

  DefaultString fromMap(Map map, {DefaultString model, String typeKey}) {
    if (map is! Map) {
      return null;
    }
    if (model is! DefaultString) {
      model = createModel();
    }
    model.foo = map["foo"] ?? "bar";
    model.bar = map["bar"];
    return model;
  }

  String modelString() => "DefaultString";
}

abstract class _$DefaultInt implements Serializer<DefaultInt> {
  Map toMap(DefaultInt model, {bool withType: false, String typeKey}) {
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

  DefaultInt fromMap(Map map, {DefaultInt model, String typeKey}) {
    if (map is! Map) {
      return null;
    }
    if (model is! DefaultInt) {
      model = createModel();
    }
    model.foo = map["foo"] ?? 42;
    model.bar = map["bar"];
    return model;
  }

  String modelString() => "DefaultInt";
}

abstract class _$DefaultDouble implements Serializer<DefaultDouble> {
  Map toMap(DefaultDouble model, {bool withType: false, String typeKey}) {
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

  DefaultDouble fromMap(Map map, {DefaultDouble model, String typeKey}) {
    if (map is! Map) {
      return null;
    }
    if (model is! DefaultDouble) {
      model = createModel();
    }
    model.foo = map["foo"] ?? 42.42;
    model.bar = map["bar"];
    return model;
  }

  String modelString() => "DefaultDouble";
}

abstract class _$DefaultBool implements Serializer<DefaultBool> {
  Map toMap(DefaultBool model, {bool withType: false, String typeKey}) {
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

  DefaultBool fromMap(Map map, {DefaultBool model, String typeKey}) {
    if (map is! Map) {
      return null;
    }
    if (model is! DefaultBool) {
      model = createModel();
    }
    model.foo = map["foo"] ?? true;
    model.bar = map["bar"];
    return model;
  }

  String modelString() => "DefaultBool";
}

abstract class _$DefaultDate implements Serializer<DefaultDate> {
  final _dateTimeProcessor = const DateTimeProcessor();

  Map toMap(DefaultDate model, {bool withType: false, String typeKey}) {
    Map<String, dynamic> ret;
    if (model != null) {
      ret = <String, dynamic>{};
      setNonNullableValue(ret, "f", _dateTimeProcessor.serialize(model.foo));
      setNonNullableValue(ret, "bar", model.bar);
      if (modelString() != null && withType) {
        ret[typeKey ?? defaultTypeInfoKey] = modelString();
      }
    }
    return ret;
  }

  DefaultDate fromMap(Map map, {DefaultDate model, String typeKey}) {
    if (map is! Map) {
      return null;
    }
    if (model is! DefaultDate) {
      model = createModel();
    }
    model.foo =
        _dateTimeProcessor.deserialize(map["f"] ?? "1994-03-29T06:00:00Z");
    model.bar = map["bar"];
    return model;
  }

  String modelString() => "DefaultDate";
}
