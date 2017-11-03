// GENERATED CODE - DO NOT MODIFY BY HAND

part of serializer.test.models.player;

// **************************************************************************
// Generator: SerializerGenerator
// Target: class ModelSerializerRename
// **************************************************************************

abstract class _$ModelSerializerRename implements Serializer<Model> {
  Map toMap(Model model, {bool withType: false, String typeKey}) {
    Map ret = new Map();
    if (model != null) {
      if (model.foo != null) {
        ret["a"] = model.foo;
      }
      if (modelString() != null && withType) {
        ret[typeKey ?? defaultTypeInfoKey] = modelString();
      }
    }
    return ret;
  }

  Model fromMap(Map map, {Model model, String typeKey}) {
    if (map is! Map) {
      return null;
    }
    if (model is! Model) {
      model = createModel();
    }
    model.foo = map["a"];
    return model;
  }

  String modelString() => "Model";
}
