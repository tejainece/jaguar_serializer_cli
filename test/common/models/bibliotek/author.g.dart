// GENERATED CODE - DO NOT MODIFY BY HAND

part of serializer.test.models.Author;

// **************************************************************************
// Generator: JaguarSerializerGenerator
// **************************************************************************

abstract class _$AuthorSerializer implements Serializer<Author> {
  Map toMap(Author model, {bool withType: false, String typeKey}) {
    Map<String, dynamic> ret;
    if (model != null) {
      ret = <String, dynamic>{};
      setNonNullableValue(ret, "name", model.name);
      if (modelString() != null && withType) {
        ret[typeKey ?? defaultTypeInfoKey] = modelString();
      }
    }
    return ret;
  }

  Author fromMap(Map map, {Author model, String typeKey}) {
    if (map is! Map) {
      return null;
    }
    if (model is! Author) {
      model = createModel();
    }
    model.name = map["name"];
    return model;
  }

  String modelString() => "Author";
}
