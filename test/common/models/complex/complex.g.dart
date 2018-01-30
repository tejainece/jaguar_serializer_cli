// GENERATED CODE - DO NOT MODIFY BY HAND

part of serializer.test.complex;

// **************************************************************************
// Generator: JaguarSerializerGenerator
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
        ret["numSet"] = mapMaker<String, num>(
            model.numSet, (String key) => key, (num value) => value);
      }
      if (model.stringSet != null) {
        ret["stringSet"] = mapMaker<String, String>(
            model.stringSet, (String key) => key, (String value) => value);
      }
      if (model.boolSet != null) {
        ret["boolSet"] = mapMaker<String, bool>(
            model.boolSet, (String key) => key, (bool value) => value);
      }
      if (model.intSet != null) {
        ret["intSet"] = mapMaker<String, int>(
            model.intSet, (String key) => key, (int value) => value);
      }
      if (model.doubleSet != null) {
        ret["doubleSet"] = mapMaker<String, double>(
            model.doubleSet, (String key) => key, (double value) => value);
      }
      if (model.ignoreSet != null) {
        ret["ignoreSet"] = mapMaker<String, WithIgnore>(
            model.ignoreSet,
            (String key) => key,
            (WithIgnore value) => toWithIgnoreSerializer.toMap(value,
                withType: withType, typeKey: typeKey));
      }
      if (model.listInnerMap1 != null) {
        ret["listInnerMap1"] = mapMaker<String, List<String>>(
            model.listInnerMap1,
            (String key) => key,
            (List<String> value) =>
                value?.map((String val) => val != null ? val : null)?.toList());
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
    model.numSet = mapMaker<String, num>(
        map["numSet"], (String key) => key, (num value) => value) as dynamic;
    model.stringSet = mapMaker<String, String>(
            map["stringSet"], (String key) => key, (String value) => value)
        as dynamic;
    model.boolSet = mapMaker<String, bool>(
        map["boolSet"], (String key) => key, (bool value) => value) as dynamic;
    model.intSet = mapMaker<String, int>(
        map["intSet"], (String key) => key, (int value) => value) as dynamic;
    model.doubleSet = mapMaker<String, double>(
            map["doubleSet"], (String key) => key, (double value) => value)
        as dynamic;
    model.ignoreSet = mapMaker<String, Map>(
            map["ignoreSet"],
            (String key) => key,
            (Map value) =>
                fromWithIgnoreSerializer.fromMap(value, typeKey: typeKey))
        as dynamic;
    model.listInnerMap1 = mapMaker<String, List<String>>(
            map["listInnerMap1"],
            (String key) => key,
            (List<String> value) => value?.map((String val) => val)?.toList())
        as dynamic;
    model.dynamicMap = dynamicMapRawData.deserialize(map["dynamicMap"]);
    model.dynamicList = dynamicListRawData.deserialize(map["dynamicList"]);
    return model;
  }

  String modelString() => "Complex";
}
