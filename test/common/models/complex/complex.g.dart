// GENERATED CODE - DO NOT MODIFY BY HAND

part of serializer.test.complex;

// **************************************************************************
// Generator: SerializerGenerator
// **************************************************************************

abstract class _$ComplexSerializer implements Serializer<Complex> {
  final DateTimeProcessor datesDateTimeProcessor = const DateTimeProcessor();
  final RawData dynamicMapRawData = const RawData();
  final RawData dynamicListRawData = const RawData();
  final WithIgnoreSerializer toWithIgnoreSerializer =
      new WithIgnoreSerializer();
  final WithIgnoreSerializer fromWithIgnoreSerializer =
      new WithIgnoreSerializer();

  Map toMap(Complex model, {bool withType: false, String typeKey}) {
    Map ret = new Map();
    if (model != null) {
      if (model.nums != null) {
        ret["nums"] =
            model.nums?.map((num val) => val != null ? val : null)?.toList();
      }
      if (model.strings != null) {
        ret["strings"] = model.strings
            ?.map((String val) => val != null ? val : null)
            ?.toList();
      }
      if (model.bools != null) {
        ret["bools"] =
            model.bools?.map((bool val) => val != null ? val : null)?.toList();
      }
      if (model.ints != null) {
        ret["ints"] =
            model.ints?.map((int val) => val != null ? val : null)?.toList();
      }
      if (model.doubles != null) {
        ret["doubles"] = model.doubles
            ?.map((double val) => val != null ? val : null)
            ?.toList();
      }
      if (model.ignores != null) {
        ret["ignores"] = model.ignores
            ?.map((WithIgnore val) => val != null
                ? toWithIgnoreSerializer.toMap(val,
                    withType: withType, typeKey: typeKey)
                : null)
            ?.toList();
      }
      if (model.numSet != null) {
        ret["numSet"] =
            new MapMaker(model.numSet, (String key) => key, (num value) {
          return value;
        }).model;
      }
      if (model.stringSet != null) {
        ret["stringSet"] =
            new MapMaker(model.stringSet, (String key) => key, (String value) {
          return value;
        }).model;
      }
      if (model.boolSet != null) {
        ret["boolSet"] =
            new MapMaker(model.boolSet, (String key) => key, (bool value) {
          return value;
        }).model;
      }
      if (model.intSet != null) {
        ret["intSet"] =
            new MapMaker(model.intSet, (String key) => key, (int value) {
          return value;
        }).model;
      }
      if (model.doubleSet != null) {
        ret["doubleSet"] =
            new MapMaker(model.doubleSet, (String key) => key, (double value) {
          return value;
        }).model;
      }
      if (model.ignoreSet != null) {
        ret["ignoreSet"] = new MapMaker(model.ignoreSet, (String key) => key,
            (WithIgnore value) {
          return toWithIgnoreSerializer.toMap(value,
              withType: withType, typeKey: typeKey);
        }).model;
      }
      if (model.listInnerMap1 != null) {
        ret["listInnerMap1"] = new MapMaker(
            model.listInnerMap1, (String key) => key, (List<String> value) {
          return value?.map((String val) => val != null ? val : null)?.toList();
        }).model;
      }
      if (model.dynamicMap != null) {
        ret["dynamicMap"] = dynamicMapRawData.serialize(model.dynamicMap);
      }
      if (model.dynamicList != null) {
        ret["dynamicList"] = dynamicListRawData.serialize(model.dynamicList);
      }
      if (modelString() != null && withType) {
        ret[typeKey ?? defaultTypeInfoKey] = modelString();
      }
    }
    return ret;
  }

  Complex fromMap(Map map, {Complex model, String typeKey}) {
    if (map is! Map) {
      return null;
    }
    if (model is! Complex) {
      model = createModel();
    }
    model.nums = map["nums"]?.map((num val) => val)?.toList();
    model.strings = map["strings"]?.map((String val) => val)?.toList();
    model.bools = map["bools"]?.map((bool val) => val)?.toList();
    model.ints = map["ints"]?.map((int val) => val)?.toList();
    model.doubles = map["doubles"]?.map((double val) => val)?.toList();
    model.ignores = map["ignores"]
        ?.map((Map val) =>
            fromWithIgnoreSerializer.fromMap(val, typeKey: typeKey))
        ?.toList();
    model.numSet =
        new MapMaker(map["numSet"], (String key) => key, (num value) {
      return value;
    }).model as dynamic;
    model.stringSet =
        new MapMaker(map["stringSet"], (String key) => key, (String value) {
      return value;
    }).model as dynamic;
    model.boolSet =
        new MapMaker(map["boolSet"], (String key) => key, (bool value) {
      return value;
    }).model as dynamic;
    model.intSet =
        new MapMaker(map["intSet"], (String key) => key, (int value) {
      return value;
    }).model as dynamic;
    model.doubleSet =
        new MapMaker(map["doubleSet"], (String key) => key, (double value) {
      return value;
    }).model as dynamic;
    model.ignoreSet =
        new MapMaker(map["ignoreSet"], (String key) => key, (Map value) {
      return fromWithIgnoreSerializer.fromMap(value, typeKey: typeKey);
    }).model as dynamic;
    model.listInnerMap1 = new MapMaker(
        map["listInnerMap1"], (String key) => key, (List<String> value) {
      return value?.map((String val) => val)?.toList();
    }).model as dynamic;
    model.dynamicMap = dynamicMapRawData.deserialize(map["dynamicMap"]);
    model.dynamicList = dynamicListRawData.deserialize(map["dynamicList"]);
    return model;
  }

  String modelString() => "Complex";
}
