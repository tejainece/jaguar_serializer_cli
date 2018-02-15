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
      setNullableValue(ret, "name", model.name);
      setNullableValue(ret, "address",
          _address.toMap(model.address, withType: withType, typeKey: typeKey));
      setTypeKeyValue(typeKey, modelString(), withType, ret);
    }
    return ret;
  }

  Person fromMap(Map map, {Person model, String typeKey}) {
    if (map is! Map) {
      return null;
    }
    if (model is! Person) {
      model = new Person();
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
      setNullableValue(ret, "street", model.street);
      setNullableValue(ret, "houseNum", model.houseNum);
      setNullableValue(ret, "city", model.city);
      setNullableValue(ret, "country", model.country);
      setNullableValue(ret, "pincode", model.pincode);
      setTypeKeyValue(typeKey, modelString(), withType, ret);
    }
    return ret;
  }

  Address fromMap(Map map, {Address model, String typeKey}) {
    if (map is! Map) {
      return null;
    }
    if (model is! Address) {
      model = new Address();
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
