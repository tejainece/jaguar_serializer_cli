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
      setNullableValue(ret, "nums",
          nullableIterableMapper<num>(model.nums, (num val) => val));
      setNullableValue(ret, "strings",
          nullableIterableMapper<String>(model.strings, (String val) => val));
      setNullableValue(ret, "bools",
          nullableIterableMapper<bool>(model.bools, (bool val) => val));
      setNullableValue(ret, "ints",
          nullableIterableMapper<int>(model.ints, (int val) => val));
      setNullableValue(ret, "doubles",
          nullableIterableMapper<double>(model.doubles, (double val) => val));
      setNullableValue(
          ret,
          "ignores",
          nullableIterableMapper<WithIgnore>(
              model.ignores,
              (WithIgnore val) => _withIgnoreSerializer.toMap(val,
                  withType: withType, typeKey: typeKey)));
      setNullableValue(ret, "numSet",
          nullableMapMaker<num>(model.numSet, (num value) => value));
      setNullableValue(ret, "stringSet",
          nullableMapMaker<String>(model.stringSet, (String value) => value));
      setNullableValue(ret, "boolSet",
          nullableMapMaker<bool>(model.boolSet, (bool value) => value));
      setNullableValue(ret, "intSet",
          nullableMapMaker<int>(model.intSet, (int value) => value));
      setNullableValue(ret, "doubleSet",
          nullableMapMaker<double>(model.doubleSet, (double value) => value));
      setNullableValue(
          ret,
          "ignoreSet",
          nullableMapMaker<WithIgnore>(
              model.ignoreSet,
              (WithIgnore value) => _withIgnoreSerializer.toMap(value,
                  withType: withType, typeKey: typeKey)));
      setNullableValue(
          ret,
          "listInnerMap1",
          nullableMapMaker<List<String>>(
              model.listInnerMap1,
              (List<String> value) =>
                  nullableIterableMapper<String>(value, (String val) => val)));
      setNullableValue(
          ret,
          "dynamicMap",
          nullableMapMaker<dynamic>(
              model.dynamicMap, (dynamic value) => _rawData.serialize(value)));
      setNullableValue(
          ret,
          "dynamicList",
          nullableIterableMapper<dynamic>(
              model.dynamicList, (dynamic val) => _rawData.serialize(val)));
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
    model.nums = nullableIterableMapper<num>(map["nums"], (num val) => val);
    model.strings =
        nullableIterableMapper<String>(map["strings"], (String val) => val);
    model.bools = nullableIterableMapper<bool>(map["bools"], (bool val) => val);
    model.ints = nullableIterableMapper<int>(map["ints"], (int val) => val);
    model.doubles =
        nullableIterableMapper<double>(map["doubles"], (double val) => val);
    model.ignores = nullableIterableMapper<Map>(map["ignores"],
        (Map val) => _withIgnoreSerializer.fromMap(val, typeKey: typeKey));
    model.numSet = nullableMapMaker<num>(map["numSet"], (num value) => value);
    model.stringSet =
        nullableMapMaker<String>(map["stringSet"], (String value) => value);
    model.boolSet =
        nullableMapMaker<bool>(map["boolSet"], (bool value) => value);
    model.intSet = nullableMapMaker<int>(map["intSet"], (int value) => value);
    model.doubleSet =
        nullableMapMaker<double>(map["doubleSet"], (double value) => value);
    model.ignoreSet = nullableMapMaker<Map>(map["ignoreSet"],
        (Map value) => _withIgnoreSerializer.fromMap(value, typeKey: typeKey));
    model.listInnerMap1 = nullableMapMaker<List<String>>(
        map["listInnerMap1"],
        (List<String> value) =>
            nullableIterableMapper<String>(value, (String val) => val));
    model.dynamicMap = nullableMapMaker<dynamic>(
        map["dynamicMap"], (dynamic value) => _rawData.deserialize(value));
    model.dynamicList = nullableIterableMapper<dynamic>(
        map["dynamicList"], (dynamic val) => _rawData.deserialize(val));
    return model;
  }

  String modelString() => "Complex";
}
