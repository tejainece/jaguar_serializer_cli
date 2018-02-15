library serializer.test.models.book;

import '../../processors.dart';
import 'package:jaguar_serializer/jaguar_serializer.dart';
import 'author.dart';

export 'author.dart' show Author, AuthorSerializer;

part 'book.g.dart';

@GenSerializer(serializers: const [
  AuthorSerializer,
], fields: const {
  'websites': const Property(processor: const UriProcessor()),
  'publishedDates': const Property(processor: const DateTimeProcessor())
})
class BookSerializer extends Serializer<Book> with _$BookSerializer {}

/// Player model for the game
class Book {
  /// Name of the player
  String name;

  List<String> tags;

  Map<String, DateTime> publishedDates;

  List<Author> authors;

  List<Uri> websites;
}

class UriProcessor implements FieldProcessor<Uri, String> {
  const UriProcessor();

  @override
  Uri deserialize(String value) {
    if (value == null) {
      return null;
    }

    try {
      return Uri.parse(value);
    } on FormatException {
      return null;
    }
  }

  @override
  String serialize(Uri value) {
    return value?.toString();
  }
}
