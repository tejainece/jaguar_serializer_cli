// GENERATED CODE - DO NOT MODIFY BY HAND

part of serializer.test.models.player;

// **************************************************************************
// Generator: JaguarSerializerGenerator
// **************************************************************************

abstract class _$InnerModel1Serializer implements Serializer<InnerModel1> {
  Map toMap(InnerModel1 model, {bool withType: false, String typeKey}) {
    Map ret = new Map();
    if (model != null) {
      if (model.number != null) {
        ret["number"] = model.number;
      }
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
    Map ret = new Map();
    if (model != null) {
      if (model.name != null) {
        ret["name"] = model.name;
      }
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
  final InnerModel1Serializer toInnerModel1Serializer =
      new InnerModel1Serializer();
  final InnerModel2Serializer toInnerModel2Serializer =
      new InnerModel2Serializer();
  final InnerModel1Serializer fromInnerModel1Serializer =
      new InnerModel1Serializer();
  final InnerModel2Serializer fromInnerModel2Serializer =
      new InnerModel2Serializer();

  Map toMap(OuterModel model, {bool withType: false, String typeKey}) {
    Map ret = new Map();
    if (model != null) {
      if (model.id != null) {
        ret["id"] = model.id;
      }
      if (model.list != null) {
        ret["list"] = model.list
            ?.map((InnerModel1 val) => val != null
                ? toInnerModel1Serializer.toMap(val,
                    withType: withType, typeKey: typeKey)
                : null)
            ?.toList();
      }
      if (model.map != null) {
        ret["map"] = mapMaker<String, InnerModel2>(
            model.map,
            (String key) => key,
            (InnerModel2 value) => toInnerModel2Serializer.toMap(value,
                withType: withType, typeKey: typeKey));
      }
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
    model.list = map["list"]
        ?.map((Map val) =>
            fromInnerModel1Serializer.fromMap(val, typeKey: typeKey))
        ?.toList();
    model.map = mapMaker<String, Map>(
            map["map"],
            (String key) => key,
            (Map value) =>
                fromInnerModel2Serializer.fromMap(value, typeKey: typeKey))
        as dynamic;
    return model;
  }

  String modelString() => "OuterModel";
}
