library serializer.test.models.book;

import '../../processors.dart';
import 'package:jaguar_serializer/jaguar_serializer.dart';
import 'author.dart';

export 'author.dart' show Author, AuthorSerializer;

part 'book.g.dart';

@GenSerializer(serializers: const [
  AuthorSerializer,
], fields: const {
  'publishedDates':
      const Property(processor: const MapKeyNumToStringProcessor())
})
class BookSerializer extends Serializer<Book> with _$BookSerializer {
  Book createModel() => new Book();
}

/// Player model for the game
class Book {
  /// Name of the player
  String name;

  List<String> tags;

  Map<num, String> publishedDates;

  List<Author> authors;
}
