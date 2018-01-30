// GENERATED CODE - DO NOT MODIFY BY HAND

part of serializer.test.models.player;

// **************************************************************************
// Generator: JaguarSerializerGenerator
// **************************************************************************

abstract class _$InnerModel1Serializer implements Serializer<InnerModel1> {
  Map toMap(InnerModel1 model, {bool withType: false, String typeKey}) {
    Map<String, dynamic> ret;
    if (model != null) {
      ret = <String, dynamic>{};
      setNonNullableValue(ret, "number", model.number);
      if (modelString() != null && withType) {
        ret[typeKey ?? defaultTypeInfoKey] = modelString();
      }
    }
    return ret;
  }

  InnerModel1 fromMap(Map map, {InnerModel1 model, String typeKey}) {
    if (map is! Map) {
      return null;
    }
    if (model is! InnerModel1) {
      model = createModel();
    }
    model.number = map["number"];
    return model;
  }

  String modelString() => "InnerModel1";
}

abstract class _$InnerModel2Serializer implements Serializer<InnerModel2> {
  Map toMap(InnerModel2 model, {bool withType: false, String typeKey}) {
    Map<String, dynamic> ret;
    if (model != null) {
      ret = <String, dynamic>{};
      setNonNullableValue(ret, "name", model.name);
      if (modelString() != null && withType) {
        ret[typeKey ?? defaultTypeInfoKey] = modelString();
      }
    }
    return ret;
  }

  InnerModel2 fromMap(Map map, {InnerModel2 model, String typeKey}) {
    if (map is! Map) {
      return null;
    }
    if (model is! InnerModel2) {
      model = createModel();
    }
    model.name = map["name"];
    return model;
  }

  String modelString() => "InnerModel2";
}

abstract class _$OuterModelSerializer implements Serializer<OuterModel> {
  final _innerModel1Serializer = new InnerModel1Serializer();
  final _innerModel2Serializer = new InnerModel2Serializer();

  Map toMap(OuterModel model, {bool withType: false, String typeKey}) {
    Map<String, dynamic> ret;
    if (model != null) {
      ret = <String, dynamic>{};
      setNonNullableValue(ret, "id", model.id);
      setNonNullableValue(
          ret,
          "list",
          safeIterableMapper<InnerModel1>(
              model.list,
              (InnerModel1 val) => _innerModel1Serializer.toMap(val,
                  withType: withType, typeKey: typeKey)));
      setNonNullableValue(
          ret,
          "map",
          mapMaker<String, InnerModel2>(
              model.map,
              (String key) => key,
              (InnerModel2 value) => _innerModel2Serializer.toMap(value,
                  withType: withType, typeKey: typeKey)));
      if (modelString() != null && withType) {
        ret[typeKey ?? defaultTypeInfoKey] = modelString();
      }
    }
    return ret;
  }

  OuterModel fromMap(Map map, {OuterModel model, String typeKey}) {
    if (map is! Map) {
      return null;
    }
    if (model is! OuterModel) {
      model = createModel();
    }
    model.id = map["id"];
    model.list = safeIterableMapper<Map>(map["list"],
        (Map val) => _innerModel1Serializer.fromMap(val, typeKey: typeKey));
    model.map = mapMaker<String, Map>(map["map"], (String key) => key,
        (Map value) => _innerModel2Serializer.fromMap(value, typeKey: typeKey));
    return model;
  }

  String modelString() => "OuterModel";
}
