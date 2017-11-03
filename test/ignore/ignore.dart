library serializer.test.builtin.from;

import 'package:test/test.dart';

import '../model/model.dart';

void main() {
  group('Builtin', () {
    Map m;

    setUp(() {
      m = {
        'id': '25',
        'name': 'John',
        'email': 'john@noemail.com',
      };
    });

    // Check if fromMap converts all Map items to fields
    test('noIgnore.FromMap', () {
      final serializer = new PlayerCodec();
      Player player = serializer.fromMap(m);
      expect(player.id, '25');
      expect(player.name, 'John');
      expect(player.email, 'john@noemail.com');
    });

    // Check if fromMap converts all Map items to fields
    test('ignore.FromMap', () {
      final serializer = new PlayerIgnoreCodec();
      Player player = serializer.fromMap(m);
      expect(player.id, '25');
      expect(player.name, 'John');
      expect(player.email, null);
    });

    // Check if fromMap converts all Map items to fields
    test('fields.ignore.FromMap', () {
      final serializer = new PlayerIgnoreFieldCodec();
      Player player = serializer.fromMap(m);
      expect(player.id, '25');
      expect(player.name, 'John');
      expect(player.email, null);
    });

    // Check if fromMap converts all Map items to fields
    test('noIgnore.toMap', () {
      final serializer = new PlayerCodec();
      final player = new Player()
        ..id = '25'
        ..name = 'John'
        ..email = 'john@noemail.com';
      final Map map = serializer.toMap(player);
      expect(map.containsKey('id'), true);
      expect(map.containsKey('name'), true);
      expect(map.containsKey('email'), true);
    });

    // Check if fromMap converts all Map items to fields
    test('ignore.FromMap', () {
      final serializer = new PlayerIgnoreCodec();
      final player = new Player()
        ..id = '25'
        ..name = 'John'
        ..email = 'john@noemail.com';
      final Map map = serializer.toMap(player);
      expect(map.containsKey('id'), true);
      expect(map.containsKey('name'), true);
      expect(map.containsKey('email'), false);
    });

    // Check if fromMap converts all Map items to fields
    test('fields.ignore.FromMap', () {
      final serializer = new PlayerIgnoreFieldCodec();
      final player = new Player()
        ..id = '25'
        ..name = 'John'
        ..email = 'john@noemail.com';
      final Map map = serializer.toMap(player);
      expect(map.containsKey('id'), true);
      expect(map.containsKey('name'), true);
      expect(map.containsKey('email'), false);
    });
  });
}
