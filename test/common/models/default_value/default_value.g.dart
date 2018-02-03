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
      setNullableValue(ret, "foo", model.foo);
      setNullableValue(ret, "bar", model.bar);
      setNullableValue(ret, "list",
          nullableIterableMapper<String>(model.list, (String val) => val));
      setTypeKeyValue(typeKey, modelString(), withType, ret);
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
    model.list = nonNullableIterableMapper<String>(
        map["list"], (String val) => val, model.list);
    return model;
  }

  String modelString() => "DefaultValue";
}

abstract class _$DefaultString implements Serializer<DefaultString> {
  Map toMap(DefaultString model, {bool withType: false, String typeKey}) {
    Map<String, dynamic> ret;
    if (model != null) {
      ret = <String, dynamic>{};
      setNullableValue(ret, "foo", model.foo);
      setNullableValue(ret, "bar", model.bar);
      setTypeKeyValue(typeKey, modelString(), withType, ret);
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
      setNullableValue(ret, "foo", model.foo);
      setNullableValue(ret, "bar", model.bar);
      setTypeKeyValue(typeKey, modelString(), withType, ret);
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
      setNullableValue(ret, "foo", model.foo);
      setNullableValue(ret, "bar", model.bar);
      setTypeKeyValue(typeKey, modelString(), withType, ret);
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
      setNullableValue(ret, "foo", model.foo);
      setNullableValue(ret, "bar", model.bar);
      setTypeKeyValue(typeKey, modelString(), withType, ret);
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
