// GENERATED CODE - DO NOT MODIFY BY HAND

part of serializer.test.models.book;

// **************************************************************************
// Generator: JaguarSerializerGenerator
// **************************************************************************

abstract class _$BookSerializer implements Serializer<Book> {
  final _uriProcessor = const UriProcessor();
  final _dateTimeProcessor = const DateTimeProcessor();
  final _authorSerializer = new AuthorSerializer();

  Map toMap(Book model, {bool withType: false, String typeKey}) {
    Map<String, dynamic> ret;
    if (model != null) {
      ret = <String, dynamic>{};
      setNullableValue(ret, "name", model.name);
      setNullableValue(ret, "tags",
          nullableIterableMapper<String>(model.tags, (String val) => val));
      setNullableValue(
          ret,
          "publishedDates",
          nullableMapMaker<DateTime>(model.publishedDates,
              (DateTime value) => _dateTimeProcessor.serialize(value)));
      setNullableValue(
          ret,
          "authors",
          nullableIterableMapper<Author>(
              model.authors,
              (Author val) => _authorSerializer.toMap(val,
                  withType: withType, typeKey: typeKey)));
      setNullableValue(
          ret,
          "websites",
          nullableIterableMapper<Uri>(
              model.websites, (Uri val) => _uriProcessor.serialize(val)));
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
    model.tags =
        nullableIterableMapper<String>(map["tags"], (String val) => val);
    model.publishedDates = nullableMapMaker<dynamic>(map["publishedDates"],
        (dynamic value) => _dateTimeProcessor.deserialize(value));
    model.authors = nullableIterableMapper<Map>(map["authors"],
        (Map val) => _authorSerializer.fromMap(val, typeKey: typeKey));
    model.websites = nullableIterableMapper<dynamic>(
        map["websites"], (dynamic val) => _uriProcessor.deserialize(val));
    return model;
  }

  String modelString() => "Book";
}
