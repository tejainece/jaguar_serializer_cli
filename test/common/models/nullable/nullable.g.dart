// GENERATED CODE - DO NOT MODIFY BY HAND

part of serializer.test.nullable;

// **************************************************************************
// Generator: JaguarSerializerGenerator
// **************************************************************************

abstract class _$NullableSerializer implements Serializer<Model> {
  final _dateTimeProcessor = const DateTimeProcessor();
  final _modelIntSerializer = new ModelIntSerializer();

  Map toMap(Model model, {bool withType: false, String typeKey}) {
    Map<String, dynamic> ret;
    if (model != null) {
      ret = <String, dynamic>{};
      setNullableValue(ret, "foo", model.foo);
      setNullableValue(
          ret,
          "modelInt",
          _modelIntSerializer.toMap(model.modelInt,
              withType: withType, typeKey: typeKey));
      setNullableValue(ret, "date", _dateTimeProcessor.serialize(model.date));
      setNullableValue(
          ret,
          "listModelInt",
          nullableIterableMapper<ModelInt>(
              model.listModelInt,
              (ModelInt val) => _modelIntSerializer.toMap(val,
                  withType: withType, typeKey: typeKey)));
      setNullableValue(
          ret,
          "mapModelInt",
          nullableMapMaker<ModelInt>(
              model.mapModelInt,
              (ModelInt value) => _modelIntSerializer.toMap(value,
                  withType: withType, typeKey: typeKey)));
      setNullableValue(
          ret,
          "listDates",
          nullableIterableMapper<DateTime>(model.listDates,
              (DateTime val) => _dateTimeProcessor.serialize(val)));
      setNullableValue(
          ret,
          "mapDates",
          nullableMapMaker<DateTime>(model.mapDates,
              (DateTime value) => _dateTimeProcessor.serialize(value)));
      setTypeKeyValue(typeKey, modelString(), withType, ret);
    }
    return ret;
  }

  Model fromMap(Map map, {Model model, String typeKey}) {
    if (map is! Map) {
      return null;
    }
    if (model is! Model) {
      model = new Model();
    }
    model.foo = map["foo"];
    model.modelInt =
        _modelIntSerializer.fromMap(map["modelInt"], typeKey: typeKey);
    model.date = _dateTimeProcessor.deserialize(map["date"]);
    model.listModelInt = nullableIterableMapper<Map>(map["listModelInt"],
        (Map val) => _modelIntSerializer.fromMap(val, typeKey: typeKey));
    model.mapModelInt = nullableMapMaker<Map>(map["mapModelInt"],
        (Map value) => _modelIntSerializer.fromMap(value, typeKey: typeKey));
    model.listDates = nullableIterableMapper<dynamic>(
        map["listDates"], (dynamic val) => _dateTimeProcessor.deserialize(val));
    model.mapDates = nullableMapMaker<dynamic>(map["mapDates"],
        (dynamic value) => _dateTimeProcessor.deserialize(value));
    return model;
  }

  String modelString() => "Model";
}

abstract class _$NonNullableSerializer implements Serializer<Model> {
  final _dateTimeProcessor = const DateTimeProcessor();
  final _modelIntSerializer = new ModelIntSerializer();

  Map toMap(Model model, {bool withType: false, String typeKey}) {
    Map<String, dynamic> ret;
    if (model != null) {
      ret = <String, dynamic>{};
      setNonNullableValue(ret, "foo", model.foo);
      setNonNullableValue(
          ret,
          "modelInt",
          _modelIntSerializer.toMap(model.modelInt,
              withType: withType, typeKey: typeKey));
      setNonNullableValue(
          ret, "date", _dateTimeProcessor.serialize(model.date));
      setNonNullableValue(
          ret,
          "listModelInt",
          nonNullableIterableMapper<ModelInt>(
              model.listModelInt,
              (ModelInt val) => _modelIntSerializer.toMap(val,
                  withType: withType, typeKey: typeKey),
              []));
      setNonNullableValue(
          ret,
          "mapModelInt",
          nonNullableMapMaker<ModelInt>(
              model.mapModelInt,
              (ModelInt value) => _modelIntSerializer.toMap(value,
                  withType: withType, typeKey: typeKey),
              <String, dynamic>{}));
      setNonNullableValue(
          ret,
          "listDates",
          nonNullableIterableMapper<DateTime>(model.listDates,
              (DateTime val) => _dateTimeProcessor.serialize(val), []));
      setNonNullableValue(
          ret,
          "mapDates",
          nonNullableMapMaker<DateTime>(
              model.mapDates,
              (DateTime value) => _dateTimeProcessor.serialize(value),
              <String, dynamic>{}));
      setTypeKeyValue(typeKey, modelString(), withType, ret);
    }
    return ret;
  }

  Model fromMap(Map map, {Model model, String typeKey}) {
    if (map is! Map) {
      return null;
    }
    if (model is! Model) {
      model = new Model();
    }
    model.foo = map["foo"];
    model.modelInt =
        _modelIntSerializer.fromMap(map["modelInt"], typeKey: typeKey);
    model.date = _dateTimeProcessor.deserialize(map["date"]);
    model.listModelInt = nonNullableIterableMapper<Map>(map["listModelInt"],
        (Map val) => _modelIntSerializer.fromMap(val, typeKey: typeKey), []);
    model.mapModelInt = nonNullableMapMaker<Map>(
        map["mapModelInt"],
        (Map value) => _modelIntSerializer.fromMap(value, typeKey: typeKey),
        <String, dynamic>{});
    model.listDates = nonNullableIterableMapper<dynamic>(map["listDates"],
        (dynamic val) => _dateTimeProcessor.deserialize(val), []);
    model.mapDates = nonNullableMapMaker<dynamic>(
        map["mapDates"],
        (dynamic value) => _dateTimeProcessor.deserialize(value),
        <String, dynamic>{});
    return model;
  }

  String modelString() => "Model";
}
