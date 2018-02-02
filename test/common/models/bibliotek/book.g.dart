// GENERATED CODE - DO NOT MODIFY BY HAND

part of serializer.test.models.book;

// **************************************************************************
// Generator: JaguarSerializerGenerator
// **************************************************************************

abstract class _$BookSerializer implements Serializer<Book> {
  final _mapKeyNumToStringProcessor = const MapKeyNumToStringProcessor();
  final _authorSerializer = new AuthorSerializer();

  Map toMap(Book model, {bool withType: false, String typeKey}) {
    Map<String, dynamic> ret;
    if (model != null) {
      ret = <String, dynamic>{};
      setNonNullableValue(ret, "name", model.name);
      setNonNullableValue(ret, "tags",
          safeIterableMapper<String>(model.tags, (String val) => val));
      setNonNullableValue(ret, "publishedDates",
          _mapKeyNumToStringProcessor.serialize(model.publishedDates));
      setNonNullableValue(
          ret,
          "authors",
          safeIterableMapper<Author>(
              model.authors,
              (Author val) => _authorSerializer.toMap(val,
                  withType: withType, typeKey: typeKey)));
      setTypeKeyValue(typeKey, modelString(), withType, ret);
    }
    return ret;
  }

  Book fromMap(Map map, {Book model, String typeKey}) {
    if (map is! Map) {
      return null;
    }
    if (model is! Book) {
      model = createModel();
    }
    model.name = map["name"];
    model.tags = safeIterableMapper<String>(map["tags"], (String val) => val);
    model.publishedDates =
        _mapKeyNumToStringProcessor.deserialize(map["publishedDates"]);
    model.authors = safeIterableMapper<Map>(map["authors"],
        (Map val) => _authorSerializer.fromMap(val, typeKey: typeKey));
    return model;
  }

  String modelString() => "Book";
}
