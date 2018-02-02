// GENERATED CODE - DO NOT MODIFY BY HAND

part of serializer.test.complex;

// **************************************************************************
// Generator: JaguarSerializerGenerator
// **************************************************************************

abstract class _$ComplexSerializer implements Serializer<Complex> {
  final _dateTimeProcessor = const DateTimeProcessor();
  final _rawData = const RawData();
  final _withIgnoreSerializer = new WithIgnoreSerializer();

  Map toMap(Complex model, {bool withType: false, String typeKey}) {
    Map<String, dynamic> ret;
    if (model != null) {
      ret = <String, dynamic>{};
      setNonNullableValue(
          ret, "nums", safeIterableMapper<num>(model.nums, (num val) => val));
      setNonNullableValue(ret, "strings",
          safeIterableMapper<String>(model.strings, (String val) => val));
      setNonNullableValue(ret, "bools",
          safeIterableMapper<bool>(model.bools, (bool val) => val));
      setNonNullableValue(
          ret, "ints", safeIterableMapper<int>(model.ints, (int val) => val));
      setNonNullableValue(ret, "doubles",
          safeIterableMapper<double>(model.doubles, (double val) => val));
      setNonNullableValue(
          ret,
          "ignores",
          safeIterableMapper<WithIgnore>(
              model.ignores,
              (WithIgnore val) => _withIgnoreSerializer.toMap(val,
                  withType: withType, typeKey: typeKey)));
      setNonNullableValue(
          ret,
          "numSet",
          mapMaker<String, num>(
              model.numSet, (String key) => key, (num value) => value));
      setNonNullableValue(
          ret,
          "stringSet",
          mapMaker<String, String>(
              model.stringSet, (String key) => key, (String value) => value));
      setNonNullableValue(
          ret,
          "boolSet",
          mapMaker<String, bool>(
              model.boolSet, (String key) => key, (bool value) => value));
      setNonNullableValue(
          ret,
          "intSet",
          mapMaker<String, int>(
              model.intSet, (String key) => key, (int value) => value));
      setNonNullableValue(
          ret,
          "doubleSet",
          mapMaker<String, double>(
              model.doubleSet, (String key) => key, (double value) => value));
      setNonNullableValue(
          ret,
          "ignoreSet",
          mapMaker<String, WithIgnore>(
              model.ignoreSet,
              (String key) => key,
              (WithIgnore value) => _withIgnoreSerializer.toMap(value,
                  withType: withType, typeKey: typeKey)));
      setNonNullableValue(
          ret,
          "listInnerMap1",
          mapMaker<String, List<String>>(
              model.listInnerMap1,
              (String key) => key,
              (List<String> value) =>
                  safeIterableMapper<String>(value, (String val) => val)));
      setNonNullableValue(
          ret, "dynamicMap", _rawData.serialize(model.dynamicMap));
      setNonNullableValue(
          ret, "dynamicList", _rawData.serialize(model.dynamicList));
      setTypeKeyValue(typeKey, modelString(), withType, ret);
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
    model.nums = safeIterableMapper<num>(map["nums"], (num val) => val);
    model.strings =
        safeIterableMapper<String>(map["strings"], (String val) => val);
    model.bools = safeIterableMapper<bool>(map["bools"], (bool val) => val);
    model.ints = safeIterableMapper<int>(map["ints"], (int val) => val);
    model.doubles =
        safeIterableMapper<double>(map["doubles"], (double val) => val);
    model.ignores = safeIterableMapper<Map>(map["ignores"],
        (Map val) => _withIgnoreSerializer.fromMap(val, typeKey: typeKey));
    model.numSet = mapMaker<String, num>(
        map["numSet"], (String key) => key, (num value) => value);
    model.stringSet = mapMaker<String, String>(
        map["stringSet"], (String key) => key, (String value) => value);
    model.boolSet = mapMaker<String, bool>(
        map["boolSet"], (String key) => key, (bool value) => value);
    model.intSet = mapMaker<String, int>(
        map["intSet"], (String key) => key, (int value) => value);
    model.doubleSet = mapMaker<String, double>(
        map["doubleSet"], (String key) => key, (double value) => value);
    model.ignoreSet = mapMaker<String, Map>(
        map["ignoreSet"],
        (String key) => key,
        (Map value) => _withIgnoreSerializer.fromMap(value, typeKey: typeKey));
    model.listInnerMap1 = mapMaker<String, List<String>>(
        map["listInnerMap1"],
        (String key) => key,
        (List<String> value) =>
            safeIterableMapper<String>(value, (String val) => val));
    model.dynamicMap = _rawData.deserialize(map["dynamicMap"]);
    model.dynamicList = _rawData.deserialize(map["dynamicList"]);
    return model;
  }

  String modelString() => "Complex";
}
