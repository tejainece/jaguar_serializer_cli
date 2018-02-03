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
      setNullableValue(ret, "number", model.number);
      setTypeKeyValue(typeKey, modelString(), withType, ret);
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
      setNullableValue(ret, "name", model.name);
      setTypeKeyValue(typeKey, modelString(), withType, ret);
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
      setNullableValue(ret, "id", model.id);
      setNullableValue(
          ret,
          "list",
          nullableIterableMapper<InnerModel1>(
              model.list,
              (InnerModel1 val) => _innerModel1Serializer.toMap(val,
                  withType: withType, typeKey: typeKey)));
      setNullableValue(
          ret,
          "map",
          nullableMapMaker<InnerModel2>(
              model.map,
              (InnerModel2 value) => _innerModel2Serializer.toMap(value,
                  withType: withType, typeKey: typeKey)));
      setTypeKeyValue(typeKey, modelString(), withType, ret);
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
    model.list = nullableIterableMapper<Map>(map["list"],
        (Map val) => _innerModel1Serializer.fromMap(val, typeKey: typeKey));
    model.map = nullableMapMaker<Map>(map["map"],
        (Map value) => _innerModel2Serializer.fromMap(value, typeKey: typeKey));
    return model;
  }

  String modelString() => "OuterModel";
}
