// GENERATED CODE - DO NOT MODIFY BY HAND

part of models;

// **************************************************************************
// Generator: SerializerGenerator
// Target: class PlayerCodec
// **************************************************************************

abstract class _$PlayerCodec implements Serializer<Player> {
  Map toMap(Player model, {bool withType: false, String typeKey}) {
    Map ret = new Map();
    if (model != null) {
      if (model.id != null) {
        ret["id"] = model.id;
      }
      if (model.name != null) {
        ret["name"] = model.name;
      }
      if (model.email != null) {
        ret["email"] = model.email;
      }
      if (modelString() != null && withType) {
        ret[typeKey ?? defaultTypeInfoKey] = modelString();
      }
    }
    return ret;
  }

  Player fromMap(Map map, {Player model, String typeKey}) {
    if (map is! Map) {
      return null;
    }
    if (model is! Player) {
      model = createModel();
    }
    model.id = map["id"];
    model.name = map["name"];
    model.email = map["email"];
    return model;
  }

  String modelString() => "Player";
}

// **************************************************************************
// Generator: SerializerGenerator
// Target: class PlayerIgnoreCodec
// **************************************************************************

abstract class _$PlayerIgnoreCodec implements Serializer<Player> {
  Map toMap(Player model, {bool withType: false, String typeKey}) {
    Map ret = new Map();
    if (model != null) {
      if (model.id != null) {
        ret["id"] = model.id;
      }
      if (model.name != null) {
        ret["name"] = model.name;
      }
      if (modelString() != null && withType) {
        ret[typeKey ?? defaultTypeInfoKey] = modelString();
      }
    }
    return ret;
  }

  Player fromMap(Map map, {Player model, String typeKey}) {
    if (map is! Map) {
      return null;
    }
    if (model is! Player) {
      model = createModel();
    }
    model.id = map["id"];
    model.name = map["name"];
    return model;
  }

  String modelString() => "Player";
}
