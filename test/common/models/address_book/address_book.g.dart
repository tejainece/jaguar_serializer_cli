// GENERATED CODE - DO NOT MODIFY BY HAND

part of test.common.models.address_book;

// **************************************************************************
// Generator: JaguarSerializerGenerator
// **************************************************************************

abstract class _$Person implements Serializer<Person> {
  final _address = new Address();

  Map toMap(Person model, {bool withType: false, String typeKey}) {
    Map<String, dynamic> ret;
    if (model != null) {
      ret = <String, dynamic>{};
      setNonNullableValue(ret, "name", model.name);
      setNonNullableValue(ret, "address",
          _address.toMap(model.address, withType: withType, typeKey: typeKey));
      if (modelString() != null && withType) {
        ret[typeKey ?? defaultTypeInfoKey] = modelString();
      }
    }
    return ret;
  }

  Person fromMap(Map map, {Person model, String typeKey}) {
    if (map is! Map) {
      return null;
    }
    if (model is! Person) {
      model = createModel();
    }
    model.name = map["name"];
    model.address = _address.fromMap(map["address"], typeKey: typeKey);
    return model;
  }

  String modelString() => "Person";
}

abstract class _$Address implements Serializer<Address> {
  Map toMap(Address model, {bool withType: false, String typeKey}) {
    Map<String, dynamic> ret;
    if (model != null) {
      ret = <String, dynamic>{};
      setNonNullableValue(ret, "street", model.street);
      setNonNullableValue(ret, "houseNum", model.houseNum);
      setNonNullableValue(ret, "city", model.city);
      setNonNullableValue(ret, "country", model.country);
      setNonNullableValue(ret, "pincode", model.pincode);
      if (modelString() != null && withType) {
        ret[typeKey ?? defaultTypeInfoKey] = modelString();
      }
    }
    return ret;
  }

  Address fromMap(Map map, {Address model, String typeKey}) {
    if (map is! Map) {
      return null;
    }
    if (model is! Address) {
      model = createModel();
    }
    model.street = map["street"];
    model.houseNum = map["houseNum"];
    model.city = map["city"];
    model.country = map["country"];
    model.pincode = map["pincode"];
    return model;
  }

  String modelString() => "Address";
}
