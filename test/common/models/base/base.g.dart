// GENERATED CODE - DO NOT MODIFY BY HAND

part of serializer.test.base;

// **************************************************************************
// Generator: JaguarSerializerGenerator
// **************************************************************************

abstract class _$ExcludeByDefaultCodec implements Serializer<ExcludeByDefault> {
  Map toMap(ExcludeByDefault model, {bool withType: false, String typeKey}) {
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

  ExcludeByDefault fromMap(Map map, {ExcludeByDefault model, String typeKey}) {
    if (map is! Map) {
      return null;
    }
    if (model is! ExcludeByDefault) {
      model = createModel();
    }
    model.id = map["id"];
    model.name = map["name"];
    return model;
  }

  String modelString() => "ExcludeByDefault";
}

abstract class _$ModelIntSerializer implements Serializer<ModelInt> {
  Map toMap(ModelInt model, {bool withType: false, String typeKey}) {
    Map ret = new Map();
    if (model != null) {
      if (model.bar != null) {
        ret["bar"] = model.bar;
      }
      if (model.clazzA != null) {
        ret["clazzA"] = model.clazzA;
      }
      if (modelString() != null && withType) {
        ret[typeKey ?? defaultTypeInfoKey] = modelString();
      }
    }
    return ret;
  }

  ModelInt fromMap(Map map, {ModelInt model, String typeKey}) {
    if (map is! Map) {
      return null;
    }
    if (model is! ModelInt) {
      model = createModel();
    }
    model.bar = map["bar"];
    model.clazzA = map["clazzA"];
    return model;
  }

  String modelString() => "ModelInt";
}

abstract class _$ModelDoubleSerializer implements Serializer<ModelDouble> {
  Map toMap(ModelDouble model, {bool withType: false, String typeKey}) {
    Map ret = new Map();
    if (model != null) {
      if (model.bar != null) {
        ret["bar"] = model.bar;
      }
      if (model.clazzA != null) {
        ret["clazzA"] = model.clazzA;
      }
      if (modelString() != null && withType) {
        ret[typeKey ?? defaultTypeInfoKey] = modelString();
      }
    }
    return ret;
  }

  ModelDouble fromMap(Map map, {ModelDouble model, String typeKey}) {
    if (map is! Map) {
      return null;
    }
    if (model is! ModelDouble) {
      model = createModel();
    }
    model.bar = map["bar"];
    model.clazzA = map["clazzA"];
    return model;
  }

  String modelString() => "ModelDouble";
}

abstract class _$InheritanceSerializer implements Serializer<Inheritance> {
  Map toMap(Inheritance model, {bool withType: false, String typeKey}) {
    Map ret = new Map();
    if (model != null) {
      if (model.clazzA != null) {
        ret["clazzA"] = model.clazzA;
      }
      if (model.clazzB != null) {
        ret["clazzB"] = model.clazzB;
      }
      if (modelString() != null && withType) {
        ret[typeKey ?? defaultTypeInfoKey] = modelString();
      }
    }
    return ret;
  }

  Inheritance fromMap(Map map, {Inheritance model, String typeKey}) {
    if (map is! Map) {
      return null;
    }
    if (model is! Inheritance) {
      model = createModel();
    }
    model.clazzA = map["clazzA"];
    model.clazzB = map["clazzB"];
    return model;
  }

  String modelString() => "Inheritance";
}

abstract class _$DateSerializer implements Serializer<Date> {
  final DateTimeProcessor dateDateTimeProcessor = const DateTimeProcessor();

  Map toMap(Date model, {bool withType: false, String typeKey}) {
    Map ret = new Map();
    if (model != null) {
      if (model.date != null) {
        ret["date"] = dateDateTimeProcessor.serialize(model.date);
      }
      if (model.clazzA != null) {
        ret["clazzA"] = model.clazzA;
      }
      if (modelString() != null && withType) {
        ret[typeKey ?? defaultTypeInfoKey] = modelString();
      }
    }
    return ret;
  }

  Date fromMap(Map map, {Date model, String typeKey}) {
    if (map is! Map) {
      return null;
    }
    if (model is! Date) {
      model = createModel();
    }
    model.date = dateDateTimeProcessor.deserialize(map["date"]);
    model.clazzA = map["clazzA"];
    return model;
  }

  String modelString() => "Date";
}

abstract class _$WithIgnoreSerializer implements Serializer<WithIgnore> {
  Map toMap(WithIgnore model, {bool withType: false, String typeKey}) {
    Map ret = new Map();
    if (model != null) {
      if (model.a != null) {
        ret["a"] = model.a;
      }
      if (modelString() != null && withType) {
        ret[typeKey ?? defaultTypeInfoKey] = modelString();
      }
    }
    return ret;
  }

  WithIgnore fromMap(Map map, {WithIgnore model, String typeKey}) {
    if (map is! Map) {
      return null;
    }
    if (model is! WithIgnore) {
      model = createModel();
    }
    model.a = map["a"];
    return model;
  }

  String modelString() => "WithIgnore";
}

abstract class _$ModelRenamedSerializer implements Serializer<ModelRenamed> {
  Map toMap(ModelRenamed model, {bool withType: false, String typeKey}) {
    Map ret = new Map();
    if (model != null) {
      if (model.original != null) {
        ret["renamed"] = model.original;
      }
      if (modelString() != null && withType) {
        ret[typeKey ?? defaultTypeInfoKey] = modelString();
      }
    }
    return ret;
  }

  ModelRenamed fromMap(Map map, {ModelRenamed model, String typeKey}) {
    if (map is! Map) {
      return null;
    }
    if (model is! ModelRenamed) {
      model = createModel();
    }
    model.original = map["renamed"];
    return model;
  }

  String modelString() => "ModelRenamed";
}

abstract class _$CustomModelNameSerializer
    implements Serializer<CustomModelName> {
  Map toMap(CustomModelName model, {bool withType: false, String typeKey}) {
    Map ret = new Map();
    if (model != null) {
      if (model.foo != null) {
        ret["foo"] = model.foo;
      }
      if (modelString() != null && withType) {
        ret[typeKey ?? defaultTypeInfoKey] = modelString();
      }
    }
    return ret;
  }

  CustomModelName fromMap(Map map, {CustomModelName model, String typeKey}) {
    if (map is! Map) {
      return null;
    }
    if (model is! CustomModelName) {
      model = createModel();
    }
    model.foo = map["foo"];
    return model;
  }

  String modelString() => "MyCustomModelName";
}
