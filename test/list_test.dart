import 'common/models/bibliotek/bibliotek.dart';
import 'package:test/test.dart';

main() {
  group("List", () {
    group("To", () {
      Book book;

      setUp(() {
        book = new Book();

        book.name = 'Dawn of AI: The last few centuries of humanity';
        book.tags = <String>['AI', 'Humanity', 'SciFi'];
        book.publishedDates = <num, String>{
          1.1: '2010',
          2.1: '2016',
        };
        book.authors = <Author>[
          new Author()..name = 'Teja Hackborn',
          new Author()..name = 'Kleak',
        ];
      });

      test('toMap', () {
        BookSerializer serializer = new BookSerializer();
        Map map = serializer.toMap(book);

        expect(
            map,
            containsPair(
                'name', 'Dawn of AI: The last few centuries of humanity'));
        expect(map, containsPair('tags', <String>['AI', 'Humanity', 'SciFi']));
        expect(
            map,
            containsPair('publishedDates', {
              '1.1': '2010',
              '2.1': '2016',
            }));
        expect(
            map,
            containsPair('authors', [
              {'name': 'Teja Hackborn'},
              {'name': 'Kleak'}
            ]));
      });

      test('null list field', () {
        book.tags = null;

        BookSerializer serializer = new BookSerializer();
        Map map = serializer.toMap(book);

        expect(
            map,
            containsPair(
                'name', 'Dawn of AI: The last few centuries of humanity'));
        expect(map['tags'], isNull);
        expect(
            map,
            containsPair('publishedDates', {
              '1.1': '2010',
              '2.1': '2016',
            }));
        expect(
            map,
            containsPair('authors', [
              {'name': 'Teja Hackborn'},
              {'name': 'Kleak'}
            ]));
      });

      test('null item in list', () {
        book.authors.add(null);

        BookSerializer serializer = new BookSerializer();
        Map map = serializer.toMap(book);

        expect(
            map,
            containsPair(
                'name', 'Dawn of AI: The last few centuries of humanity'));
        expect(map, containsPair('tags', <String>['AI', 'Humanity', 'SciFi']));
        expect(
            map,
            containsPair('publishedDates', {
              '1.1': '2010',
              '2.1': '2016',
            }));
        expect(
            map,
            containsPair('authors', [
              {'name': 'Teja Hackborn'},
              {'name': 'Kleak'},
              null,
            ]));
      });
    });

    group("From", () {
      Map map;

      setUp(() {
        map = {
          'name': 'Dawn of AI: The last few centuries of humanity',
          'tags': ['AI', 'Humanity', 'SciFi'],
          'publishedDates': {
            1.0: '2010',
            2.0: '2016',
          },
          'authors': [
            {'name': 'Teja Hackborn'},
            {'name': 'Kleak'},
          ],
        };
      });

      test('fromMap', () {
        BookSerializer serializer = new BookSerializer();
        Book book = serializer.fromMap(map);

        expect(book.name, 'Dawn of AI: The last few centuries of humanity');
        expect(book.tags, <String>['AI', 'Humanity', 'SciFi']);
        expect(book.publishedDates, {
          1.0: '2010',
          2.0: '2016',
        });
        expect(book.authors, <Author>[
          new Author()..name = 'Teja Hackborn',
          new Author()..name = 'Kleak',
        ]);
      });

      test('null list field', () {
        map['tags'] = null;

        BookSerializer serializer = new BookSerializer();
        Book book = serializer.fromMap(map);

        expect(book.name, 'Dawn of AI: The last few centuries of humanity');
        expect(book.tags, isNull);
        expect(book.publishedDates, {
          1.0: '2010',
          2.0: '2016',
        });
        expect(book.authors, <Author>[
          new Author()..name = 'Teja Hackborn',
          new Author()..name = 'Kleak',
        ]);
      });

      test('null item in list', () {
        (map['authors'] as List).add(null);

        BookSerializer serializer = new BookSerializer();
        Book book = serializer.fromMap(map);

        expect(book.name, 'Dawn of AI: The last few centuries of humanity');
        expect(book.tags, <String>['AI', 'Humanity', 'SciFi']);
        expect(book.publishedDates, {
          1.0: '2010',
          2.0: '2016',
        });
        expect(book.authors, <Author>[
          new Author()..name = 'Teja Hackborn',
          new Author()..name = 'Kleak',
          null
        ]);
      });
    });
  });
}
